class Admin::BaseController < ApplicationController
  layout 'admin/base'

  protect_from_forgery with: :exception
  helper_method :current_manager_session, :current_manager

  private

  def current_manager_session
    return @current_manager_session if defined?(@current_manager_session)
    @current_manager_session = ManagerSession.find
  end

  def current_manager
    return @current_manager if defined?(@current_manager)
    @current_manager = current_manager_session && current_manager_session.manager
  end

  def require_manager
    unless current_manager
      store_location
      redirect_to admin_signin_path
      return false
    end
  end

  def require_no_manager
    if current_manager
      store_location
      redirect_to admin_root_path
    end
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def current_ability
    @current_ability ||= ::Ability.new(current_manager)
  end
end
