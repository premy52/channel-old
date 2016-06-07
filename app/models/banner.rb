class Banner < ActiveRecord::Base
	#extend FriendlyId
	#friendly_id :banner_name, use: :slugged

	validates :banner_name, presence: true, uniqueness: {scope: :parent, message: "already exists for this parent company"}
	validates :country, presence: true
	validates :banner_store_count, allow_blank: true, numericality: {
		only_integer: true, greater_than: -1,
		message: "must be positive"
	}
	validates :logo_file_name, allow_blank: true, format: {
		with: /\w+\.(gif|jpg|png|bmp)\z/i,
		message: "must reference a GIF, JPG, PNG or BMP image"
	}

  belongs_to :parent
	belongs_to :dc
	has_many :stores, dependent: :destroy
	has_many :banner_promos, dependent: :destroy
	has_many :authorizations, dependent: :destroy
	has_many :authorized_fgskus, through: :authorizations, source: :fgsku
#	has_many :fgskus, through: :authorizations

	before_validation :generate_slug
  before_validation :initialize_banner_store_count

	def to_param
		"#{id}-#{banner_name.parameterize}"
	end

	def all_banners
		Banner.all.order("banner_name")
	end

  def noreviewdate
		banner_review_date <= Date.today
	end

#to refactor; also in dc.rb
	def available_fgskus
		Fgsku.where(country: self.country).includes(:flavor).order('sizegroup', "flavors.shorthand")
	end

	def has_authorizations
		self.authorizations.any?
	end

	def total_authorizations
		self.authorized_fgskus.size
	end

	def auth_flavor_bssw_hash
		this_hash = {}
		self.authorizations.each do |authorization|
			key = authorization.fgsku.flavor.shorthand
			value = authorization.bssw
			this_hash.store(key, value)
		end
		this_hash
	end

	def cume_bssw
		if self.authorizations.present?
			self.authorizations.inject(0) { |sum, e| sum += e.bssw }.round(2)
		else
			0
		end
	end

	def average_bssw
		if self.total_authorizations > 0 
			average_bssw = cume_bssw / total_authorizations
		else
			average_bssw = 0
		end
	end

	def barsperweek
		self.authorizations.inject(0) { |sum, e| sum += e.bssw * self.banner_store_count }.round(2)
	end

	def to_param
		slug
	end

	def generate_slug
		self.slug = banner_name.parameterize if banner_name
	end

 def initialize_banner_store_count
  	self.banner_store_count = 0 unless banner_store_count
  end
 
end