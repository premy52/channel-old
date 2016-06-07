class BannerPromo < ActiveRecord::Base

	validates :comment,
						:start_date, 
					  :end_date,
					  :promo_vehicle,
					  :promo_method,
					  :status, presence: true
	validates :promo_level, numericality: true, presence: true

  belongs_to :banner

  	VEHICLES = [ 
		'TPR',
		'EDLP',
		'Ad',
		'Display',
		'Case Stack',
		'Lump Sum',
		'Not Classified'
		]

		METHODS = [ 
		'Distributor OI',
		'MCB',
		'Scan',
		'Not Classified'
		]

		STATUS = [ 
		'Plan',
		'Presented',
		'Approved',
		'Rejected',
		'Executed'
		]

end
