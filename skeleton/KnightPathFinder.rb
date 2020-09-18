require_relative "./lib/00_tree_node.rb"
require "byebug"
class KnightPathFinder

  attr_reader :position, :root_node
    def initialize(pos)
        @position = pos
        @root_node = PolyTreeNode.new(pos)
    end

    def new_move_positions(pos)
      self.class.valid_moves(pos)
    end

    def build_move_tree                 
      line = [@root_node]
      logged_moves = [@position]  
      until line.empty?
        ele = line.shift       
        valid_moves = new_move_positions(ele.value)          
        valid_moves.each do |move|        
            if !logged_moves.include?(move)
                node = PolyTreeNode.new(move)
                node.parent = ele 
                line << node
            end        
          end
        logged_moves += valid_moves
        logged_moves.uniq!
      end
      return nil
    end

    def self.valid_moves(pos)        
        row, col = pos 
        @considered_positions = [[row+1, col+2], [row+1, col-2], 
                                [row-1, col+2], [row-1, col-2], 
                                [row+2, col+1], [row+2, col-1],  
                                [row-2, col+1], [row-2, col-1]]
        @valid_positions = @considered_positions.select {|ele| ele[0].between?(0,7) && ele[1].between?(0,7)}
        return @valid_positions
    end

    def find_path(end_pos)
        self.build_move_tree
        node = @root_node.bfs(end_pos)
        return trace_path_back(node) if !node.nil?
        return nil
    end

    def trace_path_back(node)
        path = []
        while node.parent != nil 
            path.unshift(node.value)
            node = node.parent 
        end 
        return path.unshift(@position)
    end

end                                                                         

