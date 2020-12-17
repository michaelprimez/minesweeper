import 'package:flutter/material.dart';
import 'package:minesweeper/model/game_size.dart';
import 'package:minesweeper/ui/views/dialog/new_game_dialog.dart';
import 'package:minesweeper/ui/views/game/game_view_model.dart';
import 'package:stacked/stacked.dart';

import 'button_game_start.dart';
import 'clock.dart';
import 'digital_text.dart';

class DisplayView extends ViewModelWidget<GameViewModel> {
  @override
  Widget build(BuildContext context, GameViewModel model) {

    DigitalText digitalText = DigitalText("${model.remainingSquares}".padLeft(3, "0"));
    GameStartButton gameStartButton = GameStartButton(() async {
      GameSize gameSize = await showNewGameDialog(context);
      model.createBoard(gameSize.value);
    });
    Clock clock = Clock(model.seconds);
    
    return Container(
        color: Colors.grey[400],
        child: OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              verticalDirection: VerticalDirection.down,
              children: [
                digitalText,
                gameStartButton,
                clock
              ],
            );
          } else {
            return Column(
              children: [
                digitalText,
                gameStartButton,
                clock
              ],
            );
          }
        },)
    );
  }

}