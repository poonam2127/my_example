# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(registration_params)
    if resource.save
      # sign_up(resource_name, resource)
      redirect_to new_user_session_path
    else
      flash[:alert] = "Please fill correct data."
      respond_with resource, location: new_user_registration_path
    end
  end

  private

  def registration_params
    params.require(:user).permit(
      :name, :role,
      :email, :password, :password_confirmation
    )
  end
end
