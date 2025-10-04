import 'package:flutter/foundation.dart';
import 'package:minesweeper/domain/entities/cell.dart';

enum Level {
  beginner,
  intermediate,
  expert;

  double get cellSize {
    switch (this) {
      case Level.beginner:
        return 36;
      case Level.intermediate:
      case Level.expert:
        return 32;
    }
  }

  int get rows {
    switch (this) {
      case Level.beginner:
        return 9;
      case Level.intermediate:
        return 16;
      case Level.expert:
        return 16;
    }
  }

  int get columns {
    switch (this) {
      case Level.beginner:
        return 9;
      case Level.intermediate:
        return 16;
      case Level.expert:
        return 30;
    }
  }

  List<Cell> get emptyBoard {
    final List<Cell> board = [];
    for (int row = 0; row < rows; row++) {
      for (int column = 0; column < columns; column++) {
        board.add(Cell(row: row, column: column));
      }
    }
    return board;
  }

  int get mines {
    if (kDebugMode) return 5;
    switch (this) {
      case Level.beginner:
        return 10;
      case Level.intermediate:
        return 40;
      case Level.expert:
        return 99;
    }
  }
}
