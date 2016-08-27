class Banner < ActiveRecord::Base
	extend FriendlyId
	friendly_id :banner_name, use: :slugged

	before_validation :initialize_actual_cost

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
	belongs_to :broker
	has_many :stores, dependent: :destroy
	has_many :banner_promos, dependent: :destroy
	has_many :logs
	has_many :authorizations, dependent: :destroy
	has_many :authorized_fgskus, through: :authorizations, source: :fgsku
	has_many :banner_cost_retails

  before_validation :initialize_banner_store_count
  before_validation :initialize_our_banner_store_count
	before_validation :initialize_actual_cost

  scope :all_banners, -> { Banner.all.order("banner_name") }
  scope :current_banners, -> { Banner.joins(:authorizations).distinct.order("banner_name") }
  scope :prospect_banners, -> { Banner.where.not(id: Authorization.select(:banner_id)).order("banner_name") }
  scope :priority_banners, -> { Banner.where("priority > ?", 0).order("priority") }

	def to_param
		"#{id}-#{banner_name.parameterize}"
	end

	def our_store_percent
		100 * self.our_banner_store_count.to_f / self.banner_store_count.to_f
	end

	def noreviewdate
		banner_review_date <= Date.today
	end

#to refactor; also in dc.rb
	def available_fgskus
		Fgsku.where(country: self.country).includes(:flavor).order('sizegroup', "flavors.shorthand")
	end

	def has_authorizations
		authorizations.any?
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
		if self.authorizations.present?
			self.authorizations.inject(0) { |sum, auth| sum += auth.bssw * self.our_banner_store_count }.round(2)
		else
			0
		end
	end

	def quarter_bars_base
		self.barsperweek * 13
	end

	def quarter_bars_lift(yearquarter)
		if self.banner_promos.present?
			self.banner_promos.where(yearquarter: yearquarter).inject(0) { |sum, promo| sum += promo.promo_lift_bars_per_store * self.our_banner_store_count }.round(2)
		else
			0
		end
	end

	def annual_gross
		self.cume_bssw * self.banner_store_count * 52 * Fgsku::FULLSIZECADDYPRICE / 12
	end

	def annual_brokerage
		self.annual_gross * self.broker.brokerage.rate / 100
	end

	def nominal_retail_margin_pct
		cost = (self.dc.listprice || 0 ) / 12
		shelf = self.bar_regular_retail
		if shelf 
			margin_pct = (shelf - cost) / shelf
		else
			0
		end
	end

	def nominal_retail_margin_dollars
		cost = (self.dc.listprice || 0 ) / 12
		shelf = self.bar_regular_retail
		if shelf 
			margin_dollars = (shelf - cost)
		else
			0
		end
	end

	def actual_retail_margin_pct
		cost = (self.caddy_actual_cost  || 0 ) / 12
		shelf = self.bar_regular_retail
		if shelf && caddy_actual_cost
			margin_pct = (shelf - cost) / shelf
		else
			0
		end
	end

	def actual_retail_margin_dollars
		cost = (self.caddy_actual_cost  || 0 ) / 12
		shelf = self.bar_regular_retail
		if shelf && caddy_actual_cost
			margin_dollars = (shelf - cost) 
		else
			0
		end
	end

	def to_param
		slug
	end

	# def generate_slug
	# 	self.slug = banner_name.parameterize if banner_name
	# end

 	def initialize_banner_store_count
  	self.banner_store_count = 1 unless banner_store_count
  end
	def initialize_our_banner_store_count
  	self.our_banner_store_count = 0 unless our_banner_store_count
  end

  def initialize_actual_cost
		self.caddy_actual_cost = ( Fgsku::FULLSIZECADDYPRICE * 100.0 * 4.0 / 3.0).round / 100 unless caddy_actual_cost
	end
 
end