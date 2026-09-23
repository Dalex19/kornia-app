import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/image_preview_helper.dart';
import '../widget/product_card.dart';
import '../../utils/product_items.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openEnlargedLogo(BuildContext context) {
    ImagePreviewHelper.show(
      context: context,
      heroTag: 'app_logo_hero',
      imageWidget: Image.asset('assets/images/logo.jpg', fit: BoxFit.cover),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),

              // 1. Logo Container (Clickeable con animación Hero para ver en grande)
              GestureDetector(
                onTap: () => _openEnlargedLogo(context),
                child: Hero(
                  tag: 'app_logo_hero',
                  child: Container(
                    width: 96,
                    height: 96,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColors.cardSurface,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppColors.bronzeGold.withValues(alpha: 0.6),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.antiqueBronze.withValues(alpha: 0.2),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/logo.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // 2. App Name
              const Text(
                'Kornia',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  color: AppColors.sandLight,
                ),
              ),
              const SizedBox(height: 20),

              // 3. Stats Row (48 Piezas | 12K Follow)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Piezas Column
                  const Column(
                    children: [
                      Text(
                        '48',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.sandLight,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Piezas',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.sandMuted,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    height: 28,
                    width: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    color: AppColors.cardSurface,
                  ),

                  // Follow Column
                  const Column(
                    children: [
                      Text(
                        '12K',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.sandLight,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Follow',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.sandMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // 4. Badges / Categories Row with distinctive color for 'Taller maestro'
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 6,
                children: [
                  const Text(
                    'Cuero artesanal',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      color: AppColors.sandMuted,
                    ),
                  ),
                  Text(
                    '•',
                    style: TextStyle(
                      color: AppColors.bronzeGold.withValues(alpha: 0.6),
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    'Alta Orfebrería',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      color: AppColors.sandMuted,
                    ),
                  ),
                  Text(
                    '•',
                    style: TextStyle(
                      color: AppColors.bronzeGold.withValues(alpha: 0.6),
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    'Taller maestro',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.terracotta,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // 5. Description
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Cada pieza es un mundo único. Cuernos bovinos decorados a mano con técnicas ancestrales y materiales naturales.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.5,
                    height: 1.55,
                    color: AppColors.sandMuted,
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // Grid de Productos / Piezas Dinámico
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: mockProductItems.length,
                gridDelegate: SliverQuiltedGridDelegate(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  repeatPattern: QuiltedGridRepeatPattern.inverted,
                  pattern: [
                    QuiltedGridTile(2, 1),
                    QuiltedGridTile(1, 1),
                    QuiltedGridTile(1, 1),
                    QuiltedGridTile(1, 2),
                  ],
                ),
                itemBuilder: (context, index) {
                  final item = mockProductItems[index];
                  final heroTag = 'home_product_image_${item.id}';
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
