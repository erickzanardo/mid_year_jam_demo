import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_mini_sprite/flame_mini_sprite.dart';
import 'package:flutter/material.dart';
import 'package:mid_year_jam_demo/assets.dart';
import 'package:mini_sprite/mini_sprite.dart';

void main() {
  runApp(GameWidget(game: FunGame()));
}

class FunGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    final miniLibrary = MiniLibrary.fromDataString(library);
    final sprites = await miniLibrary.toSprites(
      color: Colors.white,
      pixelSize: 1,
    );

    final miniMap = MiniMap.fromDataString(map);
    for (final entry in miniMap.objects.entries) {
      final sprite = sprites[entry.value['sprite']];
      if (sprite != null) {
        unawaited(
          add(
            SpriteComponent(
              sprite: sprite,
              position: Vector2(
                entry.key.x * 8,
                entry.key.y * 8,
              ),
              size: Vector2(
                sprite.image.width.toDouble(),
                sprite.image.height.toDouble(),
              ),
            ),
          ),
        );
      }
    }

    camera.zoom = 4;
    camera.snapTo(-size / 2);
  }
}
