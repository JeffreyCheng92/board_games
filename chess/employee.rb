class Employee
  attr_reader :salary
  def initialize(name, title, salary, boss = nil)
    @name = name
    @title  = title
    @salary = salary
    @boss = boss

  end

  def bonus(multiplier)
    bonus = salary * multiplier
  end


end


class Manager < Employee
  def initialize(name,title,salary,boss= nil)

    super(name,title,salary,boss)
    @all_employees = []

  end

  def bonus(multiplier)
    bonus = @all_employees.inject(0){|total, employee| total + employee.salary} * multiplier
  end

  def add_employee(employee)
    @all_employees << employee
  end

end

ned = Manager.new("Ned","Founder",1_000_000)

darren = Manager.new("Darren","TA Manager",78_000,ned)
shawna = Employee.new("shawna","TA",12_000,darren)
david = Employee.new("David","TA",10_000,darren)
ned.add_employee(darren)
ned.add_employee(shawna)
ned.add_employee(david)
darren.add_employee(shawna)
darren.add_employee(david)

p ned.bonus(5)
