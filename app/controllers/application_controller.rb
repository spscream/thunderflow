require "application_responder"

class ApplicationController < ActionController::Base
  include Pundit

  serialization_scope :current_user

  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_filter :discard_flash_if_xhr

  rescue_from 'Pundit::NotAuthorizedError' do |e|
    user_not_authorized
  end

  protected
  def discard_flash_if_xhr
    flash.discard if request.xhr?
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end


end
