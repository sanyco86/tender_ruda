class Notifier < ApplicationMailer
  default from: 'tenders@tis-ruda.com',
  template_path: 'mailers/users'
  
  def password_reset_instructions(user)
  @edit_password_reset_url = edit_password_reset_url(user.perishable_token)
  @user = user
    mail to:      user.email,
    subject:      'ООО "ТИС-РУДА" Востановление пароля!',
    content_type: 'text/html',
    sent_on:      Time.now      
  end
  
  def activation_instructions(user)
    @account_activation_url = activation_url(user.perishable_token)
    @user = user
      mail to:      user.email,
      subject:      'ООО "ТИС-РУДА" Активация учетной записи!',
      content_type: 'text/html',
      sent_on:      Time.now
  end

  def welcome(user)
    @root_url = root_url
    @user = user
      mail to:      user.email,
      subject:      'ООО "ТИС-РУДА" Добро пожаловать!',
      content_type: 'text/html',
      sent_on:      Time.now
  end
end
