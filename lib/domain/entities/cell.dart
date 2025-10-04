import 'package:equatable/equatable.dart';

class Cell extends Equatable {
  final int row;
  final int column;
  final bool hasMine;
  final bool isRevealed;
  final bool isFlagged;
  final int neighborMines;
  final bool wrongFlag;
  final bool exploded;

  const Cell({
    required this.row,
    required this.column,
    this.hasMine = false,
    this.isRevealed = false,
    this.isFlagged = false,
    this.neighborMines = 0,
    this.wrongFlag = false,
    this.exploded = false,
  });

  @override
  List<Object?> get props => [
    row,
    column,
    hasMine,
    isRevealed,
    isFlagged,
    neighborMines,
    wrongFlag,
    exploded,
  ];

  @override
  bool get stringify => true;

  Cell copyWith({
    bool? hasMine,
    bool? isRevealed,
    bool? isFlagged,
    int? neighborMines,
    bool? wrongFlag,
    bool? exploded,
  }) {
    return Cell(
      row: row,
      column: column,
      hasMine: hasMine ?? this.hasMine,
      isRevealed: isRevealed ?? this.isRevealed,
      isFlagged: isFlagged ?? this.isFlagged,
      neighborMines: neighborMines ?? this.neighborMines,
      wrongFlag: wrongFlag ?? this.wrongFlag,
      exploded: exploded ?? this.exploded,
    );
  }
}
