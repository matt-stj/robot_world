require_relative "../test_helper"

class NewRobotTest < FeatureTest

  def test_user_can_create_a_new_robot
    visit "/robots/new"
    assert_equal "/robots/new", current_path

    fill_in("robot[name]", with:       "Wall-E")
    fill_in("robot[state]", with:      "Space")
    fill_in("robot[avatar]", with:     "Bob")
    fill_in("robot[birthday]", with:   "4/5/2004")
    fill_in("robot[date_hired]", with: "10/12/15")
    fill_in("robot[department]", with: "cleaner")

    click_button('Submit')

    assert_equal "/robots", current_path

    within(".directory") do
      assert page.has_content?("Wall-E")
    end

    visit "robots/#{RobotWorld.all.first.id}"
    assert_equal "/robots/#{RobotWorld.all.first.id}", current_path

    within(".table") do
      assert page.has_content?("Space")
      assert page.has_content?("4/5/2004")
      assert page.has_content?("10/12/15")
      assert page.has_content?("cleaner")
    end

  end

end
