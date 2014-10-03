class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_filter :discard_flash_if_xhr

  protected
  def discard_flash_if_xhr
    flash.discard if request.xhr?
  end

  def render_error(error_msg, code=500)
    flash[:error] = error_msg
    render 'error', status: code
  end
end
