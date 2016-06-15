def sign_in(user = nil)
  activate_authlogic
  user ||= create(:aggregator)
  session = UserSession.create(user)
  ApplicationController.any_instance.stub(:current_user_session).and_return(session)
  session
end

def sign_in_manager_user(manager_user = nil)
  activate_authlogic
  manager_user ||= create(:manager)
  manager_session = ManagerSession.create(manager_user)
  Admin::BaseController.any_instance.stub(:current_manager_session).and_return(manager_session)
  manager_session
end
