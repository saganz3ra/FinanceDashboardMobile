import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class AppButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? color;
  final String? semanticsLabel;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.color,
    this.semanticsLabel,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final buttonColor = widget.color ?? AppColors.primary;
    final hoverColor = buttonColor.withValues(alpha: 0.85);
    return Semantics(
      button: true,
      label: widget.semanticsLabel ?? widget.label,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          splashColor: buttonColor.withValues(alpha: 0.2),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            decoration: BoxDecoration(
              color: _hovering ? hoverColor : buttonColor,
              borderRadius: BorderRadius.circular(AppSizes.borderRadius),
              boxShadow: _hovering
                  ? [
                      BoxShadow(
                        color: buttonColor.withValues(alpha: 0.25),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMedium,
              vertical: AppSizes.paddingSmall,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null)
                  Icon(
                    widget.icon,
                    color: Colors.white,
                    size: AppSizes.iconSize,
                  ),
                if (widget.icon != null) const SizedBox(width: 8),
                Text(
                  widget.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
