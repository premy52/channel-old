class Flavor < ActiveRecord::Base

	extend FriendlyId
	friendly_id :shorthand, use: :slugged

# RANK based on UNFI Ridgefield cases 1/1/16 - 5/30/16
RANK = { 	"CC" 		=> 1,   # 45 cs
					"CPB" 	=> 2,   # 36 cs
					"DCM" 	=> 3,   # 36 cs
					"PBCC" 	=> 4,   # 36 cs
					"DCH" 	=> 5,   # 27 cs
					"OCC" 	=> 6,   # 24 cs
					"LEM"		=> 7,   # 15 cs
					"MOCA"	=> 8,	  # 15 cs
					"CO"		=> 9,   # 14 cs
					"CCC" 	=> 10,  # 12 cs
					"AB"		=> 11,  # 12 cs
					"DNB" 	=> 12   #  9 cs
		}

	validates :shorthand, :descriptor, presence: true, uniqueness: true
	
	has_many :fgskus, dependent: :destroy
	has_many :recipes, dependent: :destroy	

#	before_validation :generate_slug

	def to_param
		slug
	end
	
	# def generate_slug
	# 	self.slug ||= shorthand.parameterize if shorthand
	# end

	def self.ranked_flavors
		Flavor.order(:rank)
	end

end
