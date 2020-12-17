import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper/ui/views/widget/board_view.dart';
import 'package:minesweeper/ui/views/widget/display_view.dart';
import 'package:stacked/stacked.dart';

import 'game_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GameViewModel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.grey[500],
              body: SafeArea(
                bottom: false,
                child: Center(
                  child: OrientationBuilder(builder: (context, orientation) {
                    if (orientation == Orientation.portrait) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DisplayView(),
                          BoardView()
                        ],
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          DisplayView(),
                          BoardView()
                        ],
                      );
                    }
                  },),
                ),
              )
          );
        },
        viewModelBuilder: () => GameViewModel()
    );
  }
}
