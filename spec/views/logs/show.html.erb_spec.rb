require 'spec_helper'

describe "logs/show" do
  before(:each) do
    @log = assign(:log, stub_model(Log,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/Outcome/)
    rendered.should match(/Review/)
    rendered.should match(/Action/)
    rendered.should match(/Action Status/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Broker/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
  end
end
