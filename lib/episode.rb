# Copyright (C) 2010 Mark Somerville <mark@scottishclimbs.com>
# Released under the Lesser General Public License (LGPL) version 3.
# See COPYING

require "time"

module BBCAudioOnDemand
  class Episode
    attr_reader :pid, :title, :synopsis, :duration
    attr_reader :start, :end, :media_selector_url, :brand

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
        @media_selector_url = node.xpath("links/link[@type='mediaselector']").first.text
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
  end
end
