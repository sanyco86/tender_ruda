class UserItem < ActiveRecord::Base
  belongs_to :user_tender
  belongs_to :item
  delegate :user, :user_id, to: :user_tender

  validates :price, presence: true,
            unless: Proc.new {|a| a.delivery.blank?}

  validates :delivery, presence: true,
            unless: Proc.new {|a| a.price.blank?}

  validates :price, :delivery, {numericality: {greater_than: 0, :allow_nil => true}}

  before_save :first_price_save
  before_save :total_price_save
  before_update :first_price_second_stage_update

  scope :with_price, -> { where.not(price: nil) }

  def first_price_save
    self.first_price = price if first_price.nil? && price.to_f >0
  end

  def first_price_second_stage_update
    if user_tender.tender.etap == 2
      self.first_price_second_stage = price if first_price_second_stage.nil? && price.to_f >0
    end
  end

  def total_price_save
    unless price.nil?
      self.total_price = price * item.quantity
    end
  end

  def price=(val)
    val.sub!(',', '.') if val.is_a?(String)
    self['price'] = val
  end
end