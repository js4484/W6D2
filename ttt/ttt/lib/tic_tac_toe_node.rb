require_relative 'tic_tac_toe'
require "byebug"

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def inspect
    node.prev_move_pos
  end

  def children
    # debugger
    child_mark = (@next_mover_mark == :o ? :x : :o)
    children_arr = []

    (0..2).each do |row|
      (0..2).each do |col|
        if @board.empty?([row, col])
          new_board = @board.dup
          new_board[[row, col]] = @next_mover_mark
          new_instance = TicTacToeNode.new(new_board, child_mark, [row, col])
          children_arr << new_instance
        end
      end
    end
    children_arr
  end

  def losing_node?(evaluator)
    opp_mark = (evaluator == :o ? :x : :o)
    return self.board.winner == opp_mark if self.board.over? 

    children_array = self.children
    if @next_mover_mark == evaluator
      children_array.all? {|child| child.losing_node?(evaluator)}
    else
      children_array.any? {|child| child.losing_node?(evaluator)}
    end
  end

  def winning_node?(evaluator)
    opp_mark = (evaluator == :o ? :x : :o)
    return self.board.winner == evaluator if self.board.over?

    children_array = self.children
    if @next_mover_mark == evaluator
      children_array.any? {|child| child.winning_node?(evaluator)}
    else
      children_array.all? {|child| child.winning_node?(evaluator)}
    end
  end
end