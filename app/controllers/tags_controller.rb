class TagsController < ApplicationController
  def list
    @inputtag = Inputtag.new
    @comments = Comment.tagidsearch([])
  end
  def update
    @inputtag = InputTag.new(univ_params)

    @comments = Comment.tagnamesearch([params[:univ][:school],params[:univ][:faculty],params[:univ][:department],params[:univ][:tag1],params[:univ][:tag2],params[:univ][:tag3]])
    render "tags/list"
  end
  private
  def univ_params
    params.require(:univ).permit(:school, :faculty, :department, :tag1, :tag2, :tag3)
  end

end
