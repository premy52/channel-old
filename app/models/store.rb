class Store < ActiveRecord::Base

	validates :store_name, presence: true, uniqueness: {scope: :banner, message: "already exists for this banner"}
#	validates :slug, uniqueness: true
	validates :dc_id, presence: true

  belongs_to :banner
  belongs_to :dc

  before_validation :generate_slug

  def to_param
		slug
	end

	def generate_slug
		self.slug ||= store_name.parameterize if store_name
	end

end
