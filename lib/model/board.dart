import 'dart:math';

import 'square.dart';

class Board {
  final int rows;
  final int columns;
  List<List<Square>> board;

  int remainingSquares;

  Board(
      int rows,
      int columns
  ): this.rows = rows, this.columns = columns {
    remainingSquares = rows * columns;

    Random random = new Random();

    board = List.generate(rows, (i) {
      return List.generate(columns, (j) {
        int randomNumber = random.nextInt(rows * columns);
        bool hasBomb = false;
        if (randomNumber < (rows * columns)/5) {
          hasBomb = true;
        }
        return Square(hasBomb: hasBomb);
      });
    });

    for (int row = 0; row < rows; row++) {
      for (int column = 0; column < columns; column++) {
        board[row][column].numberOfBombs = _calculateNumberOfBombs(row, column);
      }
    }
  }

  int _calculateNumberOfBombs(int row, int column) {
    int numberOfBombs = 0;
    if (row > 0 && column > 0) {
      if (board[row - 1][column - 1].hasBomb) {
        numberOfBombs++;
      }
    }

    if (row > 0) {
      if (board[row - 1][column].hasBomb) {
        numberOfBombs++;
      }
    }

    if (row > 0 && column < columns - 1) {
      if (board[row - 1][column + 1].hasBomb) {
        numberOfBombs++;
      }
    }

    if (column > 0) {
      if (board[row][column - 1].hasBomb) {
        numberOfBombs++;
      }
    }

    if (column < columns - 1) {
      if (board[row][column + 1].hasBomb) {
        numberOfBombs++;
      }
    }

    if (row < rows - 1 && column > 0) {
      if (board[row + 1][column - 1].hasBomb) {
        numberOfBombs++;
      }
    }

    if (row < rows - 1) {
      if (board[row + 1][column].hasBomb) {
        numberOfBombs++;
      }
    }

    if (row < rows - 1 && column < columns - 1) {
      if (board[row + 1][column + 1].hasBomb) {
        numberOfBombs++;
      }
    }

    return numberOfBombs;
  }
}