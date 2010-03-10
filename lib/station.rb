require "net/http"
require "nokogiri"
require_relative "urls"
require_relative "brand"

module BBCAudioOnDemand
  class Station
    attr_reader :name, :xml_document

    include LiveStreaming

    def initialize(name, feed = nil)
      if name =~ /^BBC /
        @name = name
      else
        @name = "BBC #{name}"
      end

      if feed.respond_to? :xpath
        @xml_document = feed
      elsif feed.respond_to? :length
        @xml_document = Nokogiri::XML.parse feed
      end
    end

    def streaming_playlist_url
      "http://www.bbc.co.uk/radio/listen/live/#{LiveStreaming::URLS[@name]}"
    end

    def schedule_feed_url
      "http://www.bbc.co.uk/radio/aod/availability/#{ScheduleFeeds::URLS[@name]}"
    end

    def all_brands
      fetch_and_parse_feed_if_required

      brand_nodes = @xml_document.xpath("//parents/parent[@type='Brand']")
      brands = brand_nodes.map do |node|
        Brand.new node.attr("pid"), self, node.content
      end

      brands.uniq
    end

    def fetch_and_parse_feed_if_required
      if @xml_document.nil?
        content = Net::HTTP.get(URI.parse(schedule_feed_url))
        @xml_document = Nokogiri::XML.parse content
      end
    end
  end
end
