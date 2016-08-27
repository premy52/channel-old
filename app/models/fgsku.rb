class Fgsku < ActiveRecord::Base

	SIZEGROUPS = [ 
		'Full Size Bar', 
		'Mini Bar'
	]

	FULLSIZECADDYPRICE = 15.0

	COUNTRIES = [
		'U.S.',
		'Canada'
	]
  belongs_to :flavor
	has_many :authorizations, dependent: :destroy
	has_many :authorizing_banners, through: :authorizations, source: :banner
	has_many :dc_slots, dependent: :destroy
	has_many :slotting_dcs, through: :authorizations, source: :dc


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