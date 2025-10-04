import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper/domain/entities/cell.dart';
import 'package:minesweeper/domain/enums/level.dart';
import 'package:minesweeper/domain/repositories/board_repository.dart';
import 'package:minesweeper/presentation/home/cubit/home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final BoardRepository boardRepository;

  HomeScreenCubit({
    required this.boardRepository,
  }) : super(const HomeScreenState());

  void ready({Level? level}) {
    emit(state.ready(level: level));
  }

  void addOneSecond() {
    if (state.seconds >= 999) return;
    emit(state.copyWith(seconds: state.seconds + 1));
  }

  void onFlagToggled(Cell cell) {
    final board = List<Cell>.from(state.board);
    final index = cell.row * state.level.columns + cell.column;
    if (cell.isRevealed) return;
    board[index] = cell.copyWith(
      isFlagged: !cell.isFlagged,
    );
    final flagsLeft = cell.isFlagged
        ? state.flagsLeft + 1
        : state.flagsLeft - 1;
    emit(
      state.copyWith(
        board: board,
        flagsLeft: flagsLeft,
      ),
    );
  }

  void onRevealCell(Cell cell) {
    List<Cell> board = List<Cell>.from(state.board);
    Cell targetCell = cell;

    if (state.status != HomeScreenStatus.playing) {
      final newBoard = boardRepository.newPlayingBoard(
        level: state.level,
        safeCell: targetCell,
      );
      for (int i = 0; i < board.length; i++) {
        if (board[i].isFlagged) {
          newBoard[i] = newBoard[i].copyWith(isFlagged: true);
        }
      }
      board = newBoard;
      targetCell = board[cell.row * state.level.columns + cell.column];
    }

    board = _revealCell(cell: targetCell, board: board);
    if (board.map((e) => e.exploded).contains(true)) {
      emit(state.gameOver(board: _revealAllMines(board)));
    } else if (board
        .where((cell) => !cell.hasMine)
        .every((cell) => cell.isRevealed)) {
      emit(
        state.victory(board: _flagAllMines(board)),
      );
    } else {
      emit(state.playing(board: board));
    }
  }

  List<Cell> _revealCell({
    required Cell cell,
    required List<Cell> board,
  }) {
    List<Cell> newBoard = List<Cell>.from(board);
    if (cell.isRevealed || cell.isFlagged) return newBoard;

    final index = cell.row * state.level.columns + cell.column;
    newBoard[index] = cell.copyWith(
      isRevealed: true,
      exploded: cell.hasMine,
    );

    if (cell.hasMine) {
      return newBoard;
    }

    if (cell.neighborMines == 0) {
      for (int dr = -1; dr <= 1; dr++) {
        for (int dc = -1; dc <= 1; dc++) {
          if (dr == 0 && dc == 0) continue;
          final targetRow = cell.row + dr;
          final targetColumn = cell.column + dc;
          if (targetRow >= 0 &&
              targetRow < state.level.rows &&
              targetColumn >= 0 &&
              targetColumn < state.level.columns) {
            final neighborIndex =
                targetRow * state.level.columns + targetColumn;
            final targetCell = newBoard[neighborIndex];
            if (targetCell.hasMine || targetCell.isFlagged) continue;
            newBoard = _revealCell(
              cell: newBoard[neighborIndex],
              board: newBoard,
            );
          }
        }
      }
    }

    return newBoard;
  }

  List<Cell> _revealAllMines(List<Cell> board) {
    final newBoard = List<Cell>.from(board);
    for (int i = 0; i < newBoard.length; i++) {
      final cell = newBoard[i];
      if (cell.isFlagged) {
        newBoard[i] = cell.copyWith(
          wrongFlag: !cell.hasMine,
        );
      } else if (cell.hasMine) {
        newBoard[i] = cell.copyWith(
          isRevealed: true,
        );
      }
    }
    return newBoard;
  }

  List<Cell> _flagAllMines(List<Cell> board) {
    final newBoard = List<Cell>.from(board);
    for (int i = 0; i < newBoard.length; i++) {
      final cell = newBoard[i];
      if (cell.hasMine) {
        newBoard[i] = cell.copyWith(
          isFlagged: true,
        );
      }
    }
    return newBoard;
  }
}
