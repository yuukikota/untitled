class ChatCommentsController < ApplicationController
  before_action :set_chat_comment, only: [:show, :edit, :update, :destroy]


  # GET /chat_comments
  # GET /chat_comments.json

  # GET /chat_comments/1
  # GET /chat_comments/1.json
  def index
    @chat_num = params[:chat_id]
    if EntryChat.find_by(chat_id: params[:chat_id], acc_id: current_account.acc_id).present?
      @chat_comments = ChatComment.where(chat_id: params[:chat_id])
      @chat_comment = ChatComment.new
    else
      redirect_to root_path, notice: 'チャットルームに入れませんでした'
    end
  end


  # POST /chat_comments
  # POST /chat_comments.json
  def create
    chat_id = params[:chat_id]
    @chat_comment = ChatComment.new(chat_comment_params)
    @chat_comment.chat_id = chat_id  #チャットID
    @chat_comment.acc_id = current_account.acc_id #アカウントID
    @chat_comment.recruitment_id = $chat_id
    @chat_comment.account_id = current_account.id
    respond_to do |format|
      if @chat_comment.save
        format.html { redirect_to chat_comments_index_path(@chat_id), notice: '発言が送信されました' }
        format.json { render :show, status: :created, location: @chat_comment }
      else
        format.html { render :index }
        format.json { render json: @chat_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chat_comments/1
  # DELETE /chat_comments/1.json
  def destroy
    chat_id = @chat_comment.chat_id
    @chat_comment.destroy
    respond_to do |format|
      format.html { redirect_to chat_comments_index_path(chat_id), notice: 'コメントを削除しました' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat_comment
      @chat_comment = ChatComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chat_comment_params
      params.require(:chat_comment).permit(:comment, :file_id)
    end


end
