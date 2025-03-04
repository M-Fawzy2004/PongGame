import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  const MyBall({super.key, this.x, this.y, required this.gameHasStarted});

  final x;
  final y;
  final bool gameHasStarted;

  @override
  Widget build(BuildContext context) {
    return gameHasStarted
        ? Container(
            alignment: Alignment(x, y),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              height: 14,
              width: 14,
            ),
          )
        : Container(
            alignment: Alignment(x, y),
            child: AvatarGlow(
              child: Material(
                elevation: 8.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  radius: 10.0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ),
          );
  }
}
