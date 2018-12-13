class HomeController < ApplicationController
  def index
  end

  def show
    $home_button = 1
    @recruitments = Recruitment.all.where(acc_id: current_account.acc_id)
    @entry_chats = EntryChat.all.where(acc_id: current_account.acc_id)

  end

  def button
    $home_button = params[:id]
    @recruitments = Recruitment.all.where(acc_id: current_account.acc_id)
    @entry_chats = EntryChat.all.where(acc_id: current_account.acc_id)
    render template: 'home/show'
  end
end
