// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pong_game/home/widget/cover_view.dart';
import 'package:pong_game/home/widget/custom_brick.dart';
import 'package:pong_game/home/widget/my_ball.dart';
import 'package:pong_game/home/widget/score_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

enum Direction { up, down, left, right }

class _HomeViewState extends State<HomeView> {
  double ballX = 0;
  double ballY = 0;
  double playerX = -0.2;
  double brickWidth = 0.4;
  int playerScore = 0;
  double enemyX = -0.2;
  int enemyScore = 0;
  var ballYDirection = Direction.down;
  var ballXDirection = Direction.left;
  bool gameHasStarted = false;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(
      const Duration(milliseconds: 5),
      (timer) {
        updateDirection();
        moveBall();
        moveEnemy();
        if (isPlayerDead()) {
          enemyScore++;
          timer.cancel();
          _showDialog(false);
        }
        if (isEnemyDead()) {
          playerScore++;
          timer.cancel();
          _showDialog(true);
        }
      },
    );
  }

  void moveEnemy() {
    setState(() {
      enemyX = ballX;
    });
  }

  void _showDialog(bool playerWon) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text(
            playerWon ? 'YOU WIN!' : 'BOT WINS!',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: resetGame,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(5),
                color: playerWon ? Colors.white : Colors.deepPurple[100],
                child: Center(
                  child: Text(
                    'Play Again',
                    style: TextStyle(
                      color: playerWon ? Colors.black : Colors.deepPurple[800],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void resetGame() {
    setState(() {
      Navigator.pop(context);
      gameHasStarted = false;
      ballX = 0;
      ballY = 0;
      playerX = -0.2;
      enemyX = -0.2;
    });
  }

  bool isEnemyDead() => ballY <= -1;
  bool isPlayerDead() => ballY >= 1;

  void updateDirection() {
    setState(() {
      if (ballY >= 0.9 && playerX + brickWidth >= ballX && playerX <= ballX) {
        ballYDirection = Direction.up;
      } else if (ballY <= -0.9) {
        ballYDirection = Direction.down;
      }

      if (ballX >= 1) {
        ballXDirection = Direction.left;
      } else if (ballX <= -1) {
        ballXDirection = Direction.right;
      }
    });
  }

  void moveBall() {
    setState(() {
      ballY += ballYDirection == Direction.down ? 0.01 : -0.01;
      ballX += ballXDirection == Direction.right ? 0.01 : -0.01;
    });
  }

  void moveLeft() {
    setState(() {
      if (playerX - 0.05 >= -1) {
        playerX -= 0.05;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (playerX + brickWidth <= 1) {
        playerX += 0.05;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          body: Center(
            child: Stack(
              children: [
                CustomBrick(
                  x: enemyX,
                  y: -0.9,
                  brickWidth: brickWidth,
                  thisIsEnemy: true,
                ),
                CoverView(gameHasStarted: gameHasStarted),
                ScoreView(
                  gameHasStarted: gameHasStarted,
                  enmeyScore: enemyScore,
                  playerScore: playerScore,
                ),
                CustomBrick(
                  x: playerX,
                  y: 0.9,
                  brickWidth: brickWidth,
                  thisIsEnemy: false,
                ),
                MyBall(
                  x: ballX,
                  y: ballY,
                  gameHasStarted: gameHasStarted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
