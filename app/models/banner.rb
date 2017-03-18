class Banner < ActiveRecord::Base
	extend FriendlyId
	friendly_id :banner_name, use: :slugged

	before_validation :initialize_actual_cost
  before_validation :initialize_banner_store_count
  before_validation :initialize_our_banner_store_count
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


  scope :all_banners, -> { Banner.all.order("banner_name") }
  scope :current_banners, -> { Banner.joins(:authorizations).distinct.order("banner_name") }
  scope :prospect_banners, -> { Banner.where.not(id: Authorization.select(:banner_id)).order("banner_name") }
  scope :priority_banners, -> { Banner.where("priority > ?", 0).order("priority") }

	def to_param
		"#{id}-#{banner_name.parameterize}"
	end

# BANNER LEVEL FIXED -----------------------------------------
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

	def barsperweekbase
		if self.authorizations.present?
			self.authorizations.inject(0) { |sum, auth| sum += auth.bssw * self.our_banner_store_count }.round(2)
		else
			0
		end
	end

	# QUARTERLIES -------------------------------------------------

	def quarter_gross_base
		self.cume_bssw * self.banner_store_count * 13 * Fgsku::FULLSIZECADDYPRICE / 12
	end

	def quarter_bars_base
		self.barsperweekbase * 13
	end

	def quarter_gross_lift(year,quarter)
		self.banner_quarter_lift_bars(year,quarter) * Fgsku::FULLSIZECADDYPRICE / 12
	end

	def quarter_gross_total(year,quarter)
		self.quarter_gross_base + quarter_gross_lift(year,quarter)
	end

	def quarter_start_date(year, quarter)
		quarter_start_month = 3 * (quarter -1) + 1
		Date.new(year,quarter_start_month,1)
	end

	def quarter_end_date(year, quarter)
		quarter_end_month = 3 * quarter 
		Date.new(year,quarter_end_month,-1)
	end

	def banner_quarter_promos(year,quarter)
		self.banner_promos.where( start_date: (quarter_start_date(year, quarter)..quarter_end_date(year,quarter) ) )
	end

	def banner_quarter_lift_bars(year,quarter)
		lift_bars = 0
		self.banner_quarter_promos(year,quarter).each do |promo|
			lift_bars += promo.total_promo_lift_bars
		end
		lift_bars
	end

	def banner_quarter_total_bars(year,quarter)
		self.quarter_bars_base + self.banner_quarter_lift_bars(year,quarter)
	end

	def banner_quarter_formula_spend(year,quarter)
		formula_spend = 0
		self.banner_quarter_promos(year,quarter).each do |promo|
			formula_spend += promo.total_formula_spend
		end
		formula_spend
	end

	def banner_quarter_lump_spend(year,quarter)
		lump_spend = 0
		self.banner_quarter_promos(year,quarter).each do |promo|
			lump_spend += promo.total_lump_spend
		end
		lump_spend
	end

	def banner_quarter_promo_spend(year,quarter)
		self.banner_quarter_formula_spend(year,quarter) + self.banner_quarter_lump_spend(year,quarter)
	end

	def banner_quarter_formula_spend_percent(year,quarter)
		self.banner_quarter_formula_spend(year,quarter) / quarter_gross_total(year,quarter)
	end

	def banner_quarter_lump_spend_percent(year,quarter)
		self.banner_quarter_lump_spend(year,quarter) / quarter_gross_total(year,quarter)
	end

	def banner_quarter_total_spend_percent(year,quarter)
		self.banner_quarter_formula_spend_percent(year,quarter) + banner_quarter_lump_spend_percent(year,quarter)
	end


	# ANNUALS -------------------------------------------------

	def annual_gross_base
		self.cume_bssw * self.our_banner_store_count * 52 * Fgsku::FULLSIZECADDYPRICE / 12
	end

	def year_gross_lift(year)
		self.banner_year_lift_bars(year) * Fgsku::FULLSIZECADDYPRICE / 12
	end

	def annual_gross_total(year)
		self.annual_gross_base + self.year_gross_lift(year)
	end

	def annual_gross_lift_percent(year)
		 self.year_gross_lift(year) / self.annual_gross_base
	end

	def annual_brokerage
		self.annual_gross_base * self.broker.brokerage.rate / 100
	end

	def year_bars_base
		self.barsperweekbase * 365 / 7
	end

	def annual_vc_base
		Fgsku::FULLSIZECADDYVCPREPROMO * year_bars_base / 12
	end

	def annual_vc_base_percent
		self.annual_vc_base / self.annual_gross_base
	end

	def year_start_date(year)
		Date.new(year,1,1)
	end

	def year_end_date(year)
		Date.new(year,12,31)
	end

	def banner_year_promos(year)
		self.banner_promos.where( start_date: (year_start_date(year)..year_end_date(year) ) )
	end

	def banner_year_lift_bars(year)
		lift_bars = 0
		self.banner_year_promos(year).each do |promo|
			lift_bars += promo.total_promo_lift_bars
		end
		lift_bars
	end

	def banner_year_total_bars(year)
		self.year_bars_base + self.banner_year_lift_bars(year)
	end

	def annual_vc_pre_promo(year)
		Fgsku::FULLSIZECADDYVCPREPROMO * banner_year_total_bars(year) / 12
	end

	def annual_vc_pre_promo_percent(year)
		self.annual_vc_pre_promo(year) / self.annual_gross_total(year)
	end

	def annual_vc_post_promo(year)
		self.annual_vc_pre_promo(year) - self.banner_year_promo_spend(year)
	end

	def annual_vc_post_promo_percent(year)
		self.annual_vc_post_promo(year) / self.annual_gross_total(year)
	end

	def annual_vc_promo_change_percent(year)
		self.annual_vc_post_promo(year) / self.annual_vc_base - 1
	end

	def banner_year_formula_spend(year)
		formula_spend = 0
		self.banner_year_promos(year).each do |promo|
			formula_spend += promo.total_formula_spend
		end
		formula_spend
	end

	def banner_year_formula_spend_percent(year)
		self.banner_year_formula_spend(year) / annual_gross_total(year)
	end

	def banner_year_lump_spend(year)
		lump_spend = 0
		self.banner_year_promos(year).each do |promo|
			lump_spend += promo.total_lump_spend
		end
		lump_spend
	end

	def banner_year_lump_spend_percent(year)
		self.banner_year_lump_spend(year) / annual_gross_total(year)
	end

	def banner_year_promo_spend(year)
		self.banner_year_formula_spend(year) + self.banner_year_lump_spend(year)
	end

	def banner_year_promo_spend_percent(year)
		self.banner_year_formula_spend_percent(year) + banner_year_lump_spend_percent(year)
	end



# SETUPS -----------------------------------------------------

	def to_param
		slug
	end

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