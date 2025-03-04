import 'package:flutter/material.dart';

class CoverView extends StatelessWidget {
  const CoverView({super.key, required this.gameHasStarted});

  final bool gameHasStarted;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, -0.2),
      child: Text(
        gameHasStarted ? '' : 'TAP TO PLAY',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
