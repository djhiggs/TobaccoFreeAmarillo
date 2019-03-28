import 'package:tobaccoFreeAmarilloApp/game/collision/collision_box.dart';
import 'package:tobaccoFreeAmarilloApp/game/obstacle/obstacle.dart';
import 'package:tobaccoFreeAmarilloApp/game/t_rex/config.dart';
import 'package:tobaccoFreeAmarilloApp/game/t_rex/t_rex.dart';

bool checkForCollision(Obstacle obstacle, TRex tRex) {
  CollisionBox tRexBox = CollisionBox(
    x: tRex.x + 1,
    y: tRex.y + 1,
    width: TRexConfig.width - 2,
    height: TRexConfig.height - 2,
  );

  CollisionBox obstacleBox = CollisionBox(
    x: obstacle.x + 1,
    y: obstacle.y + 1,
    width: obstacle.type.width * obstacle.internalSize - 2,
    height: obstacle.type.height - 2,
  );

  if (boxCompare(tRexBox, obstacleBox)) {
    List<CollisionBox> collisionBoxes = obstacle.collisionBoxes;
    List<CollisionBox> tRexCollisionBoxes =
        tRex.ducking ? TRexCollisionBoxes.ducking : TRexCollisionBoxes.running;

    bool crashed = false;

    collisionBoxes.forEach((obstacleCollisionBox) {
      CollisionBox adjObstacleBox =
          createAdjustedCollisionBox(obstacleCollisionBox, obstacleBox);

      tRexCollisionBoxes.forEach((tRexCollisionBox) {
        CollisionBox adjTRexBox =
            createAdjustedCollisionBox(tRexCollisionBox, tRexBox);
        crashed = crashed || boxCompare(adjTRexBox, adjObstacleBox);
      });
    });
    return crashed;
  }
  return false;
}

bool boxCompare(CollisionBox tRexBox, CollisionBox obstacleBox) {
  final double obstacleX = obstacleBox.x;
  final double obstacleY = obstacleBox.y;

  return (tRexBox.x < obstacleX + obstacleBox.width &&
      tRexBox.x + tRexBox.width > obstacleX &&
      tRexBox.y < obstacleBox.y + obstacleBox.height &&
      tRexBox.height + tRexBox.y > obstacleY);
}

CollisionBox createAdjustedCollisionBox(
    CollisionBox box, CollisionBox adjustment) {
  return CollisionBox(
      x: box.x + adjustment.x,
      y: box.y + adjustment.y,
      width: box.width,
      height: box.height);
}
