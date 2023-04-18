require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: 'john', email: 'john@example.com', password: 'password', admin: true)
  end

  test 'get new category form and create category' do
    sign_in_as(@user, 'password')
    get new_category_path
    assert_response :success
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: 'sports' } }
      assert_response :redirect
      follow_redirect!
      assert_response :success
    end
    assert_template 'categories/index'
    assert_match 'sports', response.body
  end

  test 'invalid category submission results in failure' do
    sign_in_as(@user, 'password')
    get new_category_path
    assert_response :success
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: ' ' } }
    end
    assert_response :unprocessable_entity
    assert_template 'categories/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
