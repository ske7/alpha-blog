require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: 'sporst')
    @category2 = Category.create(name: 'progremming')
  end

  test 'should show categories index' do
    get categories_path
    assert_template 'categories/index'
    assert_select 'a[href=?]', category_path(@category), text: @category.name
    assert_select 'a[href=?]', category_path(@category2), text: @category2.name
  end
end
