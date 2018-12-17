class Photo < ApplicationRecord
  validates_presence_of :name
 # attachment_field :file
  validates_presence_of :file
end
