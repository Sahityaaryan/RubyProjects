

#actual code structure
$code=[]
$function_instance=[]

#remember of applying the function funcitonality to the functions only


#class

class Var
  def initialize(text)
    @grp="var"
    @text = text
  end
end


class Funct
  def initialize(name,paramStr,f_exp)

  @grp = "function"
  @params = paramStr
  @name = name
  @f_exp = f_exp
  end
end


class Exp
  def initialize(text)
    @grp = "expression"
    @text = text
  end
end



#functions

def takeExpressions(f_exp)
    puts "Want to add the Expression [y/n]"

    ch = gets.chomp.downcase

    if ch==?y
      puts "Expression"
      text = gets.chomp
      exp = Exp.new(text)
      f_exp << exp
      takeExpressions(f_exp)
      else
        f_exp
    end

end
def takeParams(paramStr)

  puts "want to enter the params [y/n]:"

  ch = gets.chomp.downcase

  if ch==?y
    puts "Enter paran:"
    param = gets.chomp
    paramStr << " " +param << ",";
    takeParams(paramStr)

  else
    paramStr.chop!
    return paramStr
  end
end



def prime_func()

  puts "want to add varaible/function/expression [1,2,3] or not [n]"

  ch = gets.chomp.downcase

  if ch=="1"
    addVar()

  elsif ch=="2"
    addFunc()
  elsif ch== "3"
    puts "Enter The scope:[g/function]"
    choose = gets.chomp
    puts "Enter the text"
      text = gets.chomp
      exp = Exp.new(text)
    if choose == "g"
        $code << exp
    else
      $function_instance.each{|i|
      name = i.instance_variable_get :@name

      if choose==name
        f_exp = i.instance_variable_get :@f_exp
        f_exp << exp
      end
    }

    end
    prime_func()
  end

  puts "Creating your js file:"
    file = File.new("test.js","w");

    $code.each{ |i|

    grp = i.instance_variable_get :@grp

    if grp == "function"
      showFunc(file,i)
    else
       file.puts(i.instance_variable_get :@text)
    end
  }

end


def addVar()
  puts "Enter variable expression"
  text = gets.chomp
  var = Var.new(text)
  $code << var

  prime_func()
end

def addFunc()

  puts "Enter name:"
  name = gets.chomp

  paramStr = takeParams("")

  f_exp = takeExpressions([])


  puts "Whose child it this[g/other]"

  ch = gets.chomp

  if ch=="g" || ch =="G"
    f = Funct.new(name,paramStr,f_exp)
    $function_instance << f
    $code << f

  else
    $function_instance.each{|i|
    parent = i.instance_variable_get :@name

    if parent == ch
      f_e = i.instance_variable_get :@f_exp
      f = Funct.new(name,paramStr,f_exp)
      f_e << f


    end
  }
  end

  prime_func()

end


def showFunc(file,i)
  file.puts("function #{i.instance_variable_get :@name} ( #{i.instance_variable_get :@params} ) {")

  (i.instance_variable_get :@f_exp).each{|ele|
    grp = ele.instance_variable_get :@grp

    if grp == "function"
      showFunc(file,ele)

    else
      file.puts(ele.instance_variable_get :@text)
    end
}

file.puts("}")
end


prime_func();
