class NewTenderForUsersWorker
  include Sidekiq::Worker

  def perform(user_id, tender_id)
    TendersMailer.new_tender_for_users(user_id, tender_id).deliver
  end
end