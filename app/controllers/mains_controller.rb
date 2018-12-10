class MainsController < ApplicationController
  def index
 #   $view_num = '1'
 #   @comments = Comment.all
 #   @comment = Comment.new
 #   @recruitments = Recruitment.all
 #   @recruitment = Recruitment.new
    render template: 'mains/index'
  end
  def button
 #   @comments = Comment.all
 #   @comment = Comment.new
 #   @recruitments = Recruitment.all
 #   @recruitment = Recruitment.new
    $view_num = params[:id]
    render template: 'mains/index'
  end
end
