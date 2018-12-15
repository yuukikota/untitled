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

  # GET /entry_chats/new/:p_com_id
  def new
    @recruitment = Recruitment.find(params[:p_com_id]) # 元の募集を取得
    @comments = Comment.where(p_com_id: params[:p_com_id]).limit(20)  #返信20件を取得
    @entry_chat = EntryChat.new
  end

  # ajaxで動的に表示項目を追加する
  def add_result
    @comments = Comment.where(p_com_id: params[:p_com_id]).limit(20).offset(params[:size])  #返信20件を取得
    @entry_chat = EntryChat.new
  end

  # GET /entry_chats/1/edit
  def edit
  end

  # POST /entry_chats
  # POST /entry_chats.json
  def create
    @entry_chat = EntryChat.new(entry_chat_params)
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
    @new_entry_chat = EntryChat.new
    @new_entry_chat.chat_id = @entry_chat.chat_id
    @new_entry_chat.acc_id = @entry_chat.acc_id
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
      params.require(:entry_chat).permit(:chat_id, :acc_id)
    end
end
