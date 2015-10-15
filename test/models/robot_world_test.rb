require_relative '../test_helper'

class RobotWorldTest < Minitest::Test

  def create_robots(num)
    num.times do |i|
      RobotWorld.create({ "name" => "Wall-E - version: #{i}",
                   "city"        => "Mars - version: #{i}",
                   "state"       => "Space - version: #{i}",
                   "avatar"      => "Bob - version: #{i}",
                   "birthday"    => "4/5/2004 - version: #{i}",
                   "date_hired"  => "10/12/15 - version: #{i}",
                   "department"  => "cleaner - version: #{i}"
                })
    end
  end

  def test_our_robot_create_method_works_correctly
    create_robots(5)
    assert_equal 5, RobotWorld.all.size
  end

  def test_we_can_create_a_robot
    create_robots(1)
    robot = RobotWorld.all.first

    assert_equal "Wall-E - version: 0", robot.name
    assert_equal "Bob - version: 0", robot.avatar
    assert_equal "4/5/2004 - version: 0", robot.birthday
    assert_equal "Mars - version: 0", robot.city
    assert_equal "10/12/15 - version: 0", robot.date_hired
    assert_equal "cleaner - version: 0", robot.department
    assert_equal 1, robot.id
    assert_equal "Space - version: 0", robot.state
  end

  def test_we_can_show_all_robots
    create_robots(5)
    robots = RobotWorld.all

    assert_equal 5, robots.size
  end

  def test_we_can_find_a_robot_by_its_id
    create_robots(3)

    robot = RobotWorld.find(2)
    assert_equal "Wall-E - version: 1", robot.name
  end

  def test_we_can_update_an_existing_robot
    create_robots(1)

    robot = RobotWorld.find(1)
    assert_equal "Wall-E - version: 0", robot.name

    RobotWorld.update(1, {:name => "Wall-E (updated)"})
    updated_robot = RobotWorld.find(1)
    assert_equal "Wall-E (updated)", updated_robot.name
  end

  def test_we_can_delete_a_robot
    create_robots(5)

    assert_equal 5, RobotWorld.all.size
    RobotWorld.delete(5)
    assert_equal 4, RobotWorld.all.size
    RobotWorld.delete(2)
    assert_equal 3, RobotWorld.all.size
  end

end
