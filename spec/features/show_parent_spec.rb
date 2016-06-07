require 'spec_helper'

describe "Viewing an individual parent page" do 

	it "shows that individual parent and its attributes" do
		p = Parent.create(parent_attributes)
		visit parent_path(p)
		expect(page).to have_text(p.corpname)
		expect(page).to have_text(p.hqcity)
		expect(page).to have_text(p.hqstate)
		expect(page).to have_text(p.buyerfirstname)
		expect(page).to have_text(p.buyerlastname)
		expect(page).to have_text(p.ourbrokerfirstname)
		expect(page).to have_text(p.ourbrokerlastname)
		expect(page).to have_text(p.nextreviewdate)		
	end

end