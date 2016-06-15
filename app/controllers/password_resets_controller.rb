class PasswordResetsController < ApplicationController
  before_filter :require_no_user
  before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:success] = 'Инструкции для восстановления пароля были высланы Вам по электронной почте'
      redirect_to root_path
    else
      flash.now[:danger] = "Не удалось найти пользователя с адресом электронной почты #{params[:email]}"
      render :new
    end
  end

  def edit
  end

  def update
    @user.password = params[:password]
    @user.password_confirmation = params[:password]
    if @user.save
      flash[:success] = 'Ваш пароль был успешно изменен'
      redirect_to root_path
    else
      render :edit
    end
  end


  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:danger] = 'Мы сожалеем, но срок для для востановления пароля истек'
      redirect_to root_path
    end
  end
end
