
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

        if re==1
          b = showLogs()
        end
      end

    end
  end


end
