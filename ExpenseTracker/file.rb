

#created at 11:55 on 04-nov-23

require 'SecureRandom'

#1. GLOBAL VARIABLES
$budget_money = 17; #tracking budget money
$expenseNav = 0; #tracking the current expense
$logs=[]; #storing expense logs in it

#2. DEFINING CLASSES


# defining the Budget class
class Budget
  def initialize(*args)
    @src = args[0]
    @money = args[1]
    t = Time.now

    t_sec = args[2];
    hrs = (t_sec+t.sec)/3600;
    t_sec = (t_sec+t.sec)%3600
    mins = t_sec/60;
    t_sec = t_sec%60;

    @time = Time.new( t.year, t.mon, t.day, t.hour+hrs, t.min+mins,t_sec);

  end

end

# $budget_instance= Budget.new('job',20,20);

puts "time: #{$budget_instance.instance_variable_get :@time}"


# bud = Budget.new('job',230,30);

# p bud.instance_variable_get :@src


# defining the Log class
class Log
  def initialize(exp,mess)
    @exp = exp
    @mess = mess
    @time = Time.now
  end
end


#3.DEFINING FUNCTIONS
#
##

#defining addExpense

def addExpense(exp,mess,budget_inst = $budget_instance)

  expected_time = budget_inst.instance_variable_get :@time
  $expenseNav = $expenseNav + exp

  if(Time.now <= expected_time)
      if($budget_money >= $expenseNav)
        log = Log.new(exp,mess);

        $logs << log;
        puts "\nadded the log**********\n"
        1
      elsif $budget_money > 0
          puts "your expense is greater than budget"
        puts "you still have some money: #{$budget_money}"
        puts "required expenses are: #{$expenseNav}"

        1
      end
    else
      puts "Your budget time is over, Here are the logs"
      b = showLogs();

      if b==1
        showMotivationLines()
      else
        showNormalLines()
      end
      0
  end
end


#defining Addbudget

def Addbudget()
  puts "Add  budget Money:"
  b_money = gets.chomp.to_i

  puts "Add a source of budget: "
  b_src = gets.chomp

  puts "time(is secs): "
  b_time = gets.chomp.to_i


   budget = Budget.new(b_src,b_money,b_time)
    $budget_money = $budget_money + b_money
   $budget_instance = budget

   puts "\nNew budget is created successfully"

   primary_func()

end


#3. defining logs

  def showLogs()
    puts "\n Showing Logs"
    puts " expense   |    messages    |   time   "

    $logs.each {|i|
    puts "\n #{i.instance_variable_get :@exp} #{i.instance_variable_get :@mess} #{i.instance_variable_get :@time}\n\n"
  }

      if($budget_money >= $expenseNav)
        1
      else
        0
      end
  end

  #defining motivations lines

  def showMotivationLines()
    arr = ["\nGood job!\n\n","\nYou are a budget Ninja!\n\n","\nGo up master!\n\n"]

    ind  = SecureRandom.random_number(0...arr.size)

    puts arr[ind]
  end

  def showNormalLines()
    arr = ["\nbudget is not that tough, get it!\n\n","\nI believe in you lets make a next goal\n\n"]

    ind  = SecureRandom.random_number(0...arr.size)

    puts arr[ind]
  end



# defining primary_func

def primary_func()
  expected_time = $budget_instance.instance_variable_get :@time

  while Time.now <= expected_time
    puts "Want to addExpense [y/n]: "

    resp = gets.chomp.downcase

    if resp==?y
      puts "Expense: "
      exp = gets.chomp.to_i

      puts "message: "
      mess = gets.chomp

      res = addExpense(exp,mess)

      if res==0
        #ask for wehther he want to add some more budget

        puts "want to add more budget? [y/n] :"
        ans = gets.chomp.downcase

        if ans==?y
          Addbudget()
        end

      else
        puts "Want to check your logs? [y/n]: "
        re = gets.chomp.downcase

        if re==?y
          b = showLogs()
        end

       if ($budget_money-$expenseNav)< 0
          puts "want to add more budget? [y/n] :"
        as = gets.chomp.downcase

        if as==?y
          Addbudget()
        else
          primary_func()
        end

        end

        if ($budget_money-$expenseNav)>0
          primary_func()
        end
      end
    else
      exit!
    end
  end


end


  #skip for now
  puts "Please add some budget: "
  Addbudget()

  # Primary function


primary_func();



#jai mata di!!!
#completed at 16:14 passing all the testccases success fully
