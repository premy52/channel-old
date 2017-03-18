class Fgsku < ActiveRecord::Base

	SIZEGROUPS = [ 
		'Full Size Bar', 
		'Mini Bar'
	]

	FULLSIZECADDYPRICE = 15.0
	FULLSIZEBARPRICE = FULLSIZECADDYPRICE / 12.0
	FULLSIZECADDYCOGS = 7.88
	# less shipping, brokerage, terms, spoils
	FULLSIZECADDYVCPREPROMO = FULLSIZECADDYPRICE * ( 1.0 - 0.05 - 0.05 - 0.02 - 0.01 ) - FULLSIZECADDYCOGS

	COUNTRIES = [
		'U.S.',
		'Canada'
	]
  belongs_to :flavor
	has_many :authorizations, dependent: :destroy
	has_many :authorizing_banners, through: :authorizations, source: :banner
	has_many :dc_slots, dependent: :destroy
	has_many :slotting_dcs, through: :dc_slots, source: :dc
	#, -> { where fgsku_id: :id }
	#has_many :dc_slots, -> { where fgsku_id: 7 }


#  has_many :versions, dependent: :destroy	

	validates :sizegroup, :country, presence: true


	def fgskus_alphabetical
		Fgsku.all.order('country', 'sizegroup')

#		g = f.map { |f| "#{f.country} #{f.sizegroup} #{f.flavor.shorthand} " }
	end

#	def fgskus_available
#		Fgsku.where(country: :country).order(flavor.shorthand)
#		Fgsku.where(country: @banner.country).order('sizegroup',"#{:flavor_id}")
#	end

	def flavor_descriptor
		"#{self.flavor.shorthand} #{sizegroup}"
	end

end