import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class AppButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticsLabel ?? label,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        splashColor: (color ?? AppColors.primary).withOpacity(0.2),
        child: Container(
          decoration: BoxDecoration(
            color: color ?? AppColors.primary,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMedium,
            vertical: AppSizes.paddingSmall,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Icon(icon, color: Colors.white, size: AppSizes.iconSize),
              if (icon != null) const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
