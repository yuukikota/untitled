class MainsController < ApplicationController

  def index

    $view_num = '1'
    $view_com_num = '5'
    @bookmark = Bookmark.new

    @recruitment = Recruitment.new

    if account_signed_in? then #ログインしている
      @taghistoryid = Taghistoryid.new #履歴用に変数準備
      if params.has_key?(:school) then #パラメータを受け取っている
        @inputtag = Inputtag.new(inputtag_params) #入力されているタグを取得
        @inputtag.freetagnum = @inputtag.count_freetag
        @recruitments = Recruitment.tagnamesearch2(@inputtag.tag_to_arry,10,0) #入力されているタグで検索
      else #パラメータを受け取っていない
        @inputtag = Inputtag.new
        @inputtag.setuniv(school: current_account.university, faculty: current_account.faculty, department: current_account.department) #タグに大学情報セット
        @recruitments = Recruitment.tagnamesearch2(@inputtag.tag_to_arry,10,0)
      end
    else #ログインしていない
      if params.has_key?(:school) then #パラメータを受け取っている
        @inputtag = Inputtag.new(inputtag_params) #入力されているタグを取得
        @inputtag.freetagnum = @inputtag.count_freetag
        @recruitments = Recruitment.tagnamesearch2(@inputtag.tag_to_arry,10,0) #入力されているタグで検索
      else
        @inputtag = Inputtag.new
        @recruitments = Recruitment.tagnamesearch2([],10,0)
        #@recruitments = @recruitments.order(updated_at: "DESC")#データをすべて取得してソート
      end
    end

    render template: 'mains/index'
  end

  def add_index

    $view_num = '1'
    $view_com_num = '5'
    @bookmark = Bookmark.new

    @recruitments = Recruitment.all.limit(20).offset(params[:size])

    @recruitment = Recruitment.new
    @inputtag = Inputtag.new
  

    if account_signed_in? then #ログインしている
      @taghistoryid = Taghistoryid.new #履歴用に変数準備
      if params[:school].present? then #パラメータを受け取っている
        @inputtag = Inputtag.new(inputtag_params) #入力されているタグを取得
        @inputtag.freetagnum = @inputtag.count_freetag
        @recruitments = Recruitment.tagnamesearch(@inputtag.tag_to_arry) #入力されているタグで検索
        else #パラメータを受け取っていない
        @inputtag = Inputtag.new
        @inputtag.setuniv(school: current_account.university, faculty: current_account.faculty, department: current_account.department) #タグに大学情報セット
        @inputtag.freetagnum = @inputtag.count_freetag
        @recruitments = Recruitment.tagnamesearch(@inputtag.tag_to_arry)
        @recruitments = @recruitments.order(updated_at: "DESC")#データをすべて取得してソート
      end
    else #ログインしていない
      @inputtag = Inputtag.new
      @inputtag.freetagnum = @inputtag.count_freetag
      @recruitments = Recruitment.all
      @recruitments = @recruitments.order(updated_at: "DESC")#データをすべて取得してソート
    end
    render template: 'mains/index'
  end

  def button_view
    @inputtag = Inputtag.new(inputtag_params)#入力されているタグを取得

    @inputtag.freetagnum = @inputtag.count_freetag
    if account_signed_in? then #ログインしている
      @taghistoryid = Taghistoryid.new
    end
    @view_num = params[:id]
    if @view_num == '1'
      @recruitments = Recruitment.all                            #タイムライン
    elsif @view_num == '2'
      @recruitments = Recruitment.all.where(re_id: '発言')       #発言
    elsif @view_num == '3'
      @recruitments = Recruitment.all.where(re_id: '募集')       #募集
    elsif @view_num == '4'
      @recruitments = Recruitment.all.where(resolved_id: '解決') #解決済み募集
    end
  end

  def button_form

    @bookmark = Bookmark.new

    @recruitment = Recruitment.new
    @inputtag = Inputtag.new(inputtag_params)#入力されているタグを取得

    @inputtag.freetagnum = @inputtag.count_freetag

    if account_signed_in? then #ログインしている
      @taghistoryid = Taghistoryid.new
    end

      @view_com_num = params[:id]

    if account_signed_in? then
      @inputtag.setuniv school: current_account.university, faculty: current_account.faculty, department: current_account.department
    end
  end



  #タグ検索フォームの情報を取得する
  def inputtag_params
    params.permit(:school, :faculty, :department, :tag1, :tag2, :tag3, :tag4, :tag5, :tag6, :tag7, :tag8, :tag9, :tag10)
  end

end
