class Distributor < ActiveRecord::Base

	extend FriendlyId
	friendly_id :distributor_name, use: :slugged

	CHANNELS = [ 
		'Natural Grocery',
		'Conventional Grocery',
		'Supplement',
		'Mass Merchandise',
		'Foodservice',
		'Online Affiliate',
		'Own Online',
		'Not Classified'
		]

	validates :distributor_name, uniqueness: true
	validates :country, presence: true
	validates :channel_segment, inclusion: { in: CHANNELS }
	
	belongs_to :broker
	has_many :logs
	has_many :dcs, dependent: :destroy

#	before_validation :generate_slug	

	def dc_count
		self.dcs.count
	end

	def stocking_dcs_count
		self.dcs.where(id: DcSlot.select(:dc_id)).count
#		Dc.where(id: DcSlot.select(:dc_id)).count
	end

	def self.distributors_with_current_banners
		Distributor.where(id: Dc.dcs_with_current_banners.select(:distributor_id)).order("distributor_name")
	end

	def distributor_current_banner_count
		distributors_with_current_banners.count
	end

	def self.distributors_with_prospect_banners
		Distributor.where(id: Dc.dcs_with_prospect_banners.select(:distributor_id)).order("distributor_name")
	end

	def distributor_prospect_banner_count
		distributors_with_prospect_banners.count
	end

 #  def to_param
	# 	slug
	# end

	# def generate_slug
	# 	self.slug ||= distributor_name.parameterize if distributor_name
	# end

end