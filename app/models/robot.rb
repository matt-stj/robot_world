class Robot
  attr_reader :age,
              :name,
              :city,
              :state,
              :avatar,
              :age,
              :date_hired,
              :department

  def initialize(data)
    @age         = data['age']
    @name       = data['name']
    @city       = data['city']
    @state      = data['state']
    @avatar     = data['avatar']
    @age   = data['age']
    @date_hired = data['date_hired']
    @department = data['department']
  end
end
