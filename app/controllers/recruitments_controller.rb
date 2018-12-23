class RecruitmentsController < ApplicationController
  before_action :set_recruitment, only: [ :edit, :add_result, :select, :selected, :destroy]
  before_action :add_answer, only: [:update]

  # GET /recruitments
  # GET /recruitments.json
  def index
    @recruitments = Recruitment.all
    @recruitments.order(updated_at: "DESC")
  end

  # GET /recruitments/1
  # GET /recruitments/1.json
  # チャット無しの結果選択表示
  def edit
    if @recruitment.nil?
      respond_to do |format|
        format.html { redirect_to root_path, alert: '募集が存在しません' }
        format.json { head :no_content }
      end
      return
    elsif !(account_signed_in? and @recruitment.acc_id == current_account.acc_id)
      respond_to do |format|
        format.html { redirect_to root_path, alert: '結果選択は募集者のみです' }
        format.json { head :no_content }
      end
      return
    end
    @comments = @recruitment.comments.limit(20) #20件を取得
  end

  #ajaxで動的に表示項目を追加する
  def add_result
    #ajax通信以外は弾く
    return redirect_to '/404.html' unless request.xhr?

    @comments = @recruitment.comments.where('updated_at > ?', Time.zone.parse(params[:offset_time])).limit(20)
  end

  # チャット無しの結果選択
  #ajaxで動的に選択
  def select
    #ajax通信以外は弾く
    return redirect_to '/404.html' unless request.xhr?

    if @recruitment.nil?
      respond_to do |format|
        format.html { redirect_to root_path, alert: '募集が存在しません' }
        format.json { head :no_content }
      end
    else
      @comment = Comment.find_by(id: params[:comment_id])
      @alert = nil
      @comment_id = params[:comment_id]
      if @comment.nil?
        @alert = '返信がありません'
      end
    end
  end

  # チャット無しの結果選択
  def selected
    #ajax通信以外は弾く
    return redirect_to '/404.html' unless request.xhr?

    if @recruitment.nil?
      respond_to do |format|
        format.html { redirect_to root_path, alert: '募集が存在しません' }
        format.json { head :no_content }
      end
    else
      @comment = Comment.find_by(id: params[:comment_id])
      @alert = nil
      @comment_id = params[:comment_id]
      if @comment.nil?
        @alert = '返信がありません'
      end
    end
  end

  # POST /recruitments
  # POST /recruitments.json
  def create

    @view_num = params[:view_num]
    @view_com_num = params[:id]
    @inputtag = Inputtag.new(inputtag_params)
    @inputtag.count_freetag

    @recruitment = Recruitment.new(recruitment_params)
    @recruitment.acc_id = current_account.acc_id#アカウントID
    @recruitment.account_id = current_account.id # アカウントの主キーのID 自動削除のため

    if @recruitment.detail.size ==0 || (@recruitment.detail.gsub(/\r\n|\r|\n|\s|\t/, "")).size==0
      @recruitment.detail = nil
    end

    if @view_com_num == '5'
      @recruitment.re_id  = '発言'
      @recruitment.title = "発言"
    else if  @view_com_num == '6'
           @recruitment.re_id  = '募集'
           @recruitment.resolved = '未解決'
         end
    end

    if @recruitment.photo_file_size != nil #ファイルがあった場合、file_idにurlを格納
      max_id = Recruitment.maximum(:id)
      if max_id.nil?
        @recruitment.file_id= "/assets/arts/1/original/" +@recruitment.photo_file_name
      else
        @recruitment.file_id= "/assets/arts/"+(max_id+1).to_s+"/original/" +@recruitment.photo_file_name
      end
    end

    if @recruitment.save
      #ファイル追加

      respond_to do |format|
        Tagmap.associate(@recruitment.id, @inputtag.tag_to_arry)
        if @recruitment.chat == "有"
          entry_chat = EntryChat.new(recruitment_id: @recruitment.id, account_id: @recruitment.account.id)
          entry_chat.save
        end
        format.html { redirect_to request_url(@inputtag.tag_to_arry, params[:view_num]), notice: '送信しました' }
        format.json { render :show, status: :created, location: @recruitment }
      end
    end
  end

  # PATCH/PUT /entry_chats/1
  # PATCH/PUT /entry_chats/1.json
  # 結果選択時のみ使用
  def update
    if @recruitment.chat == "有"
      if EntryChat.find_by(recruitment_id: @recruitment.id).nil?
        respond_to do |format|
          format.html { redirect_to new_entry_chats_path(@recruitment.id), alert: '結果を選択してください' }
          format.json { head :no_content }
        end
        return
      end
    elsif @recruitment.chat == "無"
      if @recruitment_params[:answer].blank?
        respond_to do |format|
          format.html { redirect_to edit_recruitment_path(@recruitment.id), alert: '結果を選択してください' }
          format.json { head :no_content }
        end
        return
      end
    end
    respond_to do |format|
      if @recruitment.update(@recruitment_params)
        format.html { redirect_to root_path, notice: '結果選択しました。募集を終了しました。' }
        format.json { render :show, status: :ok, location: @recruitment }
      else
        format.html { render :edit }
        format.json { render json: @recruitment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recruitments/1
  # DELETE /recruitments/1.json
  def destroy
    #ajax通信以外は弾く
    return redirect_to '/404.html' unless request.xhr?

    @alert = nil
    @recruitment_id = params[:id]

    if @recruitment.nil?
      @notice = 'すでに削除されています'
    else
      if @recruitment.destroy
        @notice = '削除されました'
      else
        @alert = '削除に失敗しました'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recruitment
      @recruitment = Recruitment.find_by(id: params[:id])
    end

    def add_answer
      @recruitment = Recruitment.find(params[:id])
      @recruitment_params = { "resolved":"解決",
                              "answer":recruitment_params[:answer]}
      if @recruitment_params[:chat] == "有"
        @recruitment_params[:answer] = "募集は終了しました"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.

    def recruitment_params
      params.require(:recruitment).permit(:acc_id, :resolved, :detail, :title, :answer, :file_id, :chat, :photo)
    end

    def inputtag_params
      params.permit(:school, :faculty, :department, :tag1, :tag2, :tag3, :tag4, :tag5, :tag6, :tag7, :tag8, :tag9, :tag10)
    end
    def arry_tag_params
      [params[:school],params[:faculty],params[:department],params[:tag1],params[:tag2],params[:tag3],params[:tag4],params[:tag5],params[:tag6],params[:tag7],params[:tag8],params[:tag9],params[:tag10]]
    end

    def request_url(tag,view_num)
      tag_url = "/?school="

      if tag[0].present? then
        tag_url = tag_url + tag[0]
      end
      tag_url = tag_url + "&faculty="
      if tag[1].present? then
        tag_url = tag_url + tag[1]
      end
      tag_url = tag_url + "&department="
      if tag[2].present? then
        tag_url = tag_url + tag[2]
      end

      for i in 1..10 do
        tag_url = tag_url + "&tag" + i.to_s + "="
        if tag[2 + i].present? then
          tag_url = tag_url + tag[2 + i]
        end
      end
      tag_url = tag_url + "&view_num="+view_num.to_s
      tag_url
    end
end
