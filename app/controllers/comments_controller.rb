class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.where(p_com_id: params[:p_com_id])
    @comment = Comment.new(p_com_id: params[:p_com_id])
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    # @comment.acc_id = current_account.acc_id #アカウントID
    respond_to do |format|
      if @comment.save
        format.html { redirect_to comments_index_path(@comment.p_com_id), notice: '発言を投稿しました' }
        format.json { render :index, status: :created, location: @comment }
      else
        format.html { render :index }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    p_com_id = @comment.p_com_id
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_index_path(p_com_id), notice: '発言を削除しました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:acc_id, :p_com_id, :message, :file_id)
    end
end
