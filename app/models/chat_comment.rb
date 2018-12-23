class ChatComment < ApplicationRecord
  validates :comment, presence: true, length: { maximum: 1000}
  belongs_to :account
  belongs_to :recruitment
end
