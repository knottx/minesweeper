import 'package:equatable/equatable.dart';
import 'package:minesweeper/domain/entities/cell.dart';
import 'package:minesweeper/domain/enums/level.dart';

enum HomeScreenStatus {
  initial,
  ready,
  playing,
  gameOver,
  victory,
}

class HomeScreenState extends Equatable {
  final HomeScreenStatus status;
  final Level level;
  final int flagsLeft;
  final int seconds;
  final List<Cell> board;

  const HomeScreenState({
    this.status = HomeScreenStatus.initial,
    this.level = Level.beginner,
    this.flagsLeft = 10,
    this.seconds = 0,
    this.board = const [],
  });

  @override
  List<Object?> get props => [
    status,
    level,
    flagsLeft,
    seconds,
    board,
  ];

  HomeScreenState copyWith({
    HomeScreenStatus? status,
    Level? level,
    int? flagsLeft,
    int? seconds,
    List<Cell>? board,
  }) {
    return HomeScreenState(
      status: status ?? this.status,
      level: level ?? this.level,
      flagsLeft: flagsLeft ?? this.flagsLeft,
      seconds: seconds ?? this.seconds,
      board: board ?? this.board,
    );
  }

  HomeScreenState ready({
    Level? level,
  }) {
    final newLevel = level ?? this.level;
    return copyWith(
      status: HomeScreenStatus.ready,
      level: newLevel,
      flagsLeft: newLevel.mines,
      seconds: 0,
      board: newLevel.emptyBoard,
    );
  }

  HomeScreenState playing({
    required List<Cell> board,
  }) {
    return copyWith(
      status: HomeScreenStatus.playing,
      board: board,
    );
  }

  HomeScreenState gameOver({
    required List<Cell> board,
  }) {
    return copyWith(
      status: HomeScreenStatus.gameOver,
      board: board,
    );
  }

  HomeScreenState victory({
    required List<Cell> board,
  }) {
    return copyWith(
      status: HomeScreenStatus.victory,
      board: board,
      flagsLeft: 0,
    );
  }
}
