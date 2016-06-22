class Broker < ActiveRecord::Base
  extend FriendlyId
  friendly_id :last_name, use: :slugged

  belongs_to :brokerage
  end
