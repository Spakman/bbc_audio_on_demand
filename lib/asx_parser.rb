# Copyright (C) 2010 Mark Somerville <mark@scottishclimbs.com>
# Released under the General Public License (GPL) version 3.
# See COPYING

require "nokogiri"
require "net/http"

module BBCAudioOnDemand
  # A simple ASX playlist parser.
  class ASXParser
    def self.fetch_and_parse_uris_for(asx_uri)
      uri = URI.parse(asx_uri)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)

      if response.code == "200"
        ASXParser.parse_uris_for response.body
      else
        raise Net::HTTPServerException.new("A 200 response was not received from #{asx_uri}", nil)
      end
    end

    def self.parse_uris_for(markup)
      asx_xml = Nokogiri::XML.parse markup
      uris = asx_xml.xpath("//Entry/ref").map { |ref| ref["href"] }
      uris.uniq
    end
  end
end
