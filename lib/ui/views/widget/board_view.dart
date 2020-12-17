import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minesweeper/model/game_size.dart';
import 'package:minesweeper/ui/views/dialog/new_game_dialog.dart';
import 'package:minesweeper/ui/views/dialog/top_image_dialog.dart';
import 'package:minesweeper/ui/views/game/game_view_model.dart';
import 'package:stacked/stacked.dart';

class BoardView extends ViewModelWidget<GameViewModel> {
  @override
  Widget build(BuildContext context, GameViewModel model) {

    final mediaQuery = MediaQuery.of(context);
    double size = mediaQuery.size.shortestSide;

    return Container(
      width: size,
      height: size,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: model.columns,
        ),
        itemBuilder: (context, position) {
          int row = (position / model.columns).floor();
          int column = (position % model.columns);

          Image image = model.getTileImage(row, column);

          return InkWell(
            onTap: () async {
              if (model.isSquareFlagged(row, column)) return;

              if (model.hasBomb(row, column)) {
                model.openSquare(row, column);
                model.handleGameOver();
                TopImageDialog.showGameOverDialog(context,
                        () async {
                          GameSize gameSize = await showNewGameDialog(context);
                          model.createBoard(gameSize.value);
                        }, () {});

              }

              if (model.hasBombsAround(row, column)) {
                model.handleTap(row, column);
              } else {
                model.openSquare(row, column);
              }

              if(model.checkWin()) {
                model.openSquare(row, column);
                model.handleWin();
                TopImageDialog.showWinDialog(context, () async {
                  GameSize gameSize = await showNewGameDialog(context);
                  model.createBoard(gameSize.value);
                }, () {});
              }
            },
            onLongPress: () {
              if (model.isSquaresOpen(row, column) == false) {
                if (model.isSquareFlagged(row, column)) {
                  model.unFlagSquare(row, column);
                } else {
                  model.flaggedSquare(row, column);
                }
              }
            },
            splashColor: Colors.grey,
            child: Container(
              color: Colors.grey,
              child: image,
            ),
          );
        },
        itemCount: model.rows * model.columns,
      ),
    );
  }
}