require 'test_helper'

class GroupingFormBuilderTest < ActionView::TestCase
  setup do
    @grouping = groupings(:grouping1)

    @template = Object.new
    @template.extend ActionView::Helpers::FormHelper
    @template.extend ActionView::Helpers::FormOptionsHelper
    @form_builder = GroupingFormBuilder.new(:grouping, @grouping, @template, {})
  end

  test "#grouping_select has empty option" do
    assert_match /<option value=""><\/option>/, @form_builder.grouping_select(:parent_grouping_id)
  end

  test "#grouping_select produces select" do
    assert_match /^<select name="grouping\[parent_grouping_id\]"/,
                 @form_builder.grouping_select(:parent_grouping_id)
  end

  test "#grouping_select has grouping value and text" do
    assert_match /<option value="#{@grouping.id}">#{@grouping.name}<\/option>/,
                 @form_builder.grouping_select(:parent_grouping_id)
  end
end
