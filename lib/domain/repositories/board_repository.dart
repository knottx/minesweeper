import 'package:minesweeper/domain/entities/cell.dart';
import 'package:minesweeper/domain/enums/level.dart';

abstract class BoardRepository {
  List<Cell> newPlayingBoard({
    required Level level,
    required Cell safeCell,
  });
}
