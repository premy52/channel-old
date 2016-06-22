class Brokerage < ActiveRecord::Base
  extend FriendlyId
  friendly_id :company, use: :slugged

	validates :rate, numericality: true

	has_many :brokers

end
