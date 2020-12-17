import 'package:flutter/material.dart';
import 'package:minesweeper/localizations/AppLocalizations.dart';
import 'package:minesweeper/ui/views/dialog/dialog_consts.dart';
import 'package:minesweeper/utils/text_utils.dart';

class TopImageDialog extends StatelessWidget {
  final String title;
  final String description;
  final String okButtonText;
  final String cancelButtonText;
  final String topImagePath;
  final Function onOkAction;
  final Function onCancelAction;

  const TopImageDialog({
    Key key,
    @required this.title,
    @required this.description,
    @required this.okButtonText,
    this.cancelButtonText,
    this.topImagePath,
    this.onOkAction,
    this.onCancelAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: _dialogContent(context),
    );
  }

  _dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Constants.avatarRadius + Constants.padding,
            bottom: Constants.padding,
            left: Constants.padding,
            right: Constants.padding,
          ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Constants.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              RichText(
                text: TextSpan(
                    text: title,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87
                    ),
                ),
              ),
              SizedBox(height: 16.0),
              RichText(
                text: TextSpan(
                    text: description,
                    style: TextStyle(
                      fontSize: 16.0,
                        color: Colors.black87
                    ),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    cancelButtonText != null ? FlatButton(
                      onPressed: () {
                        if (onCancelAction == null) {
                          Navigator.of(context).pop();
                        } else {
                          Navigator.of(context).pop();
                          onCancelAction();
                        }
                      },
                      child: RichText(
                        text: TextSpan(
                          text: cancelButtonText,
                          style: TextStyle(
                              color: Colors.red
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      textColor: Colors.red,
                    )
                        : Container(
                      height: 0.0,
                      width: 0.0,
                    ),
                    FlatButton(
                      onPressed: () {
                        if (onOkAction == null) {
                          Navigator.of(context).pop();
                        } else {
                          Navigator.of(context).pop();
                          onOkAction();
                        }
                      },
                      child: RichText(
                        text: TextSpan(
                          text: okButtonText,
                          style: TextStyle(
                              color: Colors.blue[700]
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        !TextUtils.isEmpty(topImagePath)
            ? Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: Image.asset(topImagePath,),
          ),
        )
            : Container(
          width: 0,
          height: 0,
        ),
      ],
    );
  }

  static void showGameOverDialog(BuildContext context, Function okActionClicked, Function cancelActionClicked) async {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    await showDialog(
      context: context,
      builder: (BuildContext context) =>
          TopImageDialog(
            title: appLocalizations.translate("game_over"),
            description: appLocalizations.translate("game_over_description"),
            okButtonText: appLocalizations.translate("yes_i_want"),
            cancelButtonText: appLocalizations.translate("nop_i_fine"),
            onOkAction: () {
              okActionClicked();
            },
            onCancelAction: () {
              cancelActionClicked();
            },
            topImagePath: "assets/images/boom_explosion.png",
          ),
    );
  }

  static void showWinDialog(BuildContext context, Function okActionClicked, Function cancelActionClicked) async {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    await showDialog(
        context: context,
        builder: (BuildContext context) =>
        TopImageDialog(
          title: appLocalizations.translate("you_won"),
          description: appLocalizations.translate("win_description"),
          okButtonText: appLocalizations.translate("yes_i_want"),
          cancelButtonText: appLocalizations.translate("nop_i_fine"),
          onOkAction: () {
            okActionClicked();
          },
          onCancelAction: () {
            cancelActionClicked();
          },
          topImagePath: "assets/images/winner.png",
        ),
    );
  }
}
