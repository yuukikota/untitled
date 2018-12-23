class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:destroy]

  # POST /bookmarks
  # POST /bookmarks.json
  def create
    #ajax通信以外は弾く
    return redirect_to '/404.html' unless request.xhr?

    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.account_id = current_account.id
    @alert = nil
    if @bookmark.recruitment.nil?
      @alert = "存在しない発言または募集です"
    else
      if @bookmark.save
        # 保存成功
      else
        # 保存失敗
        @alert = "ブックマークに失敗しました"
      end
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    #ajax通信以外は弾く
    return redirect_to '/404.html' unless request.xhr?

    @alert = nil

    if @bookmark.nil?
      @alert = '存在しない発言または募集です'
    else
      @new_bookmark = Bookmark.new
      @new_bookmark.account_id = @bookmark.account_id
      @new_bookmark.recruitment_id = @bookmark.recruitment_id
      if @bookmark.destroy
        # 削除成功
      else
        @alert = 'ブックマークの取り消しに失敗しました'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookmark
      @bookmark = Bookmark.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookmark_params
      params.require(:bookmark).permit(:recruitment_id)
    end
end
