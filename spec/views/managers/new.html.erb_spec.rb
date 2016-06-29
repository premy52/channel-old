require 'spec_helper'

describe "managers/new" do
  before(:each) do
    assign(:manager, stub_model(Manager,
      :first_name => "MyString",
      :last_name => "MyString",
      :email => "MyString",
      :phone => "MyString"
    ).as_new_record)
  end

  it "renders new manager form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", managers_path, "post" do
      assert_select "input#manager_first_name[name=?]", "manager[first_name]"
      assert_select "input#manager_last_name[name=?]", "manager[last_name]"
      assert_select "input#manager_email[name=?]", "manager[email]"
      assert_select "input#manager_phone[name=?]", "manager[phone]"
    end
  end
end
