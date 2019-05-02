import 'collision_box.dart';
import '../obstacle/obstacle.dart';
import '../tf_run/config.dart';
import '../tf_run/tf_run.dart';

bool checkForCollision(Obstacle obstacle, TFVan tfVan) {
  CollisionBox tfVanBox = CollisionBox(
    x: tfVan.x + 1,
    y: tfVan.y + 1,
    width: TFVanConfig.width - 2,
    height: TFVanConfig.height - 2,
  );

  CollisionBox obstacleBox = CollisionBox(
    x: obstacle.x + 1,
    y: obstacle.y + 1,
    width: obstacle.type.width * obstacle.internalSize - 2,
    height: obstacle.type.height - 2,
  );

  if (boxCompare(tfVanBox, obstacleBox)) {
    List<CollisionBox> collisionBoxes = obstacle.collisionBoxes;
    List<CollisionBox> tRexCollisionBoxes =
        tfVan.ducking ? TFVanCollisionBoxes.ducking : TFVanCollisionBoxes.running;

    bool crashed = false;

    collisionBoxes.forEach((obstacleCollisionBox) {
      CollisionBox adjObstacleBox =
          createAdjustedCollisionBox(obstacleCollisionBox, obstacleBox);

      tRexCollisionBoxes.forEach((tRexCollisionBox) {
        CollisionBox adjTRexBox =
            createAdjustedCollisionBox(tRexCollisionBox, tfVanBox);
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
