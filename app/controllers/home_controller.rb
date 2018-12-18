class HomeController < ApplicationController
  def index
  end

  # アカウント情報画面
  def show

  
    $home_button = 1
    @account = Account.find_by(acc_id: params[:acc_id])
    if @account.nil?
      respond_to do |format|
        format.html { redirect_to root_path, notice: '存在しないアカウントです' }
        format.json { head :no_content }
      end
    else
      @recruitments = @account.recruitments.order(updated_at: "DESC")
      @entry_chats = @account.entry_chats
    end
  end


  # アカウント削除画面
  def delete
    @account = Account.find_by(acc_id: params[:acc_id])
    if @account.nil?
      respond_to do |format|
        format.html { redirect_to root_path, notice: '存在しないアカウントです' }
        format.json { head :no_content }
      end
    elsif @account.id != current_account.id
      respond_to do |format|
        format.html { redirect_to root_path, notice: '削除権限がありません' }
        format.json { head :no_content }
      end
    end
  end

  def button
    $home_button = params[:id]
    @account = Account.find_by(acc_id: params[:acc_id])
    if @account.nil?
      respond_to do |format|
        format.html { redirect_to root_path, notice: '存在しないアカウントです' }
        format.json { head :no_content }
      end
    else
      @recruitments = @account.recruitments.order(updated_at: "DESC")
      @entry_chats = @account.entry_chats
    end

    render template: 'home/show'
  end
end
