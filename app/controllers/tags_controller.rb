class TagsController < ApplicationController

  #タグ検索フォーム、履歴検索フォーム用
  def update
    if params[:type] == "input" then
      @inputtag = Inputtag.new(inputtag_params)
    else
      if params[:taghistoryid][:id] != "" then
        @inputtag = set_taghistory(params[:taghistoryid][:id])
      else
        @inputtag = Inputtag.new
      end
    end

    @comments = Recruitment.tagnamesearch([@inputtag.school,@inputtag.faculty,@inputtag.department,@inputtag.tag1,@inputtag.tag2,@inputtag.tag3,@inputtag.tag4,@inputtag.tag5,@inputtag.tag6,@inputtag.tag7])

    @comment = Comment.new
    @recruitments = Recruitment.all
    @recruitment = Recruitment.new
    @taghistoryid = Taghistoryid.new
    if params[:type] == "input" then
      add_taghistory(inputtag_params)
    end
    render template: 'mains/index'
  end

  private
  #タグ検索フォームの情報を取得する
  def inputtag_params
    params.require(:inputtag).permit(:school, :faculty, :department, :tag1, :tag2, :tag3, :tag4, :tag5, :tag6, :tag7)
  end

  #指定した履歴IDの履歴を取得
  def set_taghistory(id)
    history = Taghistory.find(id)
    history.touch
    history.save
    if history.present? then
      Inputtag.new(school: history[:univtag], faculty: history[:faculty], department: history[:department], tag1: history[:tag1], tag2: history[:tag2], tag3: history[:tag3], tag4: history[:tag4], tag5: history[:tag5], tag6: history[:tag6], tag7: history[:tag7])
    else
      Inputtag.new
    end
  end

  # 検索フォームのタグを履歴に保存
  # 重複する場合は時刻のみ更新
  def add_taghistory(tag)
    freetag = []
    school = []
    display = ""
    if tag[:school] != "" then
      school[0] = tag[:school]
      display = display + tag[:school] + "  "
    else
      school[0] = nil
    end
    if tag[:faculty] != "" then
      school[1] = tag[:faculty]
      display = display + tag[:faculty] + "  "
    else
      school[1] = nil
    end
    if tag[:department] != "" then
      school[2] = tag[:department]
      display = display + tag[:department] + "  "
    else
      school[2] = nil
    end

    if tag[:tag1] != "" then
      freetag[0] = tag[:tag1]
      display = display + tag[:tag1] + "  "
    else
      freetag[0] = nil
    end
    if tag[:tag2] != "" then
      freetag[1] = tag[:tag2]
      display = display + tag[:tag2] + "  "
    else
      freetag[1] = nil
    end
    if tag[:tag3] != "" then
      freetag[2] = tag[:tag3]
      display = display + tag[:tag3] + "  "
    else
      freetag[2] = nil
    end
    if tag[:tag4] != "" then
      freetag[3] = tag[:tag4]
      display = display + tag[:tag4] + "  "
    else
      freetag[3] = nil
    end
    if tag[:tag5] != "" then
      freetag[4] = tag[:tag5]
      display = display + tag[:tag5] + "  "
    else
      freetag[4] = nil
    end
    if tag[:tag6] != "" then
      freetag[5] = tag[:tag6]
      display = display + tag[:tag6] + "  "
    else
      freetag[5] = nil
    end
    if tag[:tag7] != "" then
      freetag[6] = tag[:tag7]
      display = display + tag[:tag7] + "  "
      else
      freetag[6] = nil
    end
    freetag.uniq!
    freetag = freetag.compact.sort
    if display == "" then
      display = nil
    end
    tmp = Taghistory.find_by(acc_id: 1,univtag:school[0], faculty:school[1], department:school[2], tag1:freetag[0], tag2:freetag[1], tag3:freetag[2], tag4:freetag[3], tag5:freetag[4], tag6:freetag[5], tag7:freetag[7])
    if tmp.blank? then
      taghistory = Taghistory.new({acc_id: 1,univtag:school[0], faculty:school[1], department:school[2], tag1:freetag[0], tag2:freetag[1], tag3:freetag[2], tag4:freetag[3], tag5:freetag[4], tag6:freetag[5], tag7:freetag[7], display:display})
      taghistory.save
    else
      tmp.touch
      tmp.save
    end
  end
end
