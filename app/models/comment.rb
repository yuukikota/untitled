class Comment < ApplicationRecord

  has_many :tagmaps
  has_many :tags, through: :tagmaps
  validates :message, presence: true, length: { maximum: 1000 }
  validates :p_com_id, format: {with: /[0-9]+/}

  def self.tagidsearch(tagid)
    query = "SELECT  comments.* FROM comments"
    if tagid.blank? then
      Comment.all
    else
      cnt = 0
      for i in 0..(tagid.count)
        joinand = " INNER JOIN tagmaps AS tag"+(i+1).to_s+" ON tag"+(i+1).to_s+".com_id = comments.id AND tag"+(i+1).to_s+".tag_id = "
        if tagid[i].to_s != "" then
          query = query + joinand + tagid[i].to_s
        else
          query = query + joinand + "NULL"
        end
        cnt += 1
      end
      if cnt != 0 then
        query = query + " WHERE comments.p_com_ID IS NULL ORDER BY comments.update_time ASC"
        Comment.find_by_sql([query])
      else
        Comment.none
      end

    end
  end
  def self.tagnamesearch(tagname)
    query = "SELECT  comments.* FROM comments"
    if tagname.blank? then
      Comment.all
    else
      cnt = 0
      for i in 0..(tagname.length)
        if tagname[i] != "" && tagname[i] != nil then
          tagquery = "SELECT  tags.* FROM tags WHERE tags.tag_name = \"" + tagname[i].encode("cp932", :invalid => :replace, :undef => :replace) + "\" LIMIT 1"
          tagid = Tag.find_by_sql([tagquery])
          joinand = " INNER JOIN tagmaps AS tag"+(i+1).to_s+" ON tag"+(i+1).to_s+".com_id = comments.id AND tag"+(i+1).to_s+".tag_id = "
          if tagid.present? then
            query = query + joinand + tagid[0][:tag_id].to_s
          else
            query = query + joinand + "NULL"
          end
          cnt += 1
        end
      end
      if cnt != 0 then
        query = query + " WHERE comments.p_com_ID IS NULL ORDER BY comments.update_time ASC"
        com = Comment.find_by_sql([query])
        if com.blank? then
          Comment.none
        else
          com
        end
      else
        Comment.none
      end
    end
  end
end
