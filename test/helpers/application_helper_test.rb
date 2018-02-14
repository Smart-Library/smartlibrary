require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  setup do
    @grouping = groupings(:grouping2)
  end

  test "#breadcrumb returns nav element with class breadcrumb" do
    assert_match /^<nav class="breadcrumb".*<\/nav>$/, breadcrumb(@grouping)
  end

  test "#breadcrumb displays leaf in span" do
    assert_match /<span[^<>]*>#{@grouping.name}<\/span>/, breadcrumb(@grouping)
  end

  test "#breadcrumb displays parent in <a>" do
    assert_match /<a[^<>]*>#{@grouping.parent_grouping.name}<\/a>/, breadcrumb(@grouping)
  end
end
