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

end
