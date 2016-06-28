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
	
	has_many :dcs, dependent: :destroy

#	before_validation :generate_slug	

	def dc_count
		self.dcs.count
	end

	def stocking_dcs_count
		self.dcs.where(id: DcSlot.select(:dc_id)).count
#		Dc.where(id: DcSlot.select(:dc_id)).count
	end

  def to_param
		slug
	end

	# def generate_slug
	# 	self.slug ||= distributor_name.parameterize if distributor_name
	# end

end