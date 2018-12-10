class Tagmap < ApplicationRecord
  belongs_to :comment
  belongs_to :tags
end
