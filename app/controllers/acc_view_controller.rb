class AccViewController < ApplicationController
  def index
      @entry_chats = EntryChat.where(acc_id:$account.acc_id)
    render template: 'acc_view/index'
  end

end
