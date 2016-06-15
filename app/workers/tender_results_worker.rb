class TenderResultsWorker
  include Sidekiq::Worker

  def perform(tender_id, user_id)
    TendersMailer.tender_results(tender_id, user_id).deliver
  end
end