
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper/localizations/AppLocalizations.dart';
import 'package:minesweeper/model/game_size.dart';

Future<GameSize> showNewGameDialog(BuildContext context) async {
  AppLocalizations appLocalizations = AppLocalizations.of(context);
  return await showDialog<GameSize>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(appLocalizations.translate("select_game_size")),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () { Navigator.pop(context, GameSize.SMALL); },
              child: Text(appLocalizations.translate("new_10x10_game")),
            ),
            SimpleDialogOption(
              onPressed: () { Navigator.pop(context, GameSize.MEDIUM); },
              child: Text(appLocalizations.translate("new_15x15_game")),
            ),
            SimpleDialogOption(
              onPressed: () { Navigator.pop(context, GameSize.LARGE); },
              child: Text(appLocalizations.translate("new_20x20_game")),
            ),
          ],
        );
      }
  );
}