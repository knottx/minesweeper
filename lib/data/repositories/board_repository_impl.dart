import 'dart:math';

import 'package:minesweeper/domain/entities/cell.dart';
import 'package:minesweeper/domain/enums/level.dart';
import 'package:minesweeper/domain/repositories/board_repository.dart';

class BoardRepositoryImpl implements BoardRepository {
  @override
  List<Cell> newPlayingBoard({
    required Level level,
    required Cell safeCell,
  }) {
    final List<Cell> newBoard = level.emptyBoard;

    final random = Random();
    int minesPlaced = 0;

    while (minesPlaced < level.mines) {
      final row = random.nextInt(level.rows);
      final column = random.nextInt(level.columns);

      if (row == safeCell.row && column == safeCell.column) continue;

      final index = row * level.columns + column;
      if (newBoard[index].hasMine) continue;
      newBoard[index] = newBoard[index].copyWith(hasMine: true);
      minesPlaced++;
    }

    for (int row = 0; row < level.rows; row++) {
      for (int column = 0; column < level.columns; column++) {
        final index = row * level.columns + column;
        if (newBoard[index].hasMine) continue;

        int neighborMines = 0;
        for (int dr = -1; dr <= 1; dr++) {
          for (int dc = -1; dc <= 1; dc++) {
            if (dr == 0 && dc == 0) continue;
            final targetRow = row + dr;
            final targetColumn = column + dc;
            if (targetRow >= 0 &&
                targetRow < level.rows &&
                targetColumn >= 0 &&
                targetColumn < level.columns) {
              final neighborIndex = targetRow * level.columns + targetColumn;
              if (newBoard[neighborIndex].hasMine) {
                neighborMines++;
              }
            }
          }
        }
        newBoard[index] = newBoard[index].copyWith(
          neighborMines: neighborMines,
        );
      }
    }

    return newBoard;
  }
}
