# ORM - Objective Relational Model 
# Active Record allows one to communicate with a sequel database without having to use sequel code. Active Record will do the translational to sequel code. 
# -Rails is a gem on Macs and Linux machines
#rails g scaffold Pokemon name element...Pokemon is the model...name and element are the attributes and by default they are both strings...REMEMBER TO USE rake db:migrate
#classes allow you to create attributes and behaviors. Behaviors being methods. 
#use object_id to get the specific id number assigned to any object. such as person1.object_id. 
#to see all the instance variables for a class..use 'instance_variables'...person.instance_variables 

#attr_reader: 
def method
  @name
end

# attr_writer: 
def method_name=(name)
  @name = name
end

# attr_accessor: is both a attr_writer and attr_reader

# 'self' keyword refers to the current object. similar to the "this" in JS

@@count = 0
def initialize    
  @@count += 1      
end               

def self.how_many
  @@count
end     

puts Person.how_many #this will return the amount of instances in the Person class

# With inheritance, the child class has access to the parent's methods. 

# Loops: for, while, until 
 for i in 0..5           
  puts i                  
end                       
                          
i = 7
until i < 0 do 
  puts i 
end
#while has 'do' and 'end'


# Logic can be placed with the brackets #{} and only be used with double quotation marks.

# Using default values     
def multiply (number1 = 5, number2 = 6)
  number1 * number2
end
#if no numbers are passed, then the default values are used 

# "yield" keywords allow a block of written code to be executed. 

def method_name
  puts "im in the method"
  yield
  puts "im back in the method"
end

method_name {puts 'printing from the yield!'} #=> "im in the method", 'printing from the method', 'im back in the method'

def yield_practice
  p "in the method"
  yield("jamal")
  p 'back in the method'
end
yield_practice{ |x| puts "my name is #{x}"} #=> 'in the method', 'my name is jamal', 'back in the method'

# module: creating a module and allowing classes to use them 
module MyEnumerable
  def example
    some code
  end

class Home
  include MyEnumerable
end

# Rspec is a gem

# in the file include: 
require_relative 'person'

Rspec.describe Person do                    #1) Write code to fail
  it 'has a getter' do                      #2) Write code to pass
    p = Person.new                          #3) then refactor the code
    p.name = Kobe
    expect(p.name).to eq("Kobe")
  end
end

# MVC Architecture

# The request will interact with the router. the router tells the request which controller to hit. the controller, based upon the url and verb, will direct it to a specific action. 

# The model talks to the database via active record. 

# migration files act like version control 

p = Person.new, p.name = "jamal" #at this point, prior to the .save command...this is an instance of the Person class...to save this in the database...p.save is needed. 

Person.create(name: "jamal", age: 37) #the .create method does new and save together. 

# to prettify the data from the database, use the gem 'hirb'. bundle and then in irb require 'hirb' then Hirb.enable

Player.find #uses the id number by default to find the instance

Player.find_by #can use any other attribute in the model for a search. 

# How to know which migrations have executed: 
   rake db:migrate.status #'up' have been executed and 'down' have not

# To rollback a migration: 
  rake db:rollback  

# validations allow user inputs to be correct prior to saving in the database. if not, then error messages regarding the data are sent 

# new validations can be seen executed on existing entries or new entries or both

# To check if data is valid prior to storing in the database use: 
  p = Person.new
  p.valid?
#   the response to this will be a boolean and will depend upon on the validations 

validates :first_name, presence: true, on: :create
#   this is validation code for new entries...pre-existing entries can be updated without this validation being envoked. 

# to create custom validations: 
  validate :first_name :first_name_starts_with_a_vowel
                        def first_name_starts_with_a_vowel
                          vowels = ['a', 'e', 'i', 'o','u']
                          if !vowels.include?(first_name[0].downcase)
                            erros.add(:first_name, "must start with a vowel")
                          end
                        end

# Association we learned: one to one: has_one and belongs_to 
#                         one to many: has_one and belong_to with the foreign key on the belongs_to
#                         many to many: has to have the 'join' / 'through' table

# in the erb files, html can be written, but Ruby needs skull tags. 
<% @player.each do |player| >
<tr>
  <td><%=player.first_name%></td>
</tr>
<end>

# instead of repeating logic in various actions within the controller, the repeated logic can be written in a private method and then called upon..much like helper methods. 
    private 
      def player_params
        params.require(:player).permit(:first_name, :last_name)
      end
    end

    def create
      player = Player.new(player_params)
      if player.save
        redirect_to '/players'
      else
        #some other message or action
      end
    end


# to see all the routes in the terminal, use: 
rake routes

# side note: REMEMBER the pluarilize method. 

# regex pattern for email: 
/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

#***************01/02/02**************************
#the difference btw the explicit and implicit return in classes. implicit returns the last line of runable code. 

def last_name
  @last_name
  'bob'
end #this will return 'bob' cause there is not a 'return' keyword..remember it is an implicit return..as opposed to:
def last_name
  return @last
end

#remember you can call the reader methods in another method, instead of the instance variable that holds the value
def example
  first_name
end #this is a method being called and not the instance variable(@first_name)

#the following attributes are reader methods: 
attr_reader :first_name, :last_name, :salary, :active

#the following attributes are writer methods: 
attr_writer :first_name, :last_name, :salary, :active
#writer method will still be executed as: 
employee.first_name=("jamal") or employee.first_name = "jamal" #these are the same

#THE ATTRIBUTES HAVE TO BE PRESENT IN THE INITALIZER METHOD. 

#metaprogramming, a method that writes the program for you. 

#for both reader & writer methods: 
attr_accessor :first_name, :last_name, :salary, :active

#************01-03 Inheritance********************

#local variable, block variables, method names, instance are snake case

#class names are upper-camelcase 

#constant variables are capitalized

#INSTANCE VARIABLES IN RUBY ARE ALWAYS PRIVATE..remember they are variables for the INSTANCE of the class. 


#the following initalize method takes only one parameter.
class Employee 
  def initalize(input_options)
    @first_name = input_options[:first_name]
    @last_name = input_options[:last_name]
    @salary = input_options[:salary]
    @active = input_options[:active] 
  end
end

employee1 = Employee.new(
                        first_name: "han", 
                        last_name: 'solo', 
                        salary: 70000, 
                        active: true
                        )

#to have a manager employee with specific attributes, create a Manager class and inherit from the Employee class:

class Manager < Employee
  def initalize(input_options)
    super #calls the Employee's initalize method and then the Manager's initalize method
    @employees = input_options[:employees]
  end

  def send_report
    puts 'sending report....'
    puts 'email sent'
  end
end 

manager1 = Manager.new(
                        first_name: "jamal", 
                        last_name: 'numan', 
                        salary: 100000, 
                        active: true,
                        employees: [employee1, employee2]
                        )



#SUPER KEYWORD:

#Super keyword prevents the child's class initalize method overwriting the parent's initalize method

#the use of the parenthesis with the super keyword is important. 

#if the parenthesis are NOT being used, then by default all the parameters will be passed to the parent class.

#with the parenthesis, the arguments have to be defined. Therefore, you are either passing in some or all or none of the arguments.  

def initalize
  super({first_name: input_options[:first_name], last_name: input_options[:last_name]})
end

def initalize
  super() #this doesn't pass up any arguments. by using parenthesis with the super keyword, you are either passing in arguments or not. 
end