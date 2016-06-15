class Tender::AsCloseWithoutWinner < Tender
  attr_reader :sended_mails

  before_save :finish
  after_commit :send_emails, no: [:close_without_winner]

  private

  def finish
    self.status_id = FINISHED
  end

  def send_emails
    users.each do |user|
      TenderClosedWithoutWinnerWorker.perform_async(self.id, user.id)
    end
    @sended_mails = users.count
  end
end
