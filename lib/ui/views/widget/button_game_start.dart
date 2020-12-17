import 'package:flutter/material.dart';

class GameStartButton extends StatelessWidget {

  final Function _onPressed;

  const GameStartButton(this._onPressed);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onPressed,
      child: Container(
        width: 58,
        height: 58,
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: Image.asset(
                    "assets/images/facingDown.png", width: 42, height: 42,
                ),
                color: Colors.grey,
                iconSize: 42,
                onPressed: () {
                  _onPressed();
                },
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  text: "🙂",
                  style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
