class MembersController < ApplicationController
  def index
    @chat_num = params[:chat_id]
    @chat_members = EntryChat.where(chat_id: @chat_num)
  end
end
