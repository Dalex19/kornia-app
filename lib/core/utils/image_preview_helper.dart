import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

abstract final class ImagePreviewHelper {
  /// Opens an enlarged, dismissible preview of an image with Hero transition,
  /// interactive pinch-to-zoom, dark backdrop, and outside-tap to close.
  static void show({
    required BuildContext context,
    required String heroTag,
    required Widget imageWidget,
    BorderRadius? borderRadius,
    double maxWidth = 380,
    double maxHeight = 380,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierLabel: 'Cerrar vista previa',
        barrierColor: Colors.black.withValues(alpha: 0.85),
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (dialogContext, animation, secondaryAnimation) {
          final effectiveRadius = borderRadius ?? BorderRadius.circular(32);

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(dialogContext).pop(),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Center(
                    child: GestureDetector(
                      // Evita cerrar al interactuar o tocar directamente la imagen
                      onTap: () {},
                      child: Hero(
                        tag: heroTag,
                        child: Container(
                          width: MediaQuery.of(dialogContext).size.width * 0.85,
                          height: MediaQuery.of(dialogContext).size.width * 0.85,
                          constraints: BoxConstraints(
                            maxWidth: maxWidth,
                            maxHeight: maxHeight,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: AppColors.cardSurface,
                            borderRadius: effectiveRadius,
                            border: Border.all(
                              color: AppColors.bronzeGold.withValues(alpha: 0.8),
                              width: 2.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.antiqueBronze.withValues(alpha: 0.45),
                                blurRadius: 32,
                                spreadRadius: 4,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: effectiveRadius,
                            child: InteractiveViewer(
                              minScale: 1.0,
                              maxScale: 3.5,
                              child: imageWidget,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(dialogContext).padding.top + 16,
                    right: 20,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.sandLight,
                        size: 28,
                      ),
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      tooltip: 'Cerrar',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}
