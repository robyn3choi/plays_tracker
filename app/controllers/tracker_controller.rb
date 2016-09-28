class TrackerController < ApplicationController

  # Set DEVELOPER_KEY to the API key value from the APIs & auth > Credentials
  # tab of
  # Google Developers Console <https://console.developers.google.com/>
  # Please ensure that you have enabled the YouTube Data API for your project.
  YOUTUBE_DEVELOPER_KEY = ENV['YOUTUBE_DEVELOPER_KEY']
  YOUTUBE_API_SERVICE_NAME = 'youtube'
  YOUTUBE_API_VERSION = 'v3'

  def dashboard
    client, youtube = get_youtube_service
    result = client.execute :api_method => youtube.videos.list, :parameters => {:id => 'csInNn6pfT4', :part => 'statistics'}
    result = JSON.parse(result.data.to_json)
    render html: result['items'][0]['statistics']['viewCount']
  end

  private

    def get_youtube_service
      client = Google::APIClient.new(
        :key => YOUTUBE_DEVELOPER_KEY,
        :authorization => nil,
        :application_version => '1.0.0'
      )
      youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)
      client.authorization = nil
      return client, youtube
    end

end
