class Admin::ManagersController < Admin::BaseController
  before_filter :require_manager, :only => [:show, :edit, :update]
  
  def index
    authorize! :read, @manager
    @managers = Manager.paginate(page: params[:page])
  end

  def show
    authorize! :read, @manager
    @manager = Manager.find(params[:id])
  end

  def new
    authorize! :manage, @manager
    @manager = current_manager
    if @manager
      @manager = Manager.new
    else
      redirect_to admin_root_url
    end
  end
  
  def edit
    authorize! :read, @manager
    @manager = current_manager
  end

  def update
    authorize! :read, @manager
    @manager = current_manager
    if @manager.update_attributes(manager_params)
      flash[:success] = 'Профиль обновлен'
      redirect_to [:admin, @manager]
    else
      render 'edit'
    end
  end

  def create
    authorize! :manage, @manager
    @manager = Manager.new(manager_params)
    if @manager.save
      flash[:success] = 'Вы успешно зарегестрировались'
      redirect_back_or_default admin_managers_path
    else
      render 'new'
    end
  end
  
  def destroy
    authorize! :manage, @manager
    Manager.find(params[:id]).destroy
    flash[:success] = 'Пользователь удален.'
    redirect_to admin_managers_url
  end

  private

  def manager_params
    params.require(:manager).permit(:name, :email, :password, :password_confirmation, :role)
  end
end
