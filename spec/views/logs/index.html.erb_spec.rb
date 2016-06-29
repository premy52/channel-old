require 'spec_helper'

describe "logs/index" do
  before(:each) do
    assign(:logs, [
      stub_model(Log,
        :log_notes => "MyText",
        :outcome => "Outcome",
        :review => "Review",
        :action => "Action",
        :action_status => "Action Status",
        :parent => nil,
        :banner => nil,
        :distributor => nil,
        :dc => nil,
        :broker => "Broker",
        : => nil,
        :manager => nil,
        :store => nil
      ),
      stub_model(Log,
        :log_notes => "MyText",
        :outcome => "Outcome",
        :review => "Review",
        :action => "Action",
        :action_status => "Action Status",
        :parent => nil,
        :banner => nil,
        :distributor => nil,
        :dc => nil,
        :broker => "Broker",
        : => nil,
        :manager => nil,
        :store => nil
      )
    ])
  end

  it "renders a list of logs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Outcome".to_s, :count => 2
    assert_select "tr>td", :text => "Review".to_s, :count => 2
    assert_select "tr>td", :text => "Action".to_s, :count => 2
    assert_select "tr>td", :text => "Action Status".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Broker".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
