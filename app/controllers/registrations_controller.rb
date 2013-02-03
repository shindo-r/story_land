class Devise::RegistrationsController < ApplicationController
  private
  def after_inactive_sign_up_path_for(resource_or_scope)
    finish_inactive_sign_up_path
  end
end