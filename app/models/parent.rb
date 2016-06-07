class Parent < ActiveRecord::Base
	CHANNELS = [ 
		'Natural Grocery',
		'Conventional Grocery',
		'Supplement',
		'Mass Merchandise',
		'Foodservice',
		'Online',
		'Not Classified'
		]

	validates :corpname, presence: true, uniqueness: true
	validates :channel_segment, inclusion: { in: CHANNELS }
	validates :store_count, allow_blank: true, numericality: {
		only_integer: true, greater_than: -1,
		message: "must be positive"
	}
	validates :logo_file_name, allow_blank: true, format: {
		with: /\w+\.(gif|jpg|png|bmp)\z/i,
		message: "must reference a GIF, JPG, PNG or BMP image"
	}

	has_many :banners, dependent: :destroy

	before_validation :generate_slug

	def empty?
		corpname == nil 
	end

	def self.reviewimminent
		where("nextreviewdate <= ?", 90.days.from_now).order("nextreviewdate")
	end

	def noreviewdate
		nextreviewdate <= Date.today
	end

	def to_param
		slug
	end

	def generate_slug
		self.slug ||= corpname.parameterize if corpname
	end

end