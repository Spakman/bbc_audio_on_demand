require_relative "test_helper"
require_relative "../lib/asx_parser"

module BBCAudioOnDemand
  class ASXParserTest < Test::Unit::TestCase
    def test_parse_good_xml
      urls = ASXParser.parse_uris_for(File.read("#{File.dirname(__FILE__)}/data/r4.asx"))
      assert_equal 8, urls.size
    end

    def test_parse_bad_xml
      urls = ASXParser.parse_uris_for("<xml><but /<nothing /><else /></xml>")
      assert_equal 0, urls.size
    end

    def test_parse_bad_data
      urls = ASXParser.parse_uris_for("This is strange looking XML")
      assert_equal 0, urls.size
    end

    def test_fetch_and_parse_markup
      urls = ASXParser.fetch_and_parse_uris_for("http://www.bbc.co.uk/radio/listen/live/r4.asx").size
      assert_equal 8, urls.size
    end

    def test_fetching_a_404_gives_no_uris
      assert_raises(Net::HTTPServerException) { ASXParser.fetch_and_parse_uris_for("http://www.bbc.co.uk/radio/listen/live/na.asx").size }
    end
  end
end
