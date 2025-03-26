require 'open-uri'
require 'json'
require 'net/http'
require 'uri'

module ArticlesHelper
  def video_thumbnail_url(video_url)
    return unless video_url.present?

    # For YouTube
    if video_url.include?("youtube.com") || video_url.include?("youtu.be")
      video_id = video_url.split("v=").last.split("&").first
      return "https://img.youtube.com/vi/#{video_id}/hqdefault.jpg"

    # For Facebook
    elsif video_url.include?("facebook.com")
      video_id = video_url.split("videos/").last
      return "https://graph.facebook.com/#{video_id}/picture"

    # For TikTok
    elsif video_url.include?("tiktok.com") || video_url.include?("vm.tiktok.com")
      full_video_url = resolve_tiktok_url(video_url)
      
      # Now use the full TikTok URL for the oEmbed API request
      tiktok_api_url = "https://www.tiktok.com/oembed?url=#{full_video_url}"

      begin
        # Fetch and parse the TikTok oEmbed response
        json_response = open(tiktok_api_url).read
        parsed_data = JSON.parse(json_response)
        
        # Return the thumbnail URL
        return parsed_data["thumbnail_url"] if parsed_data["thumbnail_url"].present?
      rescue StandardError => e
        # Return a default thumbnail if the TikTok API fails
        Rails.logger.error("Error fetching TikTok thumbnail: #{e.message}")
        return "https://via.placeholder.com/150"
      end
    else
      # Return a default thumbnail if it's not supported
      return "https://via.placeholder.com/150"
    end
  end

  private

  # Resolves a shortened TikTok URL to the full URL
  def resolve_tiktok_url(shortened_url)
    uri = URI.parse(shortened_url)
    response = Net::HTTP.get_response(uri)
    full_url = response['location'] # Get the final URL after redirection
    return full_url
  end
end