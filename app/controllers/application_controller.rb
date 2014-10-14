class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_filter :discard_flash_if_xhr

  protected
  def discard_flash_if_xhr
    flash.discard if request.xhr?
  end
end
