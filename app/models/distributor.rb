class Distributor < ActiveRecord::Base

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

	validates :distributor_name, :country, presence: true, uniqueness: true
	validates :channel_segment, inclusion: { in: CHANNELS }
	
	has_many :dcs, dependent: :destroy

	before_validation :generate_slug	

	def dc_count
		self.dcs.count
	end

  def to_param
		slug
	end

	def generate_slug
		self.slug ||= distributor_name.parameterize if distributor_name
	end

end