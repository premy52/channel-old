require 'spec_helper'

describe "brokerages/show" do
  before(:each) do
    @brokerage = assign(:brokerage, stub_model(Brokerage,
      :company => "Company",
      :address1 => "Address1",
      :address2 => "Address2",
      :city => "City",
      :state => "State",
      :zip => "Zip",
      :rate => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Company/)
    rendered.should match(/Address1/)
    rendered.should match(/Address2/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/Zip/)
    rendered.should match(/9.99/)
  end
end
