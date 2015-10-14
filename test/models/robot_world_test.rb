require_relative '../test_helper'

class RobotWorldTest < Minitest::Test

  def create_tasks(num)
    num.times do |i|
      Robot.new({ "name"         => "Wall-E#{i}",
                   "city"        => "Mars#{i}",
                   "state"       => "Space#{i}",
                   "avatar"      => "Bob#{i}",
                   "birthday"    => "4/5/2004#{i}",
                   "date_hired"  => "10/12/15#{i}",
                   "department"  => "cleaner#{i}"
                })
    end
  end

end
