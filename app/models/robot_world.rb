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
      database['robots'] << { "id"          => database['total'],
                              "name"        => robot['name'],
                              "city"        => robot['city'],
                              "state"       => robot['state'],
                              "avatar"      => robot['avatar'],
                              "birthday"    => robot['birthday'],
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

  def self.raw_robot(id)
    raw_robots.find { |robot| robot["id"] == id }
  end

  def self.find(id)
    Robot.new(raw_robot(id))
  end

  def self.update(id, data)
    database.transaction do
      target = database['robots'].find {|robot| robot["id"] == id}
      target['name'] = data[:name]
      target['city'] = data[:city]
      target['state'] = data[:state]
      target['avatar'] = data[:avatar]
      target['birthday'] = data[:birthday]
      target['date_hired'] = data[:date_hired]
      target['department'] = data[:department]
    end
  end

  def self.delete(id)
    database.transaction do
      target = database['robots'].delete_if { |robot| robot["id"] == id }
    end
  end

  def self.average_age
    current_year = Time.now.year
    robots = raw_robots.map { |data| Robot.new(data) }
    array_of_birth_years = robots.map {|robot| robot.birthday.split("/").last.to_i}
    array_of_ages = array_of_birth_years.map! {|year| current_year - year}
    average = (array_of_ages.inject(0, :+))/(array_of_ages.size)
  end

  def self.hired_by_year
    robots = raw_robots.map { |data| Robot.new(data) }
    hired_years = robots.map {|robot| robot.date_hired.split("/").last.to_i}
    keys = hired_years.uniq
    hash = {}
    keys.map {|key| hash[key] = hired_years.count(key)}
    hash
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
