class TagsController < ApplicationController
  def list
    @univ = Univ.new

    @comments = Comment.tagidsearch([])
    #@comments = Tagmap.where(tag_id: '936')
  end
  def update
    @univ = Univ.new(univ_params)

    @comments = Comment.tagnamesearch([params[:univ][:school],params[:univ][:faculty],params[:univ][:department]])
    render "tags/list"
  end
  private
  def univ_params
    params.require(:univ).permit(:school, :faculty, :department)
  end

end
