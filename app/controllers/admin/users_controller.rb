class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :require_manager
  
  def index
    authorize! :read, @user
    @users = User.paginate(page: params[:page]).order('id DESC')
  end
  
  def show
    authorize! :read, @user
    @user = User.find(params[:id])
    @user_tenders = UserTender.where(user_id: @user)
  end

  def edit
    authorize! :manage, @user
  end

  def update
    authorize! :manage, @user
    if @user.update(user_params)
      flash[:success] = 'Учетная запись обновлена'
      redirect_to admin_users_url
    else
      render :edit
    end
  end
  
  def destroy
    authorize! :manage, @user
    @user.destroy
    flash[:success] = 'Поставщик удален'
    redirect_to admin_users_url
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
          :email,
          :name,
          :company,
          :function,
          :phone,
          :adds,
          :www,
          :active,
      )
    end
end
