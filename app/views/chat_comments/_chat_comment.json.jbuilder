json.extract! chat_comment, :id, :chat_id, :acc_id, :time, :comment, :file_id, :created_at, :updated_at
json.url chat_comment_url(chat_comment, format: :json)
