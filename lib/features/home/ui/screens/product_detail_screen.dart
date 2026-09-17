import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/image_preview_helper.dart';
import '../../utils/product_items.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductCardItem item;
  final String? heroTag;

  const ProductDetailScreen({
    super.key,
    required this.item,
    this.heroTag,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late bool _isFavorite;
  int _selectedImageIndex = 0;
  late final List<String> _allImages;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.item.isFavorite;
    _allImages = [
      widget.item.imageUrl,
      ...widget.item.gallery,
    ];
  }

  Widget _buildBadge(ProductBadge badge) {
    switch (badge.type) {
      case ProductBadgeType.available:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F4EE).withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: Color(0xFFC76D2A),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                badge.text,
                style: const TextStyle(
                  color: Color(0xFF332B25),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );

      case ProductBadgeType.customOrder:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFF2C241E).withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.schedule_rounded,
                size: 14,
                color: Color(0xFFE5DACD),
              ),
              const SizedBox(width: 5),
              Text(
                badge.text,
                style: const TextStyle(
                  color: Color(0xFFF5EFE6),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );

      case ProductBadgeType.lastPiece:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFB54D24),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFB54D24).withValues(alpha: 0.35),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.local_fire_department_rounded,
                size: 15,
                color: Colors.white,
              ),
              const SizedBox(width: 4),
              Text(
                badge.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
    }
  }

  Widget _buildSpecCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.bronzeGold.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.bronzeGold,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.sandMuted,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: AppColors.sandLight,
            ),
          ),
        ],
      ),
    );
  }

  void _openEnlargedImage(BuildContext context, String imageUrl, String heroTag) {
    ImagePreviewHelper.show(
      context: context,
      heroTag: heroTag,
      imageWidget: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Image.asset(
          'assets/images/logo.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentImage = _allImages[_selectedImageIndex];
    final String effectiveHeroTag =
        widget.heroTag ?? 'product_image_${widget.item.id}';

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          // Scrollable content
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Immersive App Bar with Image
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    // Main Image with Hero Transition and Tap-to-Enlarge
                    GestureDetector(
                      onTap: () => _openEnlargedImage(
                        context,
                        currentImage,
                        effectiveHeroTag,
                      ),
                      child: Hero(
                        tag: effectiveHeroTag,
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Container(
                            color: AppColors.cardSurface,
                            child: Image.network(
                              currentImage,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => Image.asset(
                                'assets/images/logo.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Gradient fade at bottom of image
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              AppColors.darkBackground,
                              AppColors.darkBackground.withValues(alpha: 0.0),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Badge top-left (below safe area)
                    Positioned(
                      left: 20,
                      bottom: 24,
                      child: _buildBadge(widget.item.badge),
                    ),

                    // Thumbnails list if multiple images
                    if (_allImages.length > 1)
                      Positioned(
                        right: 20,
                        bottom: 20,
                        child: Row(
                          children: List.generate(_allImages.length, (index) {
                            final isSelected = _selectedImageIndex == index;
                            return GestureDetector(
                              onTap: () {
                                if (_selectedImageIndex == index) {
                                  _openEnlargedImage(
                                    context,
                                    _allImages[index],
                                    'product_image_${widget.item.id}',
                                  );
                                } else {
                                  setState(() {
                                    _selectedImageIndex = index;
                                  });
                                }
                              },
                              child: Container(
                                width: 36,
                                height: 36,
                                margin: const EdgeInsets.only(left: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.bronzeGold
                                        : Colors.white.withValues(alpha: 0.4),
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Image.network(
                                  _allImages[index],
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => const SizedBox(),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                  ],
                ),
              ),

              // Details Content
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Category & Collection
                    Text(
                      widget.item.category.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: AppColors.bronzeGold,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Title
                    Text(
                      widget.item.title,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'serif',
                        color: AppColors.sandLight,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Materials
                    Text(
                      widget.item.materials,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.sandMuted,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Price Tag
                    Row(
                      children: [
                        Text(
                          widget.item.priceFormatted,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'serif',
                            color: AppColors.brightGold,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.cardSurface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.bronzeGold.withValues(alpha: 0.3),
                            ),
                          ),
                          child: const Text(
                            'IVA incluido',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.sandMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Divider
                    Container(
                      height: 1,
                      color: AppColors.cardSurface,
                    ),
                    const SizedBox(height: 24),

                    // Section: Descripción
                    const Text(
                      'Simbología y Creación',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'serif',
                        color: AppColors.sandLight,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.item.description,
                      style: const TextStyle(
                        fontSize: 14.5,
                        height: 1.6,
                        color: AppColors.sandMuted,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Section: Ficha Técnica
                    const Text(
                      'Ficha Técnica',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'serif',
                        color: AppColors.sandLight,
                      ),
                    ),
                    const SizedBox(height: 14),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.45,
                      children: [
                        _buildSpecCard(
                          icon: Icons.straighten_rounded,
                          label: 'Dimensiones',
                          value: widget.item.dimensions,
                        ),
                        _buildSpecCard(
                          icon: Icons.scale_rounded,
                          label: 'Peso Aproximado',
                          value: widget.item.weight,
                        ),
                        _buildSpecCard(
                          icon: Icons.place_outlined,
                          label: 'Lugar de Origen',
                          value: widget.item.origin,
                        ),
                        _buildSpecCard(
                          icon: Icons.access_time_rounded,
                          label: 'Tiempo de Taller',
                          value: widget.item.craftingTime,
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Artisan Guarantee Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.cardSurface,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: AppColors.antiqueBronze.withValues(alpha: 0.35),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.antiqueBronze.withValues(alpha: 0.25),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.bronzeGold,
                                width: 1.5,
                              ),
                            ),
                            child: const Icon(
                              Icons.verified_outlined,
                              color: AppColors.bronzeGold,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.item.artisanName,
                                  style: const TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.sandLight,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'Incluye certificado de autenticidad firmado',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.sandMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),

          // Floating Top Navigation Bar (Back, Favorite, Share)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button (supports gesture or tap)
                    GestureDetector(
                      onTap: () => Navigator.of(context).maybePop(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.cardSurface.withValues(alpha: 0.85),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.bronzeGold.withValues(alpha: 0.4),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.sandLight,
                          size: 18,
                        ),
                      ),
                    ),

                    // Actions (Favorite & Share)
                    Row(
                      children: [
                        // Favorite toggle
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isFavorite = !_isFavorite;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.cardSurface.withValues(alpha: 0.85),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.bronzeGold.withValues(alpha: 0.4),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              _isFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              color: _isFavorite
                                  ? const Color(0xFFB54D24)
                                  : AppColors.sandLight,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Fixed Purchase / Request Action Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
              decoration: BoxDecoration(
                color: AppColors.darkSurface.withValues(alpha: 0.96),
                border: Border(
                  top: BorderSide(
                    color: AppColors.bronzeGold.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.sandMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.item.priceFormatted,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'serif',
                          color: AppColors.sandLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.bronzeGold,
                            AppColors.antiqueBronze,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.antiqueBronze.withValues(alpha: 0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.cardSurface,
                              content: Text(
                                'Solicitud enviada para "${widget.item.title}". Nos contactaremos contigo.',
                                style: const TextStyle(color: AppColors.sandLight),
                              ),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.lock_outline_rounded,
                              size: 18,
                              color: AppColors.darkBackground,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Adquirir Pieza',
                              style: TextStyle(
                                color: AppColors.darkBackground,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
