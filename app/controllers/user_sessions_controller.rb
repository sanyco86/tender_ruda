class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:success] = 'Вход выполнен'
      redirect_back_or_default root_url
    else
      flash[:danger] = 'Не верный пользователь или пароль'
      render 'new'
    end
  end

  def destroy
    current_user_session.destroy if current_user_session
    redirect_back_or_default root_url
  end

  private

  def user_session_params
    params.require(:user_session).permit(:email, :password)
  end
end
