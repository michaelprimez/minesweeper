import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper/model/board.dart';
import 'package:minesweeper/model/game_size.dart';
import 'package:minesweeper/model/image_provider.dart';
import 'package:minesweeper/model/image_type.dart';
import 'package:minesweeper/model/square.dart';
import 'package:minesweeper/services/timer_stream.dart';
import 'package:stacked/stacked.dart';

class GameViewModel extends BaseViewModel {

  Board _game;

  List<List<Square>> get board => _game.board;
  bool _isGameOver = false;
  bool _isPlayerWon = false;
  bool _isAtLeastOneSquareOpen = false;
  
  int _seconds = 0;
  Stream<int> _timer;
  StreamSubscription<int> _timerSubscription;

  int get rows => _game.rows;
  int get columns => _game.columns;
  int get remainingSquares => _game.remainingSquares;
  int get seconds => _seconds;

  bool get isGameOverInProgress => !_isGameOver && !_isPlayerWon;

  GameViewModel() {
    _isAtLeastOneSquareOpen = false;
    _isGameOver = false;
    _isPlayerWon = false;
    _game = Board(GameSize.SMALL.value, GameSize.SMALL.value);
    _seconds = 0;
    if (_timerSubscription != null) {
      _timerSubscription.cancel();
    }
    _timer = stopWatchStream();
    _timerSubscription = _timer.listen((int newTick) {
      _seconds++;
      notifyListeners();
    });
  }

  void createBoard(int size) async {
    _isAtLeastOneSquareOpen = false;
    _isGameOver = false;
    _isPlayerWon = false;
    _game = Board(size, size);
    _seconds = 0;
    if (_timerSubscription != null) {
      _timerSubscription.cancel();
    }
    _timer = stopWatchStream();
    _timerSubscription = _timer.listen((int newTick) {
      _seconds++;
      notifyListeners();
    });
    notifyListeners();
  }

  bool hasBombsAround(int row, col) {
    return board[row][col].numberOfBombs == 0;
  }

  void openSquare(int row, int column) {
    if (!isGameOverInProgress) return;

    if (!board[row][column].isOpen) {
      board[row][column].isOpen = true;
      _game.remainingSquares--;
      _isAtLeastOneSquareOpen = true;
      notifyListeners();
    }
  }

  void flaggedSquare(int row, int column) {
    if (!isGameOverInProgress) return;

    _game.remainingSquares--;

    board[row][column].isFlagged = true;
    notifyListeners();
  }

  void unFlagSquare(int row, int column) {
    if (!isGameOverInProgress) return;

    _game.remainingSquares++;

    board[row][column].isFlagged = false;
    notifyListeners();
  }

  bool hasBomb(row, column) {
    return board[row][column].hasBomb;
  }

  bool checkWin() {
    return _isAtLeastOneSquareOpen && remainingSquares <= 1;
  }

  bool isSquaresOpen(int row, int column) {
    return board[row][column].isOpen;
  }

  bool isSquareFlagged(int row, int column) {
    return board[row][column].isFlagged;
  }

  void handleTap(int row, int column) {
    if (!isGameOverInProgress) return;

    board[row][column].isOpen = true;
    _game.remainingSquares = _game.remainingSquares - 1;

    if (row > 0) {
      if (!board[row - 1][column].hasBomb && board[row - 1][column].isOpen != true) {
        if (board[row][column].numberOfBombs == 0) {
          handleTap(row - 1, column);
        }
      }
    }

    if (column > 0) {
      if (!board[row][column - 1].hasBomb && board[row][column - 1].isOpen != true) {
        if (board[row][column].numberOfBombs == 0) {
          handleTap(row, column - 1);
        }
      }
    }

    if (column < columns - 1) {
      if (!board[row][column + 1].hasBomb && board[row][column + 1].isOpen != true) {
        if (board[row][column].numberOfBombs == 0) {
          handleTap(row, column + 1);
        }
      }
    }

    if (row < rows - 1) {
      if (!board[row + 1][column].hasBomb && board[row + 1][column].isOpen != true) {
        if (board[row][column].numberOfBombs == 0) {
          handleTap(row + 1, column);
        }
      }
    }
    notifyListeners();
  }

  Image getTileImage(int row, int column) {
    Image image;
    if (board[row][column].isOpen == false) {
      if (board[row][column].isFlagged == true) {
        image = getImage(ImageType.flagged);
      } else {
        image = getImage(ImageType.facingDown);
      }
    } else {
      if (board[row][column].hasBomb) {
        image = getImage(ImageType.bomb);
      } else {
        image = getImage(
          getImageTypeFromNumber(board[row][column].numberOfBombs),
        );
      }
    }

    return image;
  }

  void handleGameOver() {
    if (!isGameOverInProgress) return;
    _isGameOver = true;
    _timerSubscription.cancel();
    _timer = null;
    notifyListeners();
  }

  void handleWin() {
    if (!isGameOverInProgress) return;
    _isPlayerWon = true;
    _timerSubscription.cancel();
    _timer = null;
    notifyListeners();
  }
}