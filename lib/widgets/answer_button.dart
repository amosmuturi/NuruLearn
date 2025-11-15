import 'package:flutter/material.dart';

class AnswerButton extends StatefulWidget {
  final String answerText;
  final bool isCorrect;
  final bool isLocked;
  final VoidCallback onTap;
  final bool isSelected;
  final bool showCorrect;

  const AnswerButton({
    super.key,
    required this.answerText,
    required this.isCorrect,
    required this.isLocked,
    required this.onTap,
    required this.isSelected,
    required this.showCorrect,
  });

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.15), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.15, end: 1.0), weight: 50),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
  }

  @override
  void didUpdateWidget(covariant AnswerButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Animate green (correct) button with bounce if locked
    if (widget.showCorrect && widget.isCorrect) {
      _controller.forward(from: 0.0);
    } else {
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getColor() {
    if (!widget.showCorrect) return Colors.grey.shade600; // static grey
    if (widget.isCorrect) return Colors.green;             // correct
    if (widget.isSelected && !widget.isCorrect) return Colors.red; // wrong
    return Colors.grey.shade600;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        // Only bounce the green (correct) button
        final scale = (widget.isCorrect && widget.showCorrect) ? _scaleAnimation.value : 1.0;

        return Transform.scale(
          scale: scale,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: _getColor(),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: widget.isLocked ? null : widget.onTap,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                  alignment: Alignment.center,
                  child: Text(
                    widget.answerText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}