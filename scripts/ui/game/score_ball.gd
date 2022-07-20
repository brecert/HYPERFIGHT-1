extends Node2D

var score = 0
var temp_score = 0

export var reversed = false
var win_score = global.win_score

enum SpriteState {STATE_NONE, STATE_TEMP, STATE_FULL}

func _ready():
	if reversed:
		scale.x = -1
	for i in win_score:
		var ball = $ball.duplicate()
		ball.translate(Vector2(18 * i, 0))
		add_child(ball)
	remove_child($ball)

func use_ball():
	set_temp_score(temp_score - 1)

func inc_score():
	set_score(score + 1)
	set_temp_score(score)
	return score
	
func win_score():
	set_scores(win_score)
	return score

func reset_score():
	set_scores(0)
	return score
	
func update_score():
	var count = 1
	var children = get_children()
	for child in children:
		if count <= score:
			if count > temp_score:
				child.frame = SpriteState.STATE_TEMP
			else:
				child.frame = SpriteState.STATE_FULL
		else:
			child.frame = SpriteState.STATE_NONE
			
		count += 1

func set_scores(new_score):
	score = clamp(new_score, 0, win_score)
	temp_score = clamp(new_score, 0, win_score)
	update_score()

func set_score(new_score):
	score = clamp(new_score, 0, win_score)
	update_score()

func set_temp_score(new_score):
	temp_score = clamp(new_score, 0, win_score)
	update_score()

func remove_temps():
	set_temp_score(score)
