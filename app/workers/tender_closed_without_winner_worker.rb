class TenderClosedWithoutWinnerWorker
  include Sidekiq::Worker

  def perform(tender_id, user_id)
    TendersMailer.tender_closed_without_winner(tender_id, user_id).deliver
  end
end