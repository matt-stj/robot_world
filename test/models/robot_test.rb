require_relative '../test_helper'

class RobotTest < Minitest::Test

  def test_robot_assigns_attributes_correctly
    robot = Robot.new({  :name        => "Wall-E",
                         :city       => "Mars",
                         :state       => "Space",
                         :avatar      => "Bob",
                         :birthday    => "4/5/2004",
                         :date_hired  => "10/12/2015",
                         :department  => "cleaner"
                      })

    assert_equal "Wall-E", robot.name
    assert_equal "Mars", robot.city
    assert_equal "Space", robot.state
    assert_equal "Bob", robot.avatar
    assert_equal "4/5/2004", robot.birthday
    assert_equal "10/12/2015", robot.date_hired
    assert_equal "cleaner", robot.department
  end

end
