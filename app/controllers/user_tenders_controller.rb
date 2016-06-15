class UserTendersController < ApplicationController
  before_action :set_user_tender, only: [:show, :edit, :update, :destroy]
  before_filter :require_user

  def index
    @user_tenders = UserTender.where(user_id: current_user.id).order('id DESC')
  end

  def show
    if @user_tender.user == current_user
      @user_tender = UserTender.find(params[:id])
    else
      redirect_to my_archive_path
    end
  end

  def my_archive
    @user = current_user
    @user_tenders = UserTender.where(user_id: current_user.id).order('id DESC')
  end

  def new
    @user_tender = UserTender.find_or_initialize_by(user_id: current_user.id, tender_id: params[:tender_id])
    if @user_tender.new_record? && @user_tender.tender.status_id == 1
      @user_tender.tender.items.each do |item|
        @user_tender.user_items.build(item: item)
      end
      render 'new'
    else
      if @user_tender.tender.status_id == 1
        redirect_to [:edit, @user_tender]
      else
        redirect_to root_path
      end
    end
  end

  def edit
    if @user_tender.tender.status_id > 1
      redirect_to root_url
    else

    end
  end

  def create
    @user_tender = UserTender.new(user_tender_params)
    if @user_tender.save
      flash[:success] = 'Ваше предложение принято'
      redirect_to user_tenders_url
    else
      render 'new'
    end
  end

  def update
    if @user_tender.update(user_tender_params)
      flash[:success] = 'Ваше предложение отредактировано'
      redirect_to user_tenders_url
    else
      render 'edit'
    end
  end

  def destroy
    @user_tender.destroy
    flash[:success] = 'Ваше предложение удалено'
    redirect_to user_tenders_url
  end

  private
  def set_user_tender
    @user_tender = UserTender.find(params[:id])
  end

  def user_tender_params
    params.require(:user_tender).permit(
        :description,
        :status,
        :file,
        :tender_id,
        :user_id,
        user_items_attributes: [:id, :price, :first_price, :first_price_second_stage, :delivery, :comm, :selected, :user_tender_id, :item_id, :_destroy]
    )
  end
end
