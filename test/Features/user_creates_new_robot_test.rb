require_relative "../test_helper"

class NewRobotTest < FeatureTest

  def test_user_can_create_a_new_robot
    visit "/robots/new"
    assert_equal "/robots/new", current_path

    fill_in("robot[name]", with: "Wall-E")
    fill_in("robot[city]", with: "Mars")

    click_button('Submit')

    assert_equal "/robots", current_path

    within(".directory") do
      assert page.has_content?("Wall-E")
    end
  end

end
