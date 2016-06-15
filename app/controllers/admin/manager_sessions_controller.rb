class Admin::ManagerSessionsController < Admin::BaseController
  def new
    @manager_session = ManagerSession.new
  end

  def create
    @manager_session = ManagerSession.new(manager_session_params)
    if @manager_session.save
      flash[:success] = 'Добро пожаловать'
      redirect_back_or_default  admin_root_url
    else
      flash[:danger] = 'Не верный пользователь или пароль'
      render 'new'
    end
  end

  def destroy
    current_manager_session.destroy if current_manager_session
    redirect_back_or_default  admin_signin_url
  end

  private

  def manager_session_params
    params.require(:admin_manager_session).permit(:email, :password)
  end
end
