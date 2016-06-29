require 'spec_helper'

describe "managers/edit" do
  before(:each) do
    @manager = assign(:manager, stub_model(Manager,
      :first_name => "MyString",
      :last_name => "MyString",
      :email => "MyString",
      :phone => "MyString"
    ))
  end

  it "renders the edit manager form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", manager_path(@manager), "post" do
      assert_select "input#manager_first_name[name=?]", "manager[first_name]"
      assert_select "input#manager_last_name[name=?]", "manager[last_name]"
      assert_select "input#manager_email[name=?]", "manager[email]"
      assert_select "input#manager_phone[name=?]", "manager[phone]"
    end
  end
end
