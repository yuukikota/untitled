class MainsController < ApplicationController
  def index
    $log = TRUE
    $account = Account.new
    $view_num = '1'
    @comments = Comment.all
    @comment = Comment.new
    @recruitments = Recruitment.all
    @recruitment = Recruitment.new
    render template: 'mains/index'
  end
  def login
    $log = FALSE
    @comments = Comment.all
    @comment = Comment.new
    @recruitments = Recruitment.all
    @recruitment = Recruitment.new
    $account = Account.new
    $account = Account.find_by(acc_id: params[:id])
    render template: 'mains/index'
  end
  def home
    @comments = Comment.all
    @comment = Comment.new
    @recruitments = Recruitment.all
    @recruitment = Recruitment.new
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
