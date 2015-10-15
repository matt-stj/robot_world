require_relative "../test_helper"

class DeleteRobotTest < FeatureTest

  def test_user_can_delete_a_robot
    RobotWorld.create({ "name" => "Wall-E",
                 "city"        => "Mars",
                 "state"       => "Space",
                 "avatar"      => "Bob",
                 "birthday"    => "4/5/2004",
                 "date_hired"  => "10/12/15",
                 "department"  => "cleaner"
              })

    visit "/robots"
    assert_equal "/robots", current_path

    within(".directory") do
      assert page.has_content?("Wall-E")
    end

    click_button('Delete')

    assert_equal "/tasks", current_path

    within(".panel-body") do
      refute page.has_content?("The task title.")
    end
  end

end
