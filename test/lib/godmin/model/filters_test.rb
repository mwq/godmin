require "test_helper"

module Godmin
  module Model
    class FiltersTest < ActiveSupport::TestCase
      def setup
        @article_thing = ArticleThing.new
      end

      def test_calls_one_filter
        @article_thing.apply_filters({ title: "foobar" }, :resources)
        assert_equal [:resources, "foobar"], @article_thing.called_methods[:filters][:title]
      end

      def test_calls_multiple_filters
        @article_thing.apply_filters({ title: "foobar", country: "Sweden" }, :resources)
        assert_equal [:resources, "foobar"], @article_thing.called_methods[:filters][:title]
        assert_equal [:resources, "Sweden"], @article_thing.called_methods[:filters][:country]
      end

      def test_filter_map_with_default_options
        expected_filter_map = { as: :string, option_text: "to_s", option_value: "id", collection: nil }
        assert_equal expected_filter_map, @article_thing.filter_map[:title]
      end

      def test_filter_map_with_custom_options
        expected_filter_map = { as: :select, option_text: "to_s", option_value: "id", collection: %w(Sweden Canada) }
        assert_equal expected_filter_map, @article_thing.filter_map[:country]
      end
    end
  end
end