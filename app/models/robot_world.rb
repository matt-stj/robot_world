require 'yaml/store'

class RobotWorld

  def self.database
    @database ||= YAML::Store.new("db/robot_world")
  end

  def self.create(robot)
    database.transaction do
      database['robots'] ||= []
      database['total'] ||= 0
      database['total'] += 1
      database['robots'] << { "age"          => database['total'],
                              "name"        => robot['name'],
                              "city"        => robot['city'],
                              "state"       => robot['state'],
                              "avatar"      => robot['avatar'],
                              "age"    => robot['age'],
                              "date_hired"  => robot['date_hired'],
                              "department"  => robot['department']
                            }
    end
  end

  def self.raw_robots
    database.transaction do
      database['robots'] || []
    end
  end

  def self.all
    raw_robots.map { |data| Robot.new(data) }
  end

  def self.raw_robot(age)
    raw_robots.find { |robot| robot["age"] == age }
  end

  def self.find(age)
    Robot.new(raw_robot(age))
  end

  def self.update(age, data)
    database.transaction do
      target = database['robots'].find {|robot| robot["age"] == age}
      target['name'] = data[:name]
      target['city'] = data[:city]
      target['state'] = data[:state]
      target['avatar'] = data[:avatar]
      target['age'] = data[:age]
      target['date_hired'] = data[:date_hired]
      target['department'] = data[:department]
    end
  end

  def self.delete(age)
    database.transaction do
      target = database['robots'].delete_if { |robot| robot["age"] == age }
    end
  end

  def self.delete_all
    database.transaction do
      database['robots'] = []
      database['total'] = 0
    end
  end

  def self.database
    if ENV["RACK_ENV"] == 'test'
      @database ||= YAML::Store.new("db/robot_world_test")
    else
      @database ||= YAML::Store.new("db/robot_world")
    end
  end

end
