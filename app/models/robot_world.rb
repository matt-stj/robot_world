require 'yaml/store'

class RobotWorld

  def self.database
    if ENV["RACK_ENV"] == "test"
      @database ||= Sequel.sqlite("db/robot_world_test.sqlite3")
    else
      @database ||= Sequel.sqlite("db/robot_world_development.sqlite3")
    end
  end

  def self.dataset
    database.from(:robots)
  end

  def self.create(robot)
    dataset.insert(robot)
  end

  def self.raw_robots
    database.transaction do
      database['robots'] || []
    end
  end

  def self.all
    robots = dataset.to_a
    robots.map {|robot| Robot.new(robot)}
  end

  def self.find(id)
    robot = dataset.where(:id => id).to_a.first
    Robot.new(robot)
  end

  def self.update(id, data)
    robot = dataset.where(:id => id)
    robot.update(data)
  end

  def self.delete(id)
    dataset.where(:id => id).delete
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
    dataset.delete
  end

end
