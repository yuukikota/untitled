class MainsController < ApplicationController

  def index
    $view_num = '1'
    $view_com_num = '5'
    @comments = Comment.all
    @comment = Comment.new

    @recruitments = Recruitment.all.limit(20)
    @recruitment = Recruitment.new
    @inputtag = Inputtag.new
    if account_signed_in? then
      @taghistoryid = Taghistoryid.new
      @inputtag.setuniv school: current_account.university, faculty: current_account.faculty, department: current_account.department
    end
    render template: 'mains/index'
  end

  def add_index
    $view_num = '1'
    $view_com_num = '5'
    @comments = Comment.all
    @comment = Comment.new
    @recruitments = Recruitment.all.limit(20).offset(params[:size])

    @recruitment = Recruitment.new
    @inputtag = Inputtag.new
  

    if account_signed_in? then #ログインしている
      @taghistoryid = Taghistoryid.new #履歴用に変数準備
      if params[:school].present? then #パラメータを受け取っている
        @inputtag = Inputtag.new(inputtag_params) #入力されているタグを取得
        @recruitments = Recruitment.tagnamesearch(arry_tag_params) #入力されているタグで検索
        else #パラメータを受け取っていない
        @inputtag = Inputtag.new
        @inputtag.setuniv(school: current_account.university, faculty: current_account.faculty, department: current_account.department) #タグに大学情報セット
        @recruitments = Recruitment.all
        @recruitments = @recruitments.order(updated_at: "DESC")#データをすべて取得してソート
      end
    else #ログインしていない
      @inputtag = Inputtag.new
      @recruitments = Recruitment.all
      @recruitments = @recruitments.order(updated_at: "DESC")#データをすべて取得してソート
    end
    render template: 'mains/index'
  end

  def button
    @comments = Comment.all
    @comment = Comment.new

    @recruitment = Recruitment.new
    @inputtag = Inputtag.new(inputtag_params)#入力されているタグを取得
    @recruitments = Recruitment.tagnamesearch(arry_tag_params)#.limit(20)#入力されているタグで検索

    if account_signed_in? then #ログインしている

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

  #タグ検索フォームの情報を取得する
  def inputtag_params
    params.permit(:school, :faculty, :department, :tag1, :tag2, :tag3, :tag4, :tag5, :tag6, :tag7)
  end
  def arry_tag_params
    [params[:school],params[:faculty],params[:department],params[:tag1],params[:tag2],params[:tag3],params[:tag4],params[:tag5],params[:tag6],params[:tag7]]
  end

end
