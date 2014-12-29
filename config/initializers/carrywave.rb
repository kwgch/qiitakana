CarrierWave.configure do |config|
  config.fog_credentials = {
      provider:               'AWS',
      aws_access_key_id:      ENV["aws_access_key_id"],
      aws_secret_access_key:  ENV["aws_secret_access_key"],
      region:                 'ap-northeast-1',
      path_style:             true,
  }

  config.fog_public     = true
  config.fog_attributes = {'Cache-Control' => 'public, max-age=86400'}

  case Rails.env
  when 'production'
    config.fog_directory = 'kwgch-upload'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/kwgch-upload'
  when 'development'
    config.fog_directory = 'kwgch-upload-dev'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/kwgch-upload-dev'
  end
end