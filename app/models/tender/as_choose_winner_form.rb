class Tender::AsChooseWinnerForm < Tender
  accepts_nested_attributes_for :items

  attr_reader :sended_mails

  before_save :finish
  after_commit :send_emails, no: [:decide]

  private

  def finish
    self.status_id = FINISHED
  end

  def send_emails
    users.each do |user|
      TenderResultsWorker.perform_async(self.id, user.id)
    end
    @sended_mails = users.count
  end
end
