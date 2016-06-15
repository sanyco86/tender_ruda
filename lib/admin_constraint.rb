class AdminConstraint
  def matches?(request)
    return false unless request.cookie_jar['manager_credentials'].present?
    manager = Manager.find_by_persistence_token(request.cookie_jar['manager_credentials'].split(':')[0])
    manager
  end
end
