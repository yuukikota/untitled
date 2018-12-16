class HomeController < ApplicationController
  def index
  end

  def show
    $home_button = 1
    @recruitments = Recruitment.where(acc_id: current_account.acc_id).order(updated_at: "DESC")
    @entry_chats = EntryChat.all.where(acc_id: current_account.acc_id)

  end

  def button
    $home_button = params[:id]
    @recruitments = Recruitment.where(acc_id: current_account.acc_id).order(updated_at: "DESC")
    @entry_chats = EntryChat.all.where(acc_id: current_account.acc_id)
    render template: 'home/show'
  end
end
