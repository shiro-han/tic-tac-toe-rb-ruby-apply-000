WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  index = user_input.to_i - 1
  index
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0,8) && !(board[index] == "X" || board[index] == "O")
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"

  user_input = gets.chomp
  index = input_to_index(user_input)
  current_player = current_player(board)

  if valid_move?(board, index) == true
    move(board, index, current_player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |cell|
    if cell == "X" || cell == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  count = turn_count(board)
  if count%2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    index1 = win_combo[0]
    index2 = win_combo[1]
    index3 = win_combo[2]

    position1 = board[index1]
    position2 = board[index2]
    position3 = board[index3]

    array = [position1, position2, position3]

    if array == ["X", "X", "X"] || array == ["O", "O", "O"]
      return win_combo
    end
  end
  false
end

def full?(board)
  all_full = board.none? do |position|
    position == " "
  end
  all_full
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    true
  else
    false
  end
end

def over?(board)
  if !(won?(board) == false) || draw?(board) == true || full?(board) == true
    true
  else
    false
  end
end

def winner(board)
  if won?(board) == false
    return nil
  else
    win_indexes = won?(board)
    win_index = win_indexes[0]
    return board[win_index]
  end
end

def play(board)
  while over?(board) == false
    turn(board)
  end

  if won?(board) != false
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) == true
    puts "Cat's Game!"
  end
end
