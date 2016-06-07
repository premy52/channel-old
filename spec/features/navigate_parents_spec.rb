require 'spec_helper'

describe "Navigating parents" do 
	it "allows navigating from the individual parent page to the parents listing page" do
		parent = Parent.create(parent_attributes)
		visit parent_path(parent)
		click_link "All Parent Organizations"
		expect(current_path).to eq(parents_path)
	end
	it "allows navigating from the parents listing page to the individual parent page" do
		parent = Parent.create(parent_attributes)
		visit parents_path
		click_link parent.corpname
		expect(current_path).to eq(parent_path(parent))
	end
end