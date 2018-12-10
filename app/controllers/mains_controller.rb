class MainsController < ApplicationController
  def index
    $view_num = '1'
    @comments = Comment.all
    @comment = Comment.new
    @recruitments = Recruitment.all
    @recruitment = Recruitment.new
    @inputtag = Inputtag.new
    if account_signed_in? then
      @inputtag.setuniv school: current_account.university, faculty: current_account.faculty, department: current_account.department
    end
    render template: 'mains/index'
  end
  def button
    @comments = Comment.all
    @comment = Comment.new
    @recruitments = Recruitment.all
    @recruitment = Recruitment.new
    $view_num = params[:id]
    render template: 'mains/index'
  end

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
