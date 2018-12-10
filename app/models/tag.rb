class Tag < ApplicationRecord
  self.primary_key = 'tag_id'
  has_many :tagmaps
  has_many :comments, through: :tagmaps
end
