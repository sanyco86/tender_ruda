class TenderCreatedWorker
  include Sidekiq::Worker

  def perform(id)
    TendersMailer.tender_created(id).deliver
  end
end
