import 'package:flutter/material.dart';
import 'package:minesweeper/domain/entities/cell.dart';
import 'package:minesweeper/presentation/extensions/build_context_extension.dart';

class CellTile extends StatefulWidget {
  final Cell cell;
  final void Function() onRevealed;
  final void Function() onFlagToggled;

  const CellTile({
    super.key,
    required this.cell,

    required this.onRevealed,
    required this.onFlagToggled,
  });

  @override
  State<CellTile> createState() => _CellTileState();
}

class _CellTileState extends State<CellTile> {
  Cell get cell => widget.cell;

  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    if (cell.isRevealed) {
      return _revealedCell(context);
    } else if (cell.isFlagged) {
      return _flagCell(context);
    } else {
      return _unrevealedCell(context);
    }
  }

  Widget _revealedCell(BuildContext context) {
    Widget? child;
    Color color = context.appColors.background;
    if (cell.hasMine) {
      color = cell.exploded
          ? context.appColors.negative
          : context.appColors.background;
      child = const Text(
        '💣',
        style: TextStyle(fontSize: 20),
      );
    } else if (cell.neighborMines > 0) {
      child = Text(
        cell.neighborMines.toString(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: _getNumberColor(context, cell.neighborMines),
          fontSize: 24,
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: context.appColors.borderShadow,
          width: 0.5,
        ),
      ),
      child: Center(child: child),
    );
  }

  Widget _flagCell(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        widget.onFlagToggled();
      },
      onSecondaryTap: () {
        widget.onFlagToggled();
      },
      child: Container(
        decoration: BoxDecoration(
          color: cell.wrongFlag
              ? context.appColors.negative.withValues(alpha: 0.4)
              : context.appColors.background,
          border: Border(
            top: BorderSide(
              color: context.appColors.borderHighlight,
              width: 3,
            ),
            left: BorderSide(
              color: context.appColors.borderHighlight,
              width: 3,
            ),
            right: BorderSide(
              color: context.appColors.borderShadow,
              width: 3,
            ),
            bottom: BorderSide(
              color: context.appColors.borderShadow,
              width: 3,
            ),
          ),
        ),
        child: const Center(
          child: Text(
            '🚩',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget _unrevealedCell(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onRevealed();
      },
      onLongPress: () {
        widget.onFlagToggled();
      },
      onSecondaryTap: () {
        widget.onFlagToggled();
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.appColors.background,
          border: _pressed
              ? Border(
                  top: BorderSide(
                    color: context.appColors.borderShadow,
                    width: 3,
                  ),
                  left: BorderSide(
                    color: context.appColors.borderShadow,
                    width: 3,
                  ),
                  right: BorderSide(
                    color: context.appColors.borderHighlight,
                    width: 3,
                  ),
                  bottom: BorderSide(
                    color: context.appColors.borderHighlight,
                    width: 3,
                  ),
                )
              : Border(
                  top: BorderSide(
                    color: context.appColors.borderHighlight,
                    width: 3,
                  ),
                  left: BorderSide(
                    color: context.appColors.borderHighlight,
                    width: 3,
                  ),
                  right: BorderSide(
                    color: context.appColors.borderShadow,
                    width: 3,
                  ),
                  bottom: BorderSide(
                    color: context.appColors.borderShadow,
                    width: 3,
                  ),
                ),
        ),
      ),
    );
  }

  Color _getNumberColor(BuildContext context, int number) {
    switch (number) {
      case 1:
        return context.appColors.colorOne;
      case 2:
        return context.appColors.colorTwo;
      case 3:
        return context.appColors.colorThree;
      case 4:
        return context.appColors.colorFour;
      case 5:
        return context.appColors.colorFive;
      case 6:
        return context.appColors.colorSix;
      case 7:
        return context.appColors.colorSeven;
      case 8:
        return context.appColors.colorEight;
      default:
        return Colors.transparent;
    }
  }
}
