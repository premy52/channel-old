require 'spec_helper'

describe "logs/new" do
  before(:each) do
    assign(:log, stub_model(Log,
      :log_notes => "MyText",
      :outcome => "MyString",
      :review => "MyString",
      :action => "MyString",
      :action_status => "MyString",
      :parent => nil,
      :banner => nil,
      :distributor => nil,
      :dc => nil,
      :broker => "MyString",
      : => nil,
      :manager => nil,
      :store => nil
    ).as_new_record)
  end

  it "renders new log form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", logs_path, "post" do
      assert_select "textarea#log_log_notes[name=?]", "log[log_notes]"
      assert_select "input#log_outcome[name=?]", "log[outcome]"
      assert_select "input#log_review[name=?]", "log[review]"
      assert_select "input#log_action[name=?]", "log[action]"
      assert_select "input#log_action_status[name=?]", "log[action_status]"
      assert_select "input#log_parent[name=?]", "log[parent]"
      assert_select "input#log_banner[name=?]", "log[banner]"
      assert_select "input#log_distributor[name=?]", "log[distributor]"
      assert_select "input#log_dc[name=?]", "log[dc]"
      assert_select "input#log_broker[name=?]", "log[broker]"
      assert_select "input#log_[name=?]", "log[]"
      assert_select "input#log_manager[name=?]", "log[manager]"
      assert_select "input#log_store[name=?]", "log[store]"
    end
  end
end
