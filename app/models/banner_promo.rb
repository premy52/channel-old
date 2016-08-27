class BannerPromo < ActiveRecord::Base

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
		(self.startweek - 1) / 13 + 1
	end

	def year
		self.start_date.strftime("%Y").to_i
	end

	def yearquarter
		self.year * 100 + self.quarter
	end

	def promo_amount
		case promo_method
			when 'MCB'
				if self.promo_vehicle == 'Ad' || 'Lump Sum' 
					self.promo_level.to_f
				else
					self.promo_level * self.banner.dc.listprice / 12
				end
			when 'Scan'
				self.promo_level
			else
				fail
			end
	end

	def dollars_per_bar
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
						99
				end

			when 'Scan'
				case self.promo_vehicle
					when 'TPR', 'EDLP'
						self.promo_level
					when 'Ad', 'Lump', 
						7999
					when 'Coupon'
						fixed_amount = self.promo_level.to_f 
						bars = self.banner.cume_bssw * self.banner.banner_store_count
						weeks = (((self.end_date - self.start_date) +1)/7).to_f
						fixed_amount / (bars * weeks)		
					else
						5999
				end
		end
	end

	def total_spend_base

	end

	def dollars_per_bar_per_day
		self.dollars_per_bar / self.promo_days_count
	end

	def dollars_per_bar_isnum? 
	  true if Float(dollars_per_bar) rescue false
	end

	def basis_isnum? 
	  true if Float(basis) rescue false
	end

	def percent_of_list
		if dollars_per_bar_isnum?
			dollars_per_bar / (Fgsku::FULLSIZECADDYPRICE / 12 )
		else
			'n/a'
		end
	end

	def promo_margin_dollars
		if self.bar_feature_price
			(self.bar_feature_price )- (self.banner.caddy_actual_cost / 12 - self.dollars_per_bar)
		else
			nil 
		end
	end

	def promo_margin_pct
		if self.promo_margin_dollars
			self.promo_margin_dollars / self.bar_feature_price
		else
			nil 
		end
	end

	def lift_bars_per_week
		self.lift * self.banner.cume_bssw * promo_weeks_count
	end

end