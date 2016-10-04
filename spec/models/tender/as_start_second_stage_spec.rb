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

require 'rails_helper'

describe Tender::AsStartSecondStage do
  # attr_reader :sended_mails
  #
  # before_save :start_second_stage
  # after_commit :send_emails, no: [:start_second_stage]
  # before_save :price_second_stage_save
  #
  # private
  #
  # def start_second_stage
  #   self.status_id = OPENED
  #   self.etap = 2
  # end
  #
  # def send_emails
  #   users.each do |user|
  #     StartedSecondStageWorker.perform_async(self.id, user.id)
  #   end
  #   @sended_mails = users.count
  # end
  #
  # def price_second_stage_save
  #   user_items.each do |user_item|
  #     if user_item.first_price_second_stage.nil? && user_item.price.to_f >0
  #       user_item.update_attributes(first_price_second_stage: user_item.price)
  #     end
  #   end
  # end
end
