require "test/unit"
require_relative "../lib/brand"
require_relative "../lib/station"

module BBCAudioOnDemand
  class BrandTest < Test::Unit::TestCase
    def setup
      feed = File.read("#{File.dirname(__FILE__)}/data/r4.xml")
      @radio4 = Station.new("Radio 4", feed)
      @shipping_forecast = Brand.new("b006qfvv", @radio4, "Shipping Forecast")
      @good_read = Brand.new("b006v8jn", @radio4)
    end

    def test_eql
      assert @shipping_forecast.eql? Brand.new("b006qfvv", @radio4, "Different name")
    end

    def test_hash
      assert_equal 123.hash, Brand.new(123, @radio4, "Not a real brand").hash
    end

    def test_get_name_from_xml
      assert_equal @shipping_forecast.name, @shipping_forecast.get_name_from_xml(@radio4.xml_document)
    end

    def test_all_episodes
      assert_equal 2, @shipping_forecast.all_episodes.size
      assert_equal 1, @good_read.all_episodes.size
    end

    def test_available_episodes
      assert_equal 2, @shipping_forecast.available_episodes.size
      assert_empty @good_read.available_episodes
    end

    def test_has_available_episodes
      assert @shipping_forecast.has_available_episodes?
      refute @good_read.has_available_episodes?
    end

    def test_to_s
      assert_equal @shipping_forecast.name, @shipping_forecast.to_s
    end

    def test_sort
      brands = [ Brand.new(nil, nil, "B"), Brand.new(nil, nil, "C"), Brand.new(nil, nil, "A") ].sort
      assert_equal %w{ A B C }, brands.map(&:name)
    end
  end
end
