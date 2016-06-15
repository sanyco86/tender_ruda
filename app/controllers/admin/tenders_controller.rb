class Admin::TendersController < Admin::BaseController
  before_action :set_tender_edit_form, only: [:show, :edit, :update, :destroy]
  before_action :set_tender_decide_form, only: [:decide]
  before_action :require_manager

  def index
    authorize! :read, @tender
    @tenders = Tender.all.order('data_end ASC')
  end

  def show
    authorize! :read, @tender
    @user_items = UserItem.all
    @tenders = Tender.find(params[:id])
    respond_to do |format|
      format.html
      format.xlsx {render axlsx: 'admin/tenders', locals: { xlsx_use_shared_strings: true }}
    end
  end

  def new
    authorize! :new, @tender
    data = params[:data]
    @tender = Tender::AsCreateForm.new
    1.times { @tender.items.build}
    unless data.nil?
      rows = data.split("\n")
      rows.each do |row|
        vals = row.split("\t")
        item = Item.new(
          name: vals[0],
          quantity: vals[1],  
          measure_unit: vals[2],
          gost: vals[3],
          description: vals[4]      
        )
        @tender.items << item
      end
    end   
  end

  def edit
    authorize! :edit, @tender
  end

  def create
    authorize! :create, @tender
    @tender = Tender::AsCreateForm.new(tender_params)
    if @tender.save
      flash[:success] = "Тендер создан. Будут уведомлены #{@tender.recipients_count} пользователей."
      TenderCreatedWorker.perform_async(@tender.id)
      redirect_to admin_tenders_path
    else
      render 'new'
    end
  end

  def update
    authorize! :update, @tender
    if @tender.update(tender_params)
      flash[:success] = 'Тендер отредактирован.'
      redirect_to admin_tender_path(@tender)
    else
      render 'edit'
    end
  end

  def destroy
    authorize! :destroy, @tender
    TenderDestroyedWorker.perform_async(@tender.id)
    @tender.destroy
    flash[:success] = 'Тендер удален.'
    redirect_to admin_tenders_url
  end

  def decide
    if @tender.update(choose_winner_params)
      flash[:success] = "Тендер завершен. #{@tender.sended_mails} уведомлений отправлено поставщикам"
      redirect_to :back
    else
      render 'show'
    end
  end

  def close_without_winner
    @tender = Tender.find(params[:id]).becomes(Tender::AsCloseWithoutWinner)
    if @tender.save
      flash[:success] = "Тендер завершен. #{@tender.sended_mails} уведомлений отправлено поставщикам"
      redirect_to :back
    else
      render 'show'
    end
  end

  def start_second_stage
    @tender = Tender.find(params[:id]).becomes(Tender::AsStartSecondStage)
    if @tender.update(tender_params)
      flash[:success] = "Начат второй этап. #{@tender.sended_mails} уведомлений отправлено поставщикам"
      redirect_to :back
    else
      render 'show'
    end
  end

  private
    def set_tender_edit_form
      @tender = Tender.find(params[:id]).becomes(Tender::AsEditForm)
    end

    def set_tender_decide_form
      @tender = Tender.find(params[:id]).becomes(Tender::AsChooseWinnerForm)
    end

    def tender_params
      params.require(:tender).permit(
        :name,
        :status_id,
        :uslovie,
        :dopuslovie,
        :data_start,
        :data_end,
        :fls,
        :manager_id,
        :etap,
        items_attributes: [:id, :name, :quantity, :measure_unit, :gost, :description, :_destroy, :winner_id],
        category_ids: []
      )
    end

    def choose_winner_params
      params.require(:tender).permit(
        items_attributes: [:id, :winner_id],
      )
    end
end
