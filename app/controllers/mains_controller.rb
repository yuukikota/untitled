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

end
