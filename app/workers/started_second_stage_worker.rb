class StartedSecondStageWorker
  include Sidekiq::Worker

  def perform(tender_id, user_id)
    TendersMailer.started_second_stage(tender_id, user_id).deliver
  end
end