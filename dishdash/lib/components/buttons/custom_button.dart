import 'package:flutter/material.dart';
import '../../styles/app_colors.dart';

enum ButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
}

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final double? height;
  final double? fontSize;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.height = 48.0,
    this.fontSize = 15.0,
  });

  @override
  Widget build(BuildContext context) {
    Widget childContent = isLoading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: fontSize! + 3),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );

    BoxDecoration decoration;
    Color textColor;

    switch (variant) {
      case ButtonVariant.primary:
        decoration = BoxDecoration(
          color: onPressed == null ? Colors.grey.shade400 : AppColors.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: onPressed != null ? const [AppColors.primaryGlow] : null,
        );
        textColor = Colors.white;
        break;

      case ButtonVariant.secondary:
        decoration = BoxDecoration(
          color: onPressed == null ? Colors.grey.shade300 : AppColors.secondary,
          borderRadius: BorderRadius.circular(12),
        );
        textColor = Colors.white;
        break;

      case ButtonVariant.outline:
        decoration = BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: onPressed == null ? Colors.grey.shade300 : AppColors.primary,
            width: 1.5,
          ),
        );
        textColor = onPressed == null ? Colors.grey.shade400 : AppColors.primary;
        break;

      case ButtonVariant.ghost:
        decoration = BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        );
        textColor = onPressed == null ? Colors.grey.shade400 : AppColors.secondary;
        break;
    }

    Widget buttonWidget = InkWell(
      onTap: isLoading ? null : onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: decoration,
        alignment: Alignment.center,
        child: DefaultTextStyle(
          style: TextStyle(color: textColor),
          child: childContent,
        ),
      ),
    );

    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        child: buttonWidget,
      );
    }

    return buttonWidget;
  }
}
