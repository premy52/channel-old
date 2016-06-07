class Authorization < ActiveRecord::Base
  belongs_to :banner
  belongs_to :fgsku

  before_validation :initialize_bssw

#to refactor; also in dc_slot.rb
	def flavor_descriptor
		"#{self.fgsku.flavor.shorthand} #{self.fgsku.sizegroup}"
  end

  def initialize_bssw
  	self.bssw = 0 unless bssw
  end
  
end
