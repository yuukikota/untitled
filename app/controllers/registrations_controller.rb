class RegistrationsController < Devise::RegistrationsController

  protected

    def after_update_path_for(resource)
      account_show_path(resource.acc_id)
    end
end