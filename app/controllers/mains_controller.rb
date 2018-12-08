class MainsController < ApplicationController
  def index
    $log = TRUE
    $acc = 'noname'
    @comments = Comment.all
    @comment = Comment.new
    render template: 'mains/index'
  end
  def login
    $log = FALSE
    @comments = Comment.all
    @comment = Comment.new
    $account = Account.new
    $account = Account.find_by(acc_id: 'user1')
    render template: 'mains/index'
  end
  def home
    @comments = Comment.all
    @comment = Comment.new
    render template: 'mains/index'
  end
end
