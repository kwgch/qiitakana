require 'rails_helper'

RSpec.describe "profiles/show", :type => :view do
  before(:each) do
    @profile = assign(:profile, Profile.create!(
      :references => "",
      :first_name => "First Name",
      :last_name => "Last Name",
      :website_url => "Website Url",
      :location => "Location",
      :description => "MyText",
      :facebook_id => "Facebook",
      :linkedin_id => "Linkedin",
      :google_plus_id => "Google Plus"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Website Url/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Facebook/)
    expect(rendered).to match(/Linkedin/)
    expect(rendered).to match(/Google Plus/)
  end
end
