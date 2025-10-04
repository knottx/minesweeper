import 'package:flutter/material.dart';
import 'package:minesweeper/presentation/extensions/build_context_extension.dart';

class ResetButton extends StatefulWidget {
  final String emoji;
  final void Function() onPressed;

  const ResetButton({
    super.key,
    required this.onPressed,
    required this.emoji,
  });

  @override
  State<ResetButton> createState() => _ResetButtonState();
}

class _ResetButtonState extends State<ResetButton> {
  String get emoji => widget.emoji;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onPressed();
      },
      child: Container(
        width: 44,
        height: 44,
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
        child: Center(
          child: Text(
            emoji,
            style: TextStyle(
              fontSize: _pressed ? 22 : 24,
            ),
          ),
        ),
      ),
    );
  }
}
