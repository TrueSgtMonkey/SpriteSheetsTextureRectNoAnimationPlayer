extends TextureRect

@export var rows : int = 2
@export var cols : int = 4
@export var fps  : int = 18
@export var maxFrame : int = -1

# data variables
var time := 0.0
var sizeAtlas := Vector2()
var currRow : int = 0
var currCol : int = 0
var currFrame : int = 0
var currPos := Vector2()

# reference variables
var atlas : AtlasTexture = null

func _ready():
  time = 1.0 / float(fps)
  $Timer.wait_time = time
  $Timer.timeout.connect(nextFrame)
  $Timer.start()
  
  if texture is AtlasTexture:
    atlas = texture
  else:
    printerr("Texture in ", name, " needs to be of type AtlasTexture")
    return
    
  sizeAtlas = atlas.get_size()

func nextFrame():
  if currCol < cols:
    currPos.x += sizeAtlas.x
    atlas.region.position.x = currPos.x
    currCol += 1
    currFrame += 1
    
  if currCol >= cols:
    currPos.x = 0
    atlas.region.position.x = 0
    currCol = 0
    currFrame -= 1
    
    if currRow < rows:
      currPos.y += sizeAtlas.y
      atlas.region.position.y = currPos.y
      currRow += 1
      currFrame += 1
      
    if currRow >= rows:
      currPos.y = 0
      atlas.region.position.y = 0
      currRow = 0
      currFrame = 0
      
  if maxFrame >= 0 && currFrame >= maxFrame:
    currPos = Vector2.ZERO
    atlas.region.position = currPos
    currCol = 0
    currRow = 0
    currFrame = 0
    
  print(currFrame)
    
