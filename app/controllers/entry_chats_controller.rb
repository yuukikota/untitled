class EntryChatsController < ApplicationController
  before_action :set_entry_chat, only: [:show, :edit, :update, :destroy]

  # GET /entry_chats
  # GET /entry_chats.json
  def index
    @entry_chats = EntryChat.all
  end

  # GET /entry_chats/1
  # GET /entry_chats/1.json
  def show
  end

  # GET /entry_chats/new/:recruitment_id
  def new
    @recruitment = Recruitment.find_by(id: params[:recruitment_id]) # 元の募集を取得
    if @recruitment.nil?
      respond_to do |format|
        format.html { redirect_to root_path, notice: '募集が存在しません' }
        format.json { head :no_content }
      end
      return
    end

    @comments = @recruitment.comments.limit(20)  #返信20件を取得
    @entry_chat = EntryChat.new
  end

  # ajaxで動的に表示項目を追加する
  def add_result
    #ajax通信以外は弾く
    return redirect_to '/404.html' unless request.xhr?
    @recruitment = Recruitment.find_by(id: params[:recruitment_id]) # 元の募集を取得
    if @recruitment.nil?
      respond_to do |format|
        format.html { redirect_to root_path, notice: '返信先がありません' }
        format.json { head :no_content }
      end
      return
    end
    @comments = @recruitment.comments.where('updated_at > ?', Time.zone.parse(params[:offset_time])).limit(20)
    @entry_chat = EntryChat.new
  end

  # GET /entry_chats/1/edit
  def edit
  end

  # POST /entry_chats
  # POST /entry_chats.json
  def create
    #ajax通信以外は弾く
    return redirect_to '/404.html' unless request.xhr?

    if (recruitment = Recruitment.find_by(id: entry_chat_params[:recruitment_id])).nil?
      respond_to do |format|
        format.html { redirect_to root_path, notice: '募集が存在しません' }
        format.json { head :no_content }
      end
    elsif recruitment.account.id == entry_chat_params[:account_id]
      respond_to do |format|
        format.html { redirect_to root_path, notice: '募集者自身を選択することはできません' }
        format.json { head :no_content }
      end
    else
      @entry_chat = EntryChat.new(entry_chat_params)
      @entry_chat.acc_id = @entry_chat.account.acc_id
      @entry_chat.chat_id = @entry_chat.recruitment.id
      @entry_chat.save
      #respond_to do |format|
      #  if @entry_chat.save
      #    format.html { redirect_to @entry_chat, notice: 'Entry chat was successfully created.' }
      #    format.json { render :show, status: :created, location: @entry_chat }
      #  else
      #    format.html { render :new }
      #    format.json { render json: @entry_chat.errors, status: :unprocessable_entity }
      #  end
      #end
    end
  end

  # PATCH/PUT /entry_chats/1
  # PATCH/PUT /entry_chats/1.json
  def update
    respond_to do |format|
      if @entry_chat.update(entry_chat_params)
        format.html { redirect_to @entry_chat, notice: 'Entry chat was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry_chat }
      else
        format.html { render :edit }
        format.json { render json: @entry_chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entry_chats/1
  # DELETE /entry_chats/1.json
  def destroy
    #ajax通信以外は弾く
    return redirect_to '/404.html' unless request.xhr?

    @new_entry_chat = EntryChat.new
    @new_entry_chat.chat_id = @entry_chat.chat_id
    @new_entry_chat.acc_id = @entry_chat.acc_id
    @new_entry_chat.recruitment_id = @entry_chat.recruitment.id
    @new_entry_chat.account_id = @entry_chat.account.id
    @entry_chat.destroy
    #respond_to do |format|
    #  format.html { redirect_to entry_chats_url, notice: 'Entry chat was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry_chat
      @entry_chat = EntryChat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_chat_params
      params.require(:entry_chat).permit(:recruitment_id, :account_id)
    end
end
