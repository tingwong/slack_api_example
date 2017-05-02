require 'httparty'
BASE_URL = "https://slack.com/api/"

class SlackChannel
  attr_reader :name
  class SlackException < StandardError
  end

  def initialize(name)
    @name = name
  end

  def send(message)
    #Extra Data
    query_params = {
      "token" => ENV["SLACK_API_TOKEN"],
      "channel" => @name,
      "text" => message,
      "username" => "Roberts-Robit",
      "icon_emoji" => ":robot_face:",
      "as_user" => "false"
    }

    url = "#{BASE_URL}chat.postMessage"
    response = HTTParty.post(url, query: query_params)

    if response["ok"]
      puts "Everything went swell"
    else
      raise SlackException.new(response["error"])
    end
  end

  def self.all
    url = "#{BASE_URL}channels.list?token=#{ENV["SLACK_API_TOKEN"]}"
    response = HTTParty.get(url).parsed_response

    if response["ok"]
      channel_list = response["channels"].map do |channel_data|
        SlackChannel.new(channel_data["name"])
      end

      return channel_list
    else
      puts "Oh no, there was an error: #{response["error"]}"
    end
  end
end
