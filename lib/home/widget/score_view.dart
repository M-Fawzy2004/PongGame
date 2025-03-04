import 'package:flutter/material.dart';

class ScoreView extends StatelessWidget {
  const ScoreView({
    super.key,
    required this.gameHasStarted,
    this.enmeyScore,
    this.playerScore,
  });

  final bool gameHasStarted;
  final enmeyScore;
  final playerScore;

  @override
  Widget build(BuildContext context) {
    return gameHasStarted
        ? Stack(
            children: [
              Container(
                alignment: Alignment(0, 0),
                child: Container(
                  height: 1,
                  width: MediaQuery.sizeOf(context).width / 4,
                  color: Colors.grey[700],
                ),
              ),
              Container(
                alignment: Alignment(0, -0.3),
                child: Text(
                  enmeyScore.toString(),
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 100,
                  ),
                ),
              ),
              Container(
                alignment: Alignment(0, 0.3),
                child: Text(
                  playerScore.toString(),
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 100,
                  ),
                ),
              ),
            ],
          )
        : Container();
  }
}
