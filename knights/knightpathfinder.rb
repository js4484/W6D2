require_relative 'tree_node_copy'
require 'set'

class KnightPathFinder

    MOVES = [
    [1, 2],
    [2, 1],
    [-1, 2],
    [-1, -2],
    [1, -2],
    [2, -1],
    [-2, 1],
    [-2, -1]
    ].shuffle.to_set

    attr_accessor :root_node

    def initialize(position)
        @root_node = PolyTreeNode.new(position)
        @considered_positions = [position]
        build_move_tree
    end

    def build_move_tree
        queue = [@root_node]
        until queue.empty?
            dequeue = queue.shift
            new_moves_to_consider = new_move_positions(dequeue.value)
            new_moves_to_consider.each do |move|
                node_prime = PolyTreeNode.new(move)
                queue << node_prime
                node_prime.parent = dequeue
            end
        end
    end

    def self.valid_moves(pos)
        new_positions = []
        MOVES.each do |move|
            new_pos = [pos[0] + move[0], pos[1] + move[1]]
            new_positions << new_pos if new_pos[0].between?(0,7) && new_pos[1].between?(0,7)
        end
        new_positions
    end

    def new_move_positions(pos)
        valid_moves = KnightPathFinder.valid_moves(pos)
        valid_moves.reject! { |move| @considered_positions.include?(move) }
        @considered_positions += valid_moves
        valid_moves
    end

    def find_path(end_pos)
        found_node = @root_node.bfs(end_pos)
        trace_path_back(found_node)
    end

    def trace_path_back(node)
        path_arr = [node.value]
        until node.parent.nil?
            path_arr.unshift(node.parent.value)
            node = node.parent
        end
        path_arr
    end
end


kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]


# alias githost="git config --local user.email js4484@columbia.edu && git config --local user.name js4484"

# alias gitguest="git config --local user.email joshhk72@gmail.com && git config --local user.name joshhk72"