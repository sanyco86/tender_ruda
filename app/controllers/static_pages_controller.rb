class StaticPagesController < ApplicationController

  def home
    @tenders = Tender.opened.first_stage.paginate(:page => params[:page], :per_page => 10).order('id DESC')
  end

  def archive
    @tenders = Tender.where('status_id > 1').paginate(:page => params[:page], :per_page => 10).order('id DESC')
  end
end
