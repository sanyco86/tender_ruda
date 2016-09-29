# == Schema Information
#
# Table name: measure_units
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MeasureUnit < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
end
