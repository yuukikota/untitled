class MainsController < ApplicationController
  def book_list
    @recruitments = Recruitment.paginate(page: params[:page], per_page: 20)
  end

  def index
    $view_num = '1'

    $view_com_num = '5'
    @comments = Comment.all
    @comment = Comment.new
    @recruitments = Recruitment.all
    @recruitment = Recruitment.new
    @inputtag = Inputtag.new
    if account_signed_in? then
      @taghistoryid = Taghistoryid.new
      @inputtag.setuniv school: current_account.university, faculty: current_account.faculty, department: current_account.department
    end
    render template: 'mains/index'
  end
  def button
    @comments = Comment.all
    @comment = Comment.new
    @recruitments = Recruitment.all
    @recruitment = Recruitment.new
    @inputtag = Inputtag.new
    if account_signed_in? then
      @taghistoryid = Taghistoryid.new
      @inputtag.setuniv school: current_account.university, faculty: current_account.faculty, department: current_account.department
    end
    tmp = params[:id]
    if tmp == '1' || tmp == '2' || tmp == '3' || tmp == '4'
      $view_num = tmp
    end
    if tmp == '5' || tmp == '6'
      $view_com_num = tmp
    end
    render template: 'mains/index'
    if account_signed_in? then
      @inputtag.setuniv school: current_account.university, faculty: current_account.faculty, department: current_account.department
    end
  end

end
