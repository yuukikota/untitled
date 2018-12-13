class Tag < ApplicationRecord
  self.primary_key = 'tag_id'

  def self.getid(tagname)
    tagid = Tag.where(tag_name: tagname.encode("cp932", :invalid => :replace, :undef => :replace))
    if tagid.present? then
      tagid[0][:tag_id]
    else
      nil
    end

  end

  def self.getname(tagid)
    tagname = Tag.where(tag_id: tagid)
    if tagname.present? then
      tagname[0][:tag_name]
    else
      nil
    end
  end

end
