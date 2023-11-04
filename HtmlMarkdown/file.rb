#created at 18:31 on  04-11-23

$dom=[]

#classes

class NormalTag
  def initialize(tag,text)
   if tag=="h1"
    @tag = "<h1>"
    @text = text
    @closetag = "</h1>"

   elsif tag=="h2"
    @tag = "<h2>"
    @text = text
    @closetag = "</h2>"
   else
    @tag = "<p>"
    @text = text
    @closetag = "</p>"
   end
  end
end

#ul class

class Ul
  def initialize(li_arr)
    @tag = "<ul>"
    @li = li_arr
    @closetag = "</ul>"
  end
end


class Div
  def initialize(divyarray)
    @tag = "<div>"
    @divyarray = divyarray
    @closetag = "</div>"
  end
end



#functions


#adding to the list
def AddList(list)
  puts "Enter list [y/n]: "
  resp = gets.chomp

  if resp==?y
    puts "Enter text:"
    text = gets.chomp
    list << text
    AddList(list)
  end

  return list
end

#adding to the div

def addDiv(divyarray)


  while 1
    puts "want to add [h1/h2/p/ul] or not [n]: "
    ch = gets.chomp.downcase

    if ch != ?n
      if ch=="ul"
        list=[]
        list=AddList(list)
        ele = Ul.new(list)
        puts "i am ele of addDiv(ul): #{ele}"
        divyarray << ele
        # $dom << Div.new(divyarray)
      else
        puts "Enter the text: "
        text = gets.chomp
        ele = NormalTag.new(ch,text)
        divyarray << ele
        # $dom << ele
      end
      return divyarray
    end
  end
end


def h_li(list)
  puts "<ul>"
  list.each{|i|
    puts "<li> #{i} </li>"
  }
  puts "</ul>"
end


def f_li(list, out_file)
  out_file.puts("<ul>")
  list.each { |i| out_file.puts("<li> #{i} </li>") }
  out_file.puts("</ul>")
end





def h_code()
  puts "Enter Title of your html page: "
  title = gets.chomp
  puts "<html>"
  puts "<head> #{title} </head>"
  puts "<body>"

  $dom.each{ |i|
  tag = i.instance_variable_get :@tag

  if tag=="<ul>"
    h_li(i.instance_variable_get :@li)
  elsif tag == "<div>"
    puts tag
    (i.instance_variable_get :@divyarray).to_a.each{|p|

    if (p.instance_variable_get :@tag )!= "<ul>"
         print "#{i.instance_variable_get :@tag}\n"
      print "#{i.instance_variable_get :@text}\n"
      print "#{i.instance_variable_get :@closetag}\n"
    else
       h_li(p.instance_variable_get :@li)
    end

    }
    puts "</div>"
  else
       print "#{i.instance_variable_get :@tag}\n"
      print "#{i.instance_variable_get :@text}\n"
      print "#{i.instance_variable_get :@closetag}\n"
  end

  }

  puts "</body>"

  puts "</html>"
end


def create_html()
  puts "Enter Title of your html page: "
  title = gets.chomp

  #creating the file instance in the root directory

  out_file = File.new('ans.html',"w");
  out_file.puts("<html>")
  out_file.puts("<head> <title> #{title} </title> </head>")
  out_file.puts("<body>")


  $dom.each{ |i|
  tag = i.instance_variable_get :@tag

  if tag=="<ul>"
    f_li(i.instance_variable_get :@li,out_file)
  elsif tag == "<div>"
    out_file.puts(tag)
    (i.instance_variable_get :@divyarray).to_a.each{|p|

    if (p.instance_variable_get :@tag )!= "<ul>"
       out_file.puts("#{i.instance_variable_get :@tag}")
       out_file.puts("#{i.instance_variable_get :@text}")
       out_file.puts("#{i.instance_variable_get :@closetag}")

    else
       f_li((p.instance_variable_get :@li),out_file)
    end

    }
    out_file.puts("</div>")
  else
      out_file.puts("#{i.instance_variable_get :@tag}")
       out_file.puts("#{i.instance_variable_get :@text}")
       out_file.puts("#{i.instance_variable_get :@closetag}")
  end

  }

  out_file.puts("</body>")
  out_file.puts("</html>")
end


def primary_func()

  puts "what you want to create: [h1/h2/ul/p/div] or [n]"
  ch = gets.chomp.downcase

 if ch != "n"
   if(ch=="ul")
    list=AddList([])
    ele=Ul.new(list)
    $dom << ele
    primary_func()

  elsif ch=="div"
    divyarray = []
    divyarray=addDiv(divyarray)
    ele = Div.new(divyarray)
    $dom << ele
    primary_func()

  else
    puts "Enter textcontent:"
    text = gets.chomp
    ele = NormalTag.new(ch,text)
    $dom << ele
    primary_func()
  end
else
  puts "\nCreating the html code of it:\n\n"
  create_html()
  h_code()
 end

end

primary_func()


#dom = [#<Div:0x000002272102c9d0 @tag="<div>", @divyarray=[#<Ul:0x000002272102cbd8 @tag="<ul>", @li=["one"], @closetag="</ul>">], @closetag="</div>">]

# h = Ul.new(["one","two"]);
# p h



# class H
# def initialize(t)
#   @t = t
# end
# end


# gh = H.new("jaimatadi");

# p gh.instance_variable_get :@t
