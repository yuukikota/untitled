# frozen_string_literal: true

class Accounts::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def confirm
    @account = Account.new(sign_up_params)
    if @account.valid?
      render :action => 'confirm'
    else
      render :action => 'new'
    end
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource/:id
  def destroy
    #super

    @account = Account.find_by(id: params[:id])

    if @account.nil?
      respond_to do |format|
        format.html { redirect_to root_path, alert: '存在しないアカウントです' }
        format.json { head :no_content }
      end
    elsif @account.acc_id == 'administrator'
      respond_to do |format|
        format.html { redirect_to root_path, alert: '管理者アカウントを削除することはできません' }
        format.json { head :no_content }
      end
    elsif !(@account.id == current_account.id or current_account.acc_id == 'administrator')
      respond_to do |format|
        format.html { redirect_to root_path, alert: '削除権限がありません' }
        format.json { head :no_content }
      end
    else
      if @account.destroy
        respond_to do |format|
          format.html { redirect_to root_path, notice: 'アカウントを削除しました' }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html { redirect_to root_path, alert: 'アカウント削除に失敗しました' }
          format.json { head :no_content }
        end
      end
    end
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

   protected

  def after_update_path_for(resource)
    account_show_path(resource.acc_id)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
