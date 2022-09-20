require "employee"
require "byebug"
class Startup
    def initialize(name, funding, salaries)
        @name = name
        @funding = funding 
        @salaries = salaries 
        @employees = []
    end

    def name 
        @name 
    end 

    def funding 
        @funding
    end 

    def salaries
        @salaries
    end 
    
    def employees 
        @employees
    end 

    def valid_title?(title)
        return true if @salaries.keys.include?(title)
        false 
    end

    def >(other_startup)
        return true if self.funding > other_startup.funding
        false
    end 

    def hire(name, title)
        if salaries.keys.include?(title)
           @employees <<  Employee.new(name, title)
        else
            raise Error
        end
    end

    def size 
        @employees.length
    end 

    def pay_employee(employee)
        salary =  @salaries[employee.title] 
        if @funding - salary >= 0 
            employee.pay(salary)
            @funding -= salary
        else 
            raise Error
        end 
    end

    def payday
        @employees.each {|employee| pay_employee(employee)}
    end

    def average_salary
        titles = @employees.map {|employee| employee.title}
        pays = titles.map {|title| @salaries[title]}
        pays.sum / @employees.length
    end

    def close 
        @employees = []
        @funding = 0 
    end 

    def acquire(other_startup)
        @funding += other_startup.funding
        other_startup.salaries.each do |title, salary|
            @salaries[title] = salary if !@salaries.keys.include?(title) 
        end
        @employees += other_startup.employees
        other_startup.close
    end
end
