require 'spec_helper'

describe "Viewing the parents page" do 
	it "shows the list of parents with their attributes" do
		parent1 = Parent.create(corpname: "Kroger",
														hqcity: "Cincinnati",
														hqstate: "OH",
														buyerfirstname: "Nate",
														buyerlastname: "Wolecsza",
														ourbrokerfirstname: "Phil",
														ourbrokerlastname: "Storage",
														nextreviewdate: "2018-02-16",
														channel_segment: "Online"
														)
		parent2 = Parent.create(corpname: "Delhaize",
														hqcity: "Cincinnati",
														hqstate: "OH",
														buyerfirstname: "John",
														buyerlastname: "TeeBeeDee",
														ourbrokerfirstname: "That",
														ourbrokerlastname: "Guy",
														nextreviewdate: "2018-02-16",
														channel_segment: "Online" 
														)
		parent3 = Parent.create(corpname: "Whole Foods",
														hqcity: "Austin",
														hqstate: "TX",
														buyerfirstname: "Doan",
														buyerlastname: "Noah",
														ourbrokerfirstname: "Mary",
														ourbrokerlastname: "Golightly",
														nextreviewdate: "2018-02-16",
														channel_segment: "Online" 
														)
		visit parents_path
		expect(page).to have_text("3 Parent Organizations")
		expect(page).to have_text(parent1.corpname)
		expect(page).to have_text(parent2.corpname)
		expect(page).to have_text(parent3.corpname)
		expect(page).to have_text(parent1.nextreviewdate)
		expect(page).to have_text(parent2.nextreviewdate)
		expect(page).to have_text(parent3.nextreviewdate)
	end
end