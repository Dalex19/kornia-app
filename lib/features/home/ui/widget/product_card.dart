import 'package:flutter/material.dart';
import '../../utils/product_items.dart';

class ProductCard extends StatelessWidget {
  final ProductCardItem item;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final String? heroTag;
  final BorderRadius? borderRadius;
  final BoxFit fit;

  const ProductCard({
    super.key,
    required this.item,
    this.onTap,
    this.onFavoriteToggle,
    this.heroTag,
    this.borderRadius,
    this.fit = BoxFit.cover,
  });

  Widget _buildImage(String url) {
    return Image.network(
      url,
      fit: fit,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: const Color(0xFF2C241E),
          child: const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFFC76D2A),
              ),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: const Color(0xFF2C241E),
          child: Image.asset(
            'assets/images/logo.jpg',
            fit: fit,
            width: double.infinity,
            height: double.infinity,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String effectiveHeroTag =
        heroTag ?? 'product_image_${item.id}';
    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(20);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1915),
          borderRadius: effectiveBorderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Hero(
          tag: effectiveHeroTag,
          child: _buildImage(item.imageUrl),
        ),
      ),
    );
  }
}

