class TenderCategory < ActiveRecord::Base
  belongs_to :tender
  belongs_to :category
end
