class ChatComment < ApplicationRecord
  validates :comment, presence: true, length: { maximam: 1_000}
end
