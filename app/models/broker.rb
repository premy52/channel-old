class Broker < ActiveRecord::Base
  extend FriendlyId
  friendly_id :last_name, use: :slugged

	validates :first_name, :last_name, presence: true

  belongs_to :brokerage
  has_many :banners
  end
