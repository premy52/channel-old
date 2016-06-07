module ParentsHelper

	def image_for(parent)
		if parent.logo_file_name.blank?
			image_tag 'placeholder.png'
		else
			image_tag parent.logo_file_name, height: '48'
		end
	end

end