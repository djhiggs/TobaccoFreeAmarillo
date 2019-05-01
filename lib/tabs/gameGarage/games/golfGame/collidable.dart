import 'dart:math';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import '../vector2D.dart';
import 'golfBall.dart';
import 'golfGame.dart';
import 'package:flame/flame.dart';

class Collidable extends Component{
  static const SPAWN_MIN_DISTANCE = 3;
  ///The difference between the max and min spawn distances.
  static const SPAWN_RANGE = 5;
  static List<Sprite> _sprites;
  static const List<double> _COLLISION_CEOFICIENTS = <double>[
    1
  ]; 
  static Future<void> intitialize() async{
    List<String> names = <String>[
      "golfGame/colliders/spring.png",
    ];
    _sprites = List();
    for(int i = 0; i < names.length; i++){
      if(!Flame.images.loadedFiles.containsKey(names[i]))
        await Flame.images.load(names[i]);
      _sprites.add(Sprite.fromImage(Flame.images.loadedFiles[names[i]]));
    }
  }
  GolfGame golfGame;
  GolfBall get golfBall => golfGame.golfBall; 
  double collisionCeoficient;
  SpriteComponent spriteComponent;
  Vector2D location =Vector2D(0, 0);
  double screenHeight;

  Collidable(this.golfGame,this.screenHeight);

  @override
  void render(Canvas c) {
    if(spriteComponent !=null)
      spriteComponent.render(c);
  }

  @override
  void update(double dt) {
    if(golfBall ==null || (spriteComponent !=null&& golfBall.golfBallLocation.x < spriteComponent.x))
      return;
    if(golfBall.golfBallLocation.x > location.x + spriteComponent.width){
      if(spriteComponent ==null|| location.x + spriteComponent.width < golfGame.camera.x)
        replace();
    }
    else if(golfBall.golfBallLocation.y < GolfBall.radius + location.y + spriteComponent.height){//collision
      golfBall.velocity.y *= -collisionCeoficient;
      golfBall.velocity.x *= collisionCeoficient;
      golfBall.golfBallLocation.y = location.y + GolfBall.radius + spriteComponent.height;
    }
  }
  int mult = 1;
  void replace(){
    Random ran = Random();
    var newIndex = ran.nextInt(_sprites.length);
    if(spriteComponent ==null)
      spriteComponent =SpriteComponent.fromSprite(
        _sprites[newIndex].originalSize.x, 
        _sprites[newIndex].originalSize.y, 
        _sprites[newIndex]);
    else
      spriteComponent.sprite =_sprites[newIndex];
    collisionCeoficient =_COLLISION_CEOFICIENTS[newIndex];
    spriteComponent.x = location.x = (ran.nextInt(SPAWN_RANGE*100*mult)/100 + SPAWN_MIN_DISTANCE)*GolfGame.pixelsPerMeter + golfGame.camera.x;
    spriteComponent.y =screenHeight - location.y - spriteComponent.height;

    mult*=2;
  }
}