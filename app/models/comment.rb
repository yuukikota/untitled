class Comment < ApplicationRecord

  validates :message, presence: true, length: { maximum: 1000 }
  validates :p_com_id, format: {with: /[0-9]+/}

end
