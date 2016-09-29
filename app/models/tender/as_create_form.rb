# == Schema Information
#
# Table name: tenders
#
#  id               :integer          not null, primary key
#  name             :string
#  category_id_del  :integer
#  status_id        :integer          default(1)
#  uslovie          :string
#  dopuslovie       :string
#  data_start       :datetime
#  data_end         :datetime
#  manager_id       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  fls_file_name    :string
#  fls_content_type :string
#  fls_file_size    :integer
#  fls_updated_at   :datetime
#  etap             :integer          default(1)
#

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
