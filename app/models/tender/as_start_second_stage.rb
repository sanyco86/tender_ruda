class Tender::AsStartSecondStage < Tender
  attr_reader :sended_mails

  before_save :start_second_stage
  after_commit :send_emails, no: [:start_second_stage]
  before_save :price_second_stage_save

  private

  def start_second_stage
    self.status_id = OPENED
    self.etap = 2
  end

  def send_emails
    users.each do |user|
      StartedSecondStageWorker.perform_async(self.id, user.id)
    end
    @sended_mails = users.count
  end

  def price_second_stage_save
    user_items.each do |user_item|
      if user_item.first_price_second_stage.nil? && user_item.price.to_f >0
        user_item.update_attributes(first_price_second_stage: user_item.price)
      end
    end
  end
end