class Recruitment < ApplicationRecord
  belongs_to :account
  has_many :comments, dependent: :destroy
  has_many :entry_chats, dependent: :destroy
  has_many :chat_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  validates :detail, presence: true
  validates :title, presence: true

  # タグIDの配列からそのタグをすべて含む発言を取得する
  def self.tagidsearch(tagid)
    query = "SELECT  recruitments.* FROM recruitments"
    if tagid.blank? then
      Recruitment.all
    else
      cnt = 0
      for i in 0..(tagid.count)
        joinand = " INNER JOIN tagmaps AS tag"+(i+1).to_s+" ON tag"+(i+1).to_s+".com_id = recruitments.id AND tag"+(i+1).to_s+".tag_id = "
        if tagid[i].to_s != "" then
          query = query + joinand + tagid[i].to_s
        else
          query = query + joinand + "NULL"
        end
        cnt += 1
      end
      if cnt != 0 then

        query = query + " ORDER BY recruitments.updated_at DESC"
        Recruitment.find_by_sql([query])
      else
        Recruitment.none
      end

    end
  end

  # タグ名の配列からそのタグをすべて含む発言を取得する
  def self.tagnamesearch(tagname)
    query = "SELECT recruitments.* FROM recruitments"
    if tagname.blank? then
      tmp = Recruitment.all
      tmp.order(updated_at: "DESC")
    else
      cnt = 0
      for i in 0..(tagname.length)
        if tagname[i] != "" && tagname[i] != nil then
          tagquery = "SELECT  tags.* FROM tags WHERE tags.tag_name = \"" + tagname[i].encode("cp932", :invalid => :replace, :undef => :replace) + "\" LIMIT 1"
          tagid = Tag.find_by_sql([tagquery])
          joinand = " INNER JOIN tagmaps AS tag"+(i+1).to_s+" ON tag"+(i+1).to_s+".com_id = recruitments.id AND tag"+(i+1).to_s+".tag_id = "
          if tagid.present? then
            query = query + joinand + tagid[0][:tag_id].to_s
          else
            query = query + joinand + "NULL"
          end
          cnt += 1
        end
      end
      if cnt != 0 then
        query = query + " ORDER BY recruitments.updated_at DESC"
        com = Recruitment.find_by_sql([query])
        if com.blank? then
          Recruitment.none
        else
          com
        end
      else
        tmp = Recruitment.all
        tmp.order(updated_at: "DESC")
      end
    end
  end
end
