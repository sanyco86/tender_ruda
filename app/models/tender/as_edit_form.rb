class Tender::AsEditForm < Tender
  accepts_nested_attributes_for :items, reject_if: lambda {|attributes| attributes['name'].blank?}, allow_destroy: true
end
