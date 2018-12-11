class ChatComment < ApplicationRecord
  validates :comment, presence: true, length: { maximum: 1_000}
end
