require_relative "../test_helper"

class UpdateRobotTest < FeatureTest

  def test_user_can_create_a_new_robot
    skip
    RobotWorld.create({ "name" => "Wall-E",
                 "city"        => "Mars",
                 "state"       => "Space",
                 "avatar"      => "Bob",
                 "birthday"    => "4/5/2004",
                 "date_hired"  => "10/12/15",
                 "department"  => "cleaner"
              })

    visit "/robots/edit"
    assert_equal "/robots/edit", current_path

    fill_in("robot[name]", with:       "Wall-E (updated)")
    fill_in("robot[state]", with:      "Space (updated)")
    fill_in("robot[avatar]", with:     "Bob (updated)")
    fill_in("robot[brithday]", with:   "4/5/2004 (updated)")
    fill_in("robot[date_hired]", with: "10/12/15 (updated)")
    fill_in("robot[department]", with: "cleaner (updated)")
    click_button('Submit')

    assert_equal "/robots", current_path

    within(".directory") do
      skip
      assert page.has_content?("Wall-E (updated)")
      assert page.has_content?("Space (updated)")
      assert page.has_content?("Bob (updated)")
      assert page.has_content?("4/5/2004 (updated)")
      assert page.has_content?("10/12/15 (updated)")
      assert page.has_content?("cleaner (updated)")
    end
  end

end
