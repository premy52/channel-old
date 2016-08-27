class Dc < ActiveRecord::Base
	
	extend FriendlyId
	friendly_id :dc_name, use: :slugged

	validates :dc_name, presence: true, uniqueness: {scope: :distributor, message: "already exists for this distributor"}
	
  belongs_to :distributor
  has_many :stores
	has_many :banners
	has_many :logs
	has_many :dc_slots, dependent: :destroy
	has_many :dc_dc_cost_lists, dependent: :destroy
	has_many :slotted_fgskus, through: :dc_slots, source: :fgsku

	before_validation :initialize_listprice
	
#to refactor; also in authorization.rb
	def available_fgskus
#		Fgsku.where(country: self.country).order('sizegroup')
		Fgsku.where(country: self.country).includes(:flavor).order('sizegroup', "flavors.shorthand")
	end

	def to_param
		slug
	end

	def has_slots?
		self.dc_slots.any?
	end

	def total_slots
		self.dc_slots.count
	end

	def self.dcs_with_banners
		Dc.joins(:banners).distinct.order("dc_name")
	end

	def self.dcs_with_current_banners
		Dc.where(id: Banner.current_banners.select(:dc_id)).order("dc_name")
	end

	def self.dcs_with_prospect_banners
		Dc.where(id: Banner.prospect_banners.select(:dc_id)).order("dc_name")
	end

	def initialize_listprice
		if self.listprice.blank?
			self.listprice = ( Fgsku::FULLSIZECADDYPRICE * 100.0 * 4.0 / 3.0).round / 100
		end
	end


end
