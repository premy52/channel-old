module BannerPromosHelper

		def banner_promo_basis_text promo_vehicle, promo_method, promo_level
		case promo_method
		
			when 'MCB'
				case promo_vehicle
					when 'TPR', 'EDLP'
						"#{number_to_percentage(promo_level*100, precision: 0)}DC"
					when 'Ad', 'Lump', 'Coupon'
						number_to_currency(promo_level, precision: 0)
					else
						'error'
				end
			
			when 'Scan'
				case promo_vehicle
					when 'TPR', 'EDLP'
						'$/bar'
					when 'Ad', 'Lump'
						'error'
					when 'Coupon'
						number_to_currency(promo_level, precision: 0)
					else
						'error'
				end
		end
	end	
	
end