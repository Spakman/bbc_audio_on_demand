# Copyright (C) 2010 Mark Somerville <mark@scottishclimbs.com>
# Released under the Lesser General Public License (LGPL) version 3.
# See COPYING

require "net/http"
require "nokogiri"
require_relative "uris"
require_relative "brand"

module BBCAudioOnDemand
  class Station
    attr_reader :name, :xml_document

    include BBCAudioOnDemand::LiveStreaming
    include BBCAudioOnDemand::ScheduleFeeds

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

    def all_brands
      fetch_and_parse_feed_if_required

      brand_nodes = @xml_document.xpath("//parents/parent[@type='Brand']")
      brands = brand_nodes.map do |node|
        Brand.new node.attr("pid"), self, node.content
      end

      brands.uniq
    end

    def available_brands
      all_brands.delete_if { |brand| !brand.has_available_episodes? }
    end

    def fetch_and_parse_feed_if_required
      if @xml_document.nil?
        uri = URI.parse(schedule_feed_uri)
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.request_uri)
        response = http.request(request)

        if response.code == "200"
          @xml_document = Nokogiri::XML.parse response.body
        else
          raise Net::HTTPServerException.new("A 200 response was not received from #{schedule_feed_uri}", nil)
        end
      end
    end

    def to_s
      @name
    end
  end
end
