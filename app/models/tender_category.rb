# == Schema Information
#
# Table name: tender_categories
#
#  id          :integer          not null, primary key
#  tender_id   :integer
#  category_id :integer
#

class TenderCategory < ActiveRecord::Base
  belongs_to :tender
  belongs_to :category
end
