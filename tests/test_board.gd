extends "res://addons/gut/test.gd"

var Board = preload("res://src/Board.gd")

func test_get_number_of_live_neighbours_2x2():
	var board = Board.new()

	var test_matrix = [
		[true, false], 
		[false, false]]
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 0, 0), 0) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 0, 1), 1) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 1, 0), 1) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 1, 1), 1) 


func test_get_number_of_live_neighbours_3x3():
	var board = Board.new()

	var test_matrix = [
		[true, false, true], 
		[false, true, true],
		[true, false, false]]

	assert_eq(board.get_number_of_live_neighbours(test_matrix, 0, 0), 1) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 0, 1), 4) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 0, 2), 2) 

	assert_eq(board.get_number_of_live_neighbours(test_matrix, 1, 0), 3) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 1, 1), 4) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 1, 2), 2) 

	assert_eq(board.get_number_of_live_neighbours(test_matrix, 2, 0), 1) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 2, 1), 3) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 2, 2), 2) 


func test_get_number_of_live_neighbours_2x3():
	var board = Board.new()

	var test_matrix = [
		[true, false], 
		[false, false],
		[true, false],
		]

	assert_eq(board.get_number_of_live_neighbours(test_matrix, 0, 0), 0) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 0, 1), 1) 

	assert_eq(board.get_number_of_live_neighbours(test_matrix, 1, 0), 2) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 1, 1), 2) 

	assert_eq(board.get_number_of_live_neighbours(test_matrix, 2, 0), 0) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 2, 1), 1) 


func test_get_number_of_live_neighbours_3x2():
	var board = Board.new()

	var test_matrix = [
		[true, false, true], 
		[false, false, true]
		]

	assert_eq(board.get_number_of_live_neighbours(test_matrix, 0, 0), 0) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 0, 1), 3) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 0, 2), 1) 

	assert_eq(board.get_number_of_live_neighbours(test_matrix, 1, 0), 1) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 1, 1), 3) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 1, 2), 1) 


func test_get_number_of_live_neighbours_4x4():
	var board = Board.new()

	var test_matrix = [
		[false, true, false, true],
		[true, false, true, false],
		[false, false, true, true],
		[false, true, true, false],
	]

	assert_eq(board.get_number_of_live_neighbours(test_matrix, 0, 0), 2) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 0, 1), 2) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 0, 2), 3) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 0, 3), 1) 

	assert_eq(board.get_number_of_live_neighbours(test_matrix, 1, 0), 1) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 1, 1), 4) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 1, 2), 4) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 1, 3), 4) 

	assert_eq(board.get_number_of_live_neighbours(test_matrix, 2, 0), 2) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 2, 1), 5) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 2, 2), 4) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 2, 3), 3) 

	assert_eq(board.get_number_of_live_neighbours(test_matrix, 3, 0), 1) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 3, 1), 2) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 3, 2), 3) 
	assert_eq(board.get_number_of_live_neighbours(test_matrix, 3, 3), 3) 



func test_next_generation_dead_to_live():
	var board = Board.new()

	var test_matrix = [
		[true, false], 
		[true, true]
		]

	var expected_matrix = [
		[true, true], 
		[true, true]
		]

	assert_eq(board.next_generation(test_matrix), expected_matrix)

func test_next_generation_live_to_dead():
	var board = Board.new()

	var test_matrix = [
		[true, false], 
		[false, false]
		]

	var expected_matrix = [
		[false, false], 
		[false, false]
		]

	assert_eq(board.next_generation(test_matrix), expected_matrix)

func test_next_generation_4x4():
	var board = Board.new()

	var test_matrix = [
		[false, true, false, true],
		[true, false, true, false],
		[false, false, true, true],
		[false, true, true, false],
	]

	var expected_matrix = [
		[false, true, true, false],
		[false, false, false, false],
		[false, false, false, true],
		[false, true, true, true],
	]

	assert_eq(board.next_generation(test_matrix), expected_matrix)

func test_next_generation_2x4():
	var board = Board.new()

	var test_matrix = [
		[false, true, false, true],
		[true, false, true, false],
	]

	var expected_matrix = [
		[false, true, true, false],
		[false, true, true, false],
	]
	
	assert_eq(board.next_generation(test_matrix), expected_matrix)


func test_next_generation_3x2():
	var board = Board.new()

	var test_matrix = [
		[false, true],
		[true, false],
		[true, false],
	]

	var expected_matrix = [
		[false, false],
		[true, true],
		[false, false],
	]

	assert_eq(board.next_generation(test_matrix), expected_matrix)
