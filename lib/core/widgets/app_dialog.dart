import 'package:flutter/material.dart';
import 'package:kornia/core/theme/app_colors.dart';

abstract final class AppDialog {
  /// Muestra un diálogo modular estilizado con el diseño de la app.
  /// Retorna `true` si el usuario confirma, `false` si cancela o cierra.
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Aceptar',
    String? cancelText,
    Color? confirmTextColor,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.sandLight,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(color: AppColors.sandMuted),
        ),
        actions: [
          if (cancelText != null)
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                cancelText,
                style: const TextStyle(color: AppColors.sandMuted),
              ),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              confirmText,
              style: TextStyle(
                color: confirmTextColor ?? AppColors.bronzeGold,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
