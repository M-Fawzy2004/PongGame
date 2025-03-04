import 'package:flutter/material.dart';

class CustomBrick extends StatelessWidget {
  const CustomBrick(
      {super.key, this.x, this.y, required this.brickWidth, this.thisIsEnemy});

  final x;
  final y;
  final brickWidth;
  final thisIsEnemy;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * x + brickWidth) / (2 - brickWidth), y),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: thisIsEnemy ? Colors.deepPurple[300] : Colors.white,
          height: 20,
          width: MediaQuery.sizeOf(context).width * brickWidth / 2,
        ),
      ),
    );
  }
}
