class Employee
  attr_reader :salary

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    if self.class == Manager
      sum = 0
      @subordinates.each { |employee| sum += employee.salary }
      bonus = sum * multiplier
    else
      bonus = @salary * multiplier
    end
    bonus
  end
end

class Manager < Employee
  def initialize(name, title, salary, boss, subs)
    @subordinates = subs
    super(name, title, salary, boss)
  end
end
