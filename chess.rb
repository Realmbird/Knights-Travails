# frozen_string_literal: false

# Node for knight
class KnightNode
  # Adjacency list for all possible knight moves starts from Q1 -. Q4
  attr_accessor :possible, :traveled
  attr_reader :value

  def initialize(value = nil, list = nil, possible = nil)
    @value = value
    @possible = possible
    @traveled = list
  end

  def to_s
    "Node with value: #{@value}"
  end
end

# Builds a tree of all the possible points of tree of all possible moves of the knight
=begin
class KnightPotential
  attr_accessor :root, :endpoint, :board

  def initialize(startpoint, endpoint, board)
    @endpoint = endpoint
    @board = board
    @root = build_tree(startpoint)
  end

  def build_tree(startpoint, list = [])
    knight_list = list
    knight_list.push(startpoint)
    knight = KnightNode.new(startpoint, knight_list)

    possible = Array.new(8)
    prev = knight.value
    # if it is the endpoint is redundant?
    return knight if prev == endpoint

    row = knight.value[0]
    collumn = knight.value[1]
    point_list = [[row + 1, collumn + 2], [row + 2, collumn + 1], [row - 1, collumn + 2], [row - 2, collumn + 1], [row + 1, collumn - 2], [row + 2, collumn - 1], [row - 2, collumn - 1], [row - 1, collumn - 2]]
    point_list.each_with_index do |point, index|
      # when already travelled or point is nil add nil or escape condition
      row = point[0]
      col = point[1]
      possible[index] =  if current.traveled.include?(point) || @board[point[0]].nil? || @board[point[0]][point[1]].nil? || point[0] < 0 || point[1] < 0
                          nil
                        # if it is the endpoint is redundant?
                        elsif point[0] == endpoint[0] && point[1] == endpoint[1]
                          KnightNode.new(point, knightList)
                        else
                          # recursive function call
                          build_tree(point_list[index], knightList)
                        end
    end
    # adds list to knight
    knight.possible = possible
    # returns knight
    knight
  end
end
=end

# Code For the Knight and finding his best path to another tile on the board
class KnightTravails
  def initialize
    @board = Array.new(8, Array.new(8, 'x'))
  end

  # Breath First Search and Generates new points until it reaches endpoint
  def knight_moves(start_point, end_point)
    root = KnightNode.new(start_point, [start_point])
    queue = [root]
    until queue.empty?
      current = queue.shift
      if current.value[0] == end_point[0] && current.value[1] == end_point[1]
        k_path = current.traveled
        puts "You made it in #{k_path.length} moves!  Here's your path:"
        k_path.each{|tile| p tile}
        return k_path
      end

      row = current.value[0]
      collumn = current.value[1]
      point_list = [[row + 1, collumn + 2], [row + 2, collumn + 1], [row - 1, collumn + 2], [row - 2, collumn + 1], [row + 1, collumn - 2], [row + 2, collumn - 1], [row - 2, collumn - 1], [row - 1, collumn - 2]]
      point_list.each do |point|
        unless current.traveled.include?(point) || @board[point[0]].nil? || @board[point[0]][point[1]].nil? || point[0] < 0 || point[1] < 0
          # not invalid
          list = current.traveled.clone
          list.push(point)
          queue.push(KnightNode.new(point, list))
        end
      end
      queue.push
    end
  end

  def print_board
    @board.each_with_index { |row, index| puts "#{index} #{row}" }
    puts '    a    b    c    d    e    f    g    h'
  end
end

knight = KnightTravails.new
knight.print_board
knight.knight_moves([0, 0], [1, 2])
