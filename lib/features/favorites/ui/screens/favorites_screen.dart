import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/ui/widget/product_card.dart';
import '../../../home/utils/product_items.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late List<ProductCardItem> _favoriteItems;

  @override
  void initState() {
    super.initState();
    _favoriteItems = mockProductItems.where((item) => item.isFavorite).toList();
    // If none are marked initially, show at least the featured favorite
    if (_favoriteItems.isEmpty && mockProductItems.isNotEmpty) {
      _favoriteItems = [mockProductItems.last];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Favoritos',
          style: TextStyle(
            color: AppColors.sandLight,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            fontFamily: 'serif',
          ),
        ),
      ),
      body: SafeArea(
        child: _favoriteItems.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.cardSurface,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.bronzeGold.withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Icon(
                        Icons.favorite_border_rounded,
                        size: 48,
                        color: AppColors.sandMuted,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'No tienes piezas guardadas',
                      style: TextStyle(
                        color: AppColors.sandLight,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'serif',
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Explora el catálogo y guarda tus piezas favoritas.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.sandMuted,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_favoriteItems.length} ${_favoriteItems.length == 1 ? "PIEZA GUARDADA" : "PIEZAS GUARDADAS"}',
                      style: const TextStyle(
                        color: AppColors.bronzeGold,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _favoriteItems.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.57,
                      ),
                      itemBuilder: (context, index) {
                        final item = _favoriteItems[index];
                        final heroTag = 'fav_product_image_${item.id}';
                        return ProductCard(
                          item: item,
                          heroTag: heroTag,
                          onTap: () {
                            context.push(
                              RouteNames.productDetailPath(item.id),
                              extra: <String, dynamic>{
                                'item': item,
                                'heroTag': heroTag,
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
