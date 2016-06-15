class UsersController < ApplicationController
  before_action :require_user, :only => [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save_without_session_maintenance
      @user.deliver_activation_instructions!
      flash[:success] = 'Вы успешно зарегестрировались. На Ваш email высланы инструкции по активации учетной записи'
      redirect_back_or_default root_url
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user 
    if @user.update_attributes(user_params)
      flash[:success] = 'Учетная запись обновлена'
      redirect_to root_url
    else
      render :edit
    end
  end

  private

   def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :name,
      :company,
      :function,
      :phone,
      :adds,
      :www,
      :file_nds,
      :file_reg,
      :openid_identifier,
      category_ids: []
    )
  end
end
