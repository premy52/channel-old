class BannerPromo < ActiveRecord::Base

  before_validation :initialize_lift

	validates :comment,
						:start_date, 
					  :end_date,
					  :promo_vehicle,
					  :promo_method,
					  :status, 
					  presence: true

	validates :promo_level, 
						numericality: true, presence: true

	validate  :lump_sums_cant_be_scans

  belongs_to :banner



  	VEHICLES = [ 
		'TPR',
		'EDLP',
		'Ad',
		'Coupon',
		'Lump'
		]

		METHODS = [ 
		'MCB',
		'Scan'
		]

		STATUS = [ 
		'Plan',
		'Presented',
		'Approved',
		'Rejected',
		'Executed'
		]

	def lump_sums_cant_be_scans
		if promo_method == 'Scan' 
			case promo_vehicle 
			when 'Ad'
				errors.add(promo_vehicle, "can't be a Scan" )
			when 'Lump'
				errors.add(promo_vehicle, "can't be a Scan" )
			end
		end
	end

	def startweek
		self.start_date.strftime("%W").to_i
	end

	def endweek
		self.end_date.strftime("%W").to_i
	end

	def promo_weeks_count
		((self.end_date - self.start_date + 1 ).to_f / 7.0)
	end

	def promo_days_count
		((self.end_date - self.start_date + 1 ).to_f)
	end

	def quarter
		( self.start_date.month - 1 ) / 3 + 1		
	end

	def year
		self.start_date.strftime("%Y").to_i
	end

	def yearquarter
		self.year * 100 + self.quarter
	end

	def dollars_per_bar #promo $/bar calculated based on vehicle and method
		case self.promo_method

			when 'MCB'
				case self.promo_vehicle
					when 'TPR', 'EDLP'
						self.promo_level.to_f * self.banner.dc.listprice / 12
					when 'Ad', 'Lump', 'Coupon'
						fixed_amount = self.promo_level.to_f 
						bars = self.banner.cume_bssw * self.banner.banner_store_count
						weeks = (((self.end_date - self.start_date) +1)/7).to_f
						fixed_amount / (bars * weeks)					
					else
						fail
				end

			when 'Scan'
				case self.promo_vehicle
					when 'TPR', 'EDLP'
						self.promo_level
					when 'Ad', 'Lump', 
						6666
					when 'Coupon'
						fixed_amount = self.promo_level.to_f 
						bars = self.banner.cume_bssw * self.banner.banner_store_count
						weeks = (((self.end_date - self.start_date) +1)/7).to_f
						fixed_amount / (bars * weeks)		
					else
						fail
				end
		end
	end

	def dollars_per_bar_isnum? 
	  true if Float(dollars_per_bar) rescue false
	end

	def basis_isnum? 
	  true if Float(basis) rescue false
	end

	def percent_of_list #promo $/bar as % of our list price
		if dollars_per_bar_isnum?
			dollars_per_bar / (Fgsku::FULLSIZECADDYPRICE / 12 )
		else
			'n/a'
		end
	end

	def promo_margin_dollars #retailer margin $ per bar on promo
		if self.bar_feature_price
			(self.bar_feature_price )- (self.banner.caddy_actual_cost / 12 - self.dollars_per_bar)
		else
			nil 
		end
	end

	def promo_margin_pct #retailer margin % on promo
		if self.promo_margin_dollars
			self.promo_margin_dollars / self.bar_feature_price
		else
			nil 
		end
	end

	def total_promo_lift_bars #all stores, total promo period, this one promo, lift only
		self.lift * self.promo_weeks_count * self.banner.barsperweekbase
	end

	def total_promo_period_bars #all stores, total promo period, this one promo, lift + base
		self.total_promo_lift_bars + self.promo_weeks_count * self.banner.barsperweekbase
	end

	def total_lump_spend #all stores, all bars, total promo period, this one promo
		case self.promo_vehicle
			when 'TPR', 'EDLP'
				0
			when 'Ad', 'Lump', 'Coupon'
				self.promo_level
			else
				0
		end
	end

	def total_formula_spend #all stores, all bars, total promo period, this one promo
		case self.promo_vehicle
			when 'TPR', 'EDLP'
				self.dollars_per_bar * total_promo_period_bars
			when 'Ad', 'Lump', 'Coupon'
				0
			else
				0
		end
	end

 	def total_promo_spend #all stores, all bars, total promo period, this one promo
		total_formula_spend + total_lump_spend
	end

	def total_promo_spend_per_lift_bar
		if self.total_formula_spend > 0.0
			self.total_formula_spend / self.total_promo_lift_bars
		else
			'n/a'
		end
	end

	def total_promo_spend_percent_of_year_gross(year)
		self.total_promo_spend / self.banner.annual_gross_total(year)
	end

 	def initialize_lift
  	self.lift = 0.0 unless lift
  end

end