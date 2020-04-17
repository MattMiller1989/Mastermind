

class Game_board
    
    def initialize
        @@curr_board=[["O","O","O","O"],
                      ["O","O","O","O"],
                      ["O","O","O","O"],
                      ["O","O","O","O"],
                      ["O","O","O","O"],
                      ["O","O","O","O"],
                      ["O","O","O","O"],
                      ["O","O","O","O"],
                      ["O","O","O","O"],
                      ["O","O","O","O"]]
        @@helper_pegs=[["o","o","o","o"],
                       ["o","o","o","o"],
                       ["o","o","o","o"],
                       ["o","o","o","o"],
                       ["o","o","o","o"],
                       ["o","o","o","o"],
                       ["o","o","o","o"],
                       ["o","o","o","o"],
                       ["o","o","o","o"],
                       ["o","o","o","o"]]
    end
    def print_board
        (0...10).each do |n|
            puts @@curr_board[n].join("|")+"||"+@@helper_pegs[n].join(".")
        end

    end

    def put_row(row,code)
        @@curr_board[row]=code.get_pegs
    end
    def put_helper_pegs(row,code)
        @@helper_pegs[row]=code.get_pegs
    end
end

class Game_runner



    def initialize
        @my_board=Game_board.new
        start_game
        @game_over=false

    end

    def start_game
        @curr_row=0
        master_code=Game_code.new
        5.times do 
        #while !game_over
            player_choice=ask_for_row
            player_row=Game_row.new(player_choice.split)
            helper=Game_row.new(master_code.compare_code(player_row))
            @my_board.put_row(@curr_row,player_row)
            @my_board.put_helper_pegs(@curr_row,helper)
            @curr_row+=1
            @my_board.print_board
            puts master_code.get_pegs
        end
    end
    def ask_for_row
        good_selection=false
        while !good_selection
            puts "Please enter your selection for row #{@curr_row}"
            selection=gets.chomp
            if selection.match(/(^([RGBYPW] ){3})[RGBYPW]$/)
                good_selection=true
            end

        end
        return selection

    end

    
end
class Code
    #@@pegs=[]
    def initialize(arr)
        
        @pegs=arr
    end
    def compare_code(other_code)
        
        #puts other_code.get_pegs
        helper_pegs=[]
        other_pegs=other_code.get_pegs.clone
        
        @pegs.each_with_index do |element,index|
            if element == other_pegs[index]
                #puts "element: "+element.to_s+" index: "+index.to_s+" other_pegs[index]: "+other_pegs[index].to_s
                helper_pegs.push("r")
                other_pegs[index]=" "
            end
        end
        
        other_pegs.each_with_index do |e,ind|
            if @pegs.include?(e)
                helper_pegs.push("w")
                other_pegs[ind]=" "
            end
        end
        
        return helper_pegs

    end
    def get_pegs
        return @pegs
    end
end

class Game_code < Code

    
    def initialize()
        @pegs=Array.new
        (0...4).each do |n|
            @pegs[n]=["R","G","B","P","Y","W"].sample
        end
    end

end

class Game_row < Code

    # def initialize(a0,a1,a2,a3)
    #     @a0=a0
    #     @a1=a1
    #     @a2=a2
    #     @a3=a3
    # end
    
end

my_runner=Game_runner.new
# my_board=Game_board.new
# my_row=Game_row.new("R","P","B","W")
# my_board.put_row(1,my_row)

# my_new_row=Game_row.new("P","P","Y","Y")
# my_board.put_row(2,my_new_row)

# helper=my_new_row.compare_code(my_row)
# helper_code=Code.new(helper[0],helper[1],helper[2],helper[3])

# my_board.put_row(6,helper_code)
# # master_code=Game_code.new
# # my_board.put_row(4,master_code)
#  my_board.print_board
