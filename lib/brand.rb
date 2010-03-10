require "nokogiri"
require_relative "episode"

module BBCAudioOnDemand
  class Brand
    attr_reader :pid, :station, :name

    def initialize(pid, station, name = nil)
      @pid = pid
      @station = station
      if name.nil?
        @name = get_name_from_xml(@station.xml_document)
      else
        @name = name
      end
    end

    def get_name_from_xml(xml_document)
      xml_document.xpath("//entry/parents/parent[@pid='#{@pid}']").first.content
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

    alias_method :==, :eql?

    def all_episodes
      episodes = []
      @station.xml_document.xpath("//entry/parents/parent[@pid='#{@pid}']").each do |brand_node|
        episode = Episode.new(brand_node.parent.parent.css("pid").text, self)
        episodes << episode
      end
      episodes.uniq
    end

    def available_episodes
      all_episodes.delete_if { |episode| !episode.available? }
    end

    def has_available_episodes?
      available_episodes.size > 0
    end

    def to_s
      name
    end
  end
end
