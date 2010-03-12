# Copyright (C) 2010 Mark Somerville <mark@scottishclimbs.com>
# Released under the Lesser General Public License (LGPL) version 3.
# See COPYING

require "net/http"
require "time"

module BBCAudioOnDemand
  class Episode
    attr_reader :pid, :title, :synopsis, :duration
    attr_reader :start, :end, :media_selector_uri, :brand

    def initialize(pid, brand = nil, node = nil)
      @pid = pid

      if node
        parse_for_attributes(node)
      elsif brand
        @brand = brand
        parse_for_attributes get_entry_node(brand.station.xml_document)
      end
    end

    def get_entry_node(xml_document)
      xml_document.xpath("//schedule/entry/pid[.='#{pid}']").first.parent
    end

    def parse_for_attributes(node)
      if node.xpath("pid").text == @pid
        brand_node = node.xpath("parents/parent[@type='Brand']")
        @brand = Brand.new(brand_node.attr("pid").content, nil, brand_node.text)

        @title = node.xpath("title").text
        @start = Time.parse(node.xpath("availability").attr("start").content)
        @end = Time.parse(node.xpath("availability").attr("end").content)
        @synopsis = node.xpath("synopsis").text
        @duration = node.xpath("broadcast").attr("duration").content.to_i
        @media_selector_uri = node.xpath("links/link[@type='mediaselector']").first.text
      end
    end

    def hash
      @pid.hash
    end

    def eql?(object)
      if object.class == self.class and @pid == object.pid
        true
      else
        false
      end
    end

    def available?
      now = Time.now
      @start < now and @end > now
    end

    def to_s
      title
    end

    # Retrieves and returns the URI of the ASX playlist for clients
    # inside the UK.
    #
    # TODO: refactor the HTTP stuff into a single place.
    def uk_playlist_uri
      uri = URI.parse(@media_selector_uri)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)

      if response.code == "200"
        playlist_xml_document = Nokogiri::XML.parse response.body
        return playlist_xml_document.css("media[service='iplayer_intl_stream_wma_uk_concrete'] connection").first["href"]
      else
        raise Net::HTTPServerException.new("A 200 response was not received from #{@media_selector_uri}", nil)
      end
    end

    # Retrieves and returns the URI of the ASX playlist for clients
    # outside the UK.
    #
    # TODO: refactor the HTTP stuff into a single place.
    def international_playlist_uri
      uri = URI.parse(@media_selector_uri)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)

      if response.code == "200"
        playlist_xml_document = Nokogiri::XML.parse response.body
        return playlist_xml_document.css("media[service='iplayer_intl_stream_wma_lo_concrete'] connection").first["href"]
      else
        raise Net::HTTPServerException.new("A 200 response was not received from #{@media_selector_uri}", nil)
      end
    end
  end
end
