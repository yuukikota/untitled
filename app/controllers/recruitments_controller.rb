class RecruitmentsController < ApplicationController
  before_action :set_recruitment, only: [ :edit, :destroy]
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
        format.html { redirect_to root_path, notice: '募集が存在しません' }
        format.json { head :no_content }
      end
      return
    elsif !(account_signed_in? and @recruitment.acc_id == current_account.acc_id)
      respond_to do |format|
        format.html { redirect_to root_path, notice: '結果選択は募集者のみです' }
        format.json { head :no_content }
      end
      return
    end
    @comments = Comment.where(p_com_id: params[:id]).limit(20)  #20件を取得
  end

  #ajaxで動的に表示項目を追加する
  def add_result
    @comments = Comment.where(p_com_id: params[:id]).limit(20).offset(params[:size])
  end

  # POST /recruitments
  # POST /recruitments.json
  def create
    @recruitments = Recruitment.all
    @inputtag = Inputtag.new
    if account_signed_in? then
      @taghistoryid = Taghistoryid.new
      @inputtag.setuniv school: current_account.university, faculty: current_account.faculty, department: current_account.department
    end

    @recruitment = Recruitment.new(recruitment_params)
    @recruitment.acc_id = current_account.acc_id#アカウントID
    if @recruitment.detail.size ==0 || (@recruitment.detail.gsub(/\r\n|\r|\n|\s|\t/, "")).size==0
      @recruitment.detail = nil
    end

    if $view_com_num == '5'
      @recruitment.re_id  = '発言'
      @recruitment.title = "発言"
    else if  $view_com_num == '6'
           @recruitment.re_id  = '募集'
           @recruitment.resolved = '未解決'
         end
    end

    respond_to do |format|
      if @recruitment.save
        tagarry=[params[:school], params[:faculty], params[:department], params[:tag1], params[:tag2], params[:tag3], params[:tag4], params[:tag5], params[:tag6], params[:tag7]]
        Tagmap.associate(@recruitment.id, tagarry)
        format.html { redirect_to root_path, notice: '送信しました' }
        format.json { render :show, status: :created, location: @recruitment }
      else
        format.html { render :template => "mains/index" }
        format.json { render json: @recruitment.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /entry_chats/1
  # PATCH/PUT /entry_chats/1.json
  # 結果選択時のみ使用
  def update
    if @recruitment_params[:chat] == "有"
      if EntryChat.find_by(chat_id: @recruitment_params[:id]).nil?
        respond_to do |format|
          format.html { redirect_to new_entry_chats_path(@recruitment_params[:id]), notice: '結果を選択してください' }
          format.json { head :no_content }
        end
        return
      end
    elsif @recruitment_params[:chat] == "無"
      if @recruitment_params[:answer].blank?
        respond_to do |format|
          format.html { redirect_to edit_recruitment_path(@recruitment_params[:id]), notice: '結果を選択してください' }
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
    @recruitment.destroy
    Tagmap.delrelated(@recruitment.id)
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Recruitment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recruitment
      @recruitment = Recruitment.find(params[:id])
    end

    def add_answer
      @recruitment = Recruitment.find(params[:id])
      @recruitment_params = { "id":@recruitment.id,
                              "acc_id":@recruitment.acc_id,
                              "chat_id":@recruitment.chat_id,
                              "resolved":"解決",
                              "detail":@recruitment.detail,
                              "title":@recruitment.title,
                              "answer":params[:answer],
                              "file_id":@recruitment.file_id,
                              "chat":@recruitment.chat}
      if @recruitment_params[:chat] == "有"
        @recruitment_params[:answer] = "募集は終了しました"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recruitment_params
      params.require(:recruitment).permit(:acc_id, :chat_id, :resolved, :detail, :title, :answer, :file_id, :chat)
    end
end
