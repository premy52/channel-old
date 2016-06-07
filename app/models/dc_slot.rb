class DcSlot < ActiveRecord::Base
  belongs_to :dc
  belongs_to :fgsku

  #to refactor; also in authorization.rb
	def flavor_descriptor
		"#{self.fgsku.flavor.shorthand} #{self.fgsku.sizegroup}"
  end

end
