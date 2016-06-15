class Tender::AsCreateForm < Tender::AsEditForm
  after_commit :send_notifications, on: [:create]
  attr_reader :recipients_count

  private
  def send_notifications
    recipients = User.includes(:user_categories).where(user_categories: {category_id: categories.ids})
    recipients.each do |recipient|
      NewTenderForUsersWorker.perform_async(recipient.id, self.id)
    end
    @recipients_count = recipients.count
  end
end
