class TagsController < ApplicationController

  def update
    @inputtag = Inputtag.new(inputtag_params)
    @comments = Comment.tagnamesearch([params[:inputtag][:school],params[:inputtag][:faculty],params[:inputtag][:department],params[:inputtag][:tag1],params[:inputtag][:tag2],params[:inputtag][:tag3]])

    @comment = Comment.new
    @recruitments = Recruitment.all
    @recruitment = Recruitment.new

    render template: 'mains/index'
  end
  private
  def inputtag_params
    params.require(:inputtag).permit(:school, :faculty, :department, :tag1, :tag2, :tag3)
  end

end
