class TagsController < ApplicationController

  def update
    @inputtag = Inputtag.new(inputtag_params)
    @comments = Comment.tagnamesearch([@inputtag.school,@inputtag.faculty,@inputtag.department,@inputtag.tag1,@inputtag.tag2,@inputtag.tag3,@inputtag.tag4,@inputtag.tag5,@inputtag.tag6,@inputtag.tag7])

    @comment = Comment.new
    @recruitments = Recruitment.all
    @recruitment = Recruitment.new

    add_taghistory(inputtag_params)

    render template: 'mains/index'
  end

  def load_taghistory
    @inputtag = set_taghistory
    @comments = Comment.tagnamesearch([@inputtag.school,@inputtag.faculty,@inputtag.department,@inputtag.tag1,@inputtag.tag2,@inputtag.tag3,@inputtag.tag4,@inputtag.tag5,@inputtag.tag6,@inputtag.tag7])

    @comment = Comment.new
    @recruitments = Recruitment.all
    @recruitment = Recruitment.new

    render template: 'mains/index'
  end

  def set_tag(comid)
    history = Taghistory.where(acc_id: comid).order(updated_at:"DESC").first
    associate_comtotag(history[:univtag], comid)
    associate_comtotag(history[:faculty], comid)
    associate_comtotag(history[:department], comid)
    associate_comtotag(history[:tag1], comid)
    associate_comtotag(history[:tag2], comid)
    associate_comtotag(history[:tag3], comid)
    associate_comtotag(history[:tag4], comid)
    associate_comtotag(history[:tag5], comid)
    associate_comtotag(history[:tag6], comid)
    associate_comtotag(history[:tag7], comid)
  end

  private
  def inputtag_params
    params.require(:inputtag).permit(:school, :faculty, :department, :tag1, :tag2, :tag3, :tag4, :tag5, :tag6, :tag7)
  end

  def associate_comtotag(tag_name, comid)
    tagid = Tag.getid(tag_name)
    if tagid.nil? then
      tagid = Tag.maximum(:tag_id) + 1
      tag = Tag.new(tag_id: tagid, tag_type: false ,tag_name: history[:univtag],com_count: '1')
    else
      tag = Tag.find(tagid)
      tag.com_count += 1
    end
    tag.save
    newmap = Tagmap.new(com_id: tagid,tag_id: comid)
    newmap.save
  end

  def set_taghistory
    history = Taghistory.where(acc_id: '1').order(updated_at:"DESC").first
    if history.present? then
      Inputtag.new(school: history[:univtag], faculty: history[:faculty], department: history[:department], tag1: history[:tag1], tag2: history[:tag2], tag3: history[:tag3], tag4: history[:tag4], tag5: history[:tag5], tag6: history[:tag6], tag7: history[:tag7])
    else
      Inputtag.new
    end
  end

  def add_taghistory(tag)
    freetag = []
    school = []

    if tag[:school] != "" then
      school[0] = tag[:school]
    else
      school[0] = nil
    end
    if tag[:faculty] != "" then
      school[1] = tag[:faculty]
    else
      school[1] = nil
    end
    if tag[:department] != "" then
      school[2] = tag[:department]
    else
      school[2] = nil
    end

    if tag[:tag1] != "" then
      freetag[0] = tag[:tag1]
    else
      freetag[0] = nil
    end
    if tag[:tag2] != "" then
      freetag[1] = tag[:tag2]
    else
      freetag[1] = nil
    end
    if tag[:tag3] != "" then
      freetag[2] = tag[:tag3]
    else
      freetag[2] = nil
    end
    if tag[:tag4] != "" then
      freetag[3] = tag[:tag4]
    else
      freetag[3] = nil
    end
    if tag[:tag5] != "" then
      freetag[4] = tag[:tag5]
    else
      freetag[4] = nil
    end
    if tag[:tag6] != "" then
      freetag[5] = tag[:tag6]
    else
      freetag[5] = nil
    end
    if tag[:tag7] != "" then
      freetag[6] = tag[:tag7]
      else
      freetag[6] = nil
    end
    freetag.uniq!
    freetag = freetag.compact.sort
    tmp = Taghistory.find_by(acc_id: 1,univtag:school[0], faculty:school[1], department:school[2], tag1:freetag[0], tag2:freetag[1], tag3:freetag[2], tag4:freetag[3], tag5:freetag[4], tag6:freetag[5], tag7:freetag[7])
    if tmp.blank? then
      taghistory = Taghistory.new({acc_id: 1,univtag:school[0], faculty:school[1], department:school[2], tag1:freetag[0], tag2:freetag[1], tag3:freetag[2], tag4:freetag[3], tag5:freetag[4], tag6:freetag[5], tag7:freetag[7]})
      taghistory.save
    else
      tmp.touch
      tmp.save
    end
  end
end
