json.array!(@profiles) do |profile|
  json.extract! profile, :id, :references, :first_name, :last_name, :website_url, :location, :description, :facebook_id, :linkedin_id, :google_plus_id
  json.url profile_url(profile, format: :json)
end
