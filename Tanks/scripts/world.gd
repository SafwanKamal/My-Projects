extends Node2D

func _ready():
	var map_rect = $TileMap.get_used_rect()
	map_rect.position *= $TileMap.tile_set.tile_size
	map_rect.size *= $TileMap.tile_set.tile_size
	$LeftWall.position.x = map_rect.position.x - 10
	$LeftWall.position.y = map_rect.position.y + map_rect.size.y/2.0
	$LeftWall.find_child("CollisionShape2D").shape.size.x = 20
	$LeftWall.find_child("CollisionShape2D").shape.size.y = map_rect.size.y
	
	$RightWall.position.x = map_rect.position.x + 10
	$RightWall.position.y = map_rect.position.y + map_rect.size.y/2.0

	
	$TopWall.position.y = map_rect.position.y - 10
	$TopWall.position.x = map_rect.position.x + map_rect.size.x/2.0
	$TopWall.find_child("CollisionShape2D").shape.size.y = 20
	$TopWall.find_child("CollisionShape2D").shape.size.x = map_rect.size.x
	
	$BottomWall.position.y = map_rect.position.y + 10
	$BottomWall.position.x = map_rect.position.x + map_rect.size.x/2.0

