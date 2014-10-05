require 'rails_helper'

RSpec.describe "profiles/index", :type => :view do
  before(:each) do
    assign(:profiles, [
      Profile.create!(
        :references => "",
        :first_name => "First Name",
        :last_name => "Last Name",
        :website_url => "Website Url",
        :location => "Location",
        :description => "MyText",
        :facebook_id => "Facebook",
        :linkedin_id => "Linkedin",
        :google_plus_id => "Google Plus"
      ),
      Profile.create!(
        :references => "",
        :first_name => "First Name",
        :last_name => "Last Name",
        :website_url => "Website Url",
        :location => "Location",
        :description => "MyText",
        :facebook_id => "Facebook",
        :linkedin_id => "Linkedin",
        :google_plus_id => "Google Plus"
      )
    ])
  end

  it "renders a list of profiles" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Website Url".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Facebook".to_s, :count => 2
    assert_select "tr>td", :text => "Linkedin".to_s, :count => 2
    assert_select "tr>td", :text => "Google Plus".to_s, :count => 2
  end
end
