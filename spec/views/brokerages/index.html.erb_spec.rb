require 'spec_helper'

describe "brokerages/index" do
  before(:each) do
    assign(:brokerages, [
      stub_model(Brokerage,
        :company => "Company",
        :address1 => "Address1",
        :address2 => "Address2",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :rate => "9.99"
      ),
      stub_model(Brokerage,
        :company => "Company",
        :address1 => "Address1",
        :address2 => "Address2",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :rate => "9.99"
      )
    ])
  end

  it "renders a list of brokerages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Company".to_s, :count => 2
    assert_select "tr>td", :text => "Address1".to_s, :count => 2
    assert_select "tr>td", :text => "Address2".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
