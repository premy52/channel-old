require 'spec_helper'

describe "A parent" do 

	it "is empty if corpname is nil" do
		parent = Parent.new(corpname: nil)
		expect(parent.empty?).to eq(true)
	end
	
	it "is  empty if corpname is blank" do
		parent = Parent.new(corpname: "")
		expect(parent.empty?).to eq(false)
	end

	it "is not empty if corpname is present" do
		parent = Parent.new(corpname: "x")
		expect(parent.empty?).to eq(false)
	end

end