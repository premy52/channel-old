class Dc < ActiveRecord::Base

	validates :dc_name, presence: true, uniqueness: {scope: :distributor, message: "already exists for this distributor"}
	
  belongs_to :distributor
  has_many :stores
	has_many :banners
	has_many :dc_slots, dependent: :destroy
	has_many :slotted_fgskus, through: :dc_slots, source: :fgsku

	before_validation :generate_slug

#to refactor; also in authorization.rb
	def available_fgskus
#		Fgsku.where(country: self.country).order('sizegroup')
		Fgsku.where(country: self.country).includes(:flavor).order('sizegroup', "flavors.shorthand")
	end

	def to_param
		slug
	end

	def generate_slug
		self.slug ||= dc_name.parameterize if dc_name
	end

end