class MembersController < ApplicationController
  def index
    @chat_members = EntryChat.where(chat_id:$chat_id)
  end
end
