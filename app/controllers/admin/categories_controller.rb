class Admin::CategoriesController < Admin::BaseController

  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_filter :require_manager
  
  def index
    authorize! :read, @manager
    @categories = Category.all
  end

  def new
    @category = Category.new
    authorize! :new, @category
  end
  
  def show
    authorize! :read, @manager
  end

  def edit
    authorize! :manage, @category
  end

  def create
    authorize! :create, @category
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Добавлена новая категория товаров.'
      redirect_to admin_categories_path
    else
      render 'new'
    end
  end

  def update
    authorize! :manage, @category
    if @category.update(category_params)
      flash[:success] = 'Категория товаров отредактирована'
      redirect_to admin_categories_path
    else
      render 'edit'
    end
  end

  def destroy
    authorize! :manage, @category
    @category.destroy
    flash[:success] = 'Ктегория удалена'
    redirect_to admin_categories_url
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
