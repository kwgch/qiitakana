require 'rails_helper'

RSpec.describe "profiles/new", :type => :view do
  before(:each) do
    assign(:profile, Profile.new(
      :references => "",
      :first_name => "MyString",
      :last_name => "MyString",
      :website_url => "MyString",
      :location => "MyString",
      :description => "MyText",
      :facebook_id => "MyString",
      :linkedin_id => "MyString",
      :google_plus_id => "MyString"
    ))
  end

  it "renders new profile form" do
    render

    assert_select "form[action=?][method=?]", profiles_path, "post" do

      assert_select "input#profile_references[name=?]", "profile[references]"

      assert_select "input#profile_first_name[name=?]", "profile[first_name]"

      assert_select "input#profile_last_name[name=?]", "profile[last_name]"

      assert_select "input#profile_website_url[name=?]", "profile[website_url]"

      assert_select "input#profile_location[name=?]", "profile[location]"

      assert_select "textarea#profile_description[name=?]", "profile[description]"

      assert_select "input#profile_facebook_id[name=?]", "profile[facebook_id]"

      assert_select "input#profile_linkedin_id[name=?]", "profile[linkedin_id]"

      assert_select "input#profile_google_plus_id[name=?]", "profile[google_plus_id]"
    end
  end
end
