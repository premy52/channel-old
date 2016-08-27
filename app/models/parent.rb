class Parent < ActiveRecord::Base
	
	extend FriendlyId
	friendly_id :corpname, use: :slugged

	CHANNELS = [ 
		'Natural Grocery',
		'Conventional Grocery',
		'Drug',
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

	belongs_to :broker
	has_many :banners, dependent: :destroy
	has_many :logs

#	before_validation :generate_slug

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

	def banners_count
		self.banners.count
	end

	def stocking_banners
		Parent.joins(:banners.current_banners).order("banner_store_count")
	end

	def stocking_banners_count
		self.stocking_banners.count
	end

	# def generate_slug
	# 	self.slug ||= corpname.parameterize if corpname
	# end

end