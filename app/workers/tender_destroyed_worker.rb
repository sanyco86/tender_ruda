class TenderDestroyedWorker
  include Sidekiq::Worker

  def perform(id)
    TendersMailer.tender_destroyed(id).deliver
  end
end
