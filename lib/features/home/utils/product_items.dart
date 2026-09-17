enum ProductBadgeType {
  available,
  customOrder,
  lastPiece,
}

class ProductBadge {
  final String text;
  final ProductBadgeType type;

  const ProductBadge({
    required this.text,
    required this.type,
  });
}

class ProductCardItem {
  final String id;
  final String category;
  final String title;
  final String materials;
  final String priceFormatted;
  final String imageUrl;
  final ProductBadge badge;
  final bool isFavorite;
  final List<String> thumbnails;
  final String description;
  final String dimensions;
  final String weight;
  final String origin;
  final String artisanName;
  final String craftingTime;
  final List<String> gallery;

  const ProductCardItem({
    required this.id,
    required this.category,
    required this.title,
    required this.materials,
    required this.priceFormatted,
    required this.imageUrl,
    required this.badge,
    this.isFavorite = false,
    this.thumbnails = const [],
    this.description =
        'Pieza única elaborada artesanalmente combinando cuerno natural seleccionado, tallado a mano con técnicas tradicionales y acabados en materiales nobles.',
    this.dimensions = '42 cm x 14 cm',
    this.weight = '780 g',
    this.origin = 'Taller Maestro Kornia, México',
    this.artisanName = 'Maestro Valerio & Co.',
    this.craftingTime = '38 horas de trabajo manual',
    this.gallery = const [],
  });
}

const List<ProductCardItem> mockProductItems = [
  ProductCardItem(
    id: 'item_1',
    category: 'ASTA CEBÚ',
    title: 'Cuerno Tribal',
    materials: 'Hueso pulido & Lino',
    priceFormatted: '\$320 USD',
    imageUrl:
        'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&w=600&q=80',
    badge: ProductBadge(
      text: 'Disponible (1)',
      type: ProductBadgeType.available,
    ),
    description:
        'Cuerno de cebú pulido a espejo con patrones geométricos grabados a mano mediante pirograbado ancestral. Base entrelazada con lino crudo y cuero curtido vegetal.',
    dimensions: '45 cm x 12 cm',
    weight: '820 g',
    origin: 'Oaxaca, México',
    artisanName: 'Maestro Valerio',
    craftingTime: '42 horas',
    gallery: [
      'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1590736969955-71cc94801759?auto=format&fit=crop&w=800&q=80',
    ],
  ),
  ProductCardItem(
    id: 'item_2',
    category: 'MONTURA MURAL',
    title: 'Mural Chamán',
    materials: 'Pirograbado & Gemas',
    priceFormatted: '\$650 USD',
    imageUrl:
        'https://images.unsplash.com/photo-1590736969955-71cc94801759?auto=format&fit=crop&w=600&q=80',
    badge: ProductBadge(
      text: 'Por encargo (15d)',
      type: ProductBadgeType.customOrder,
    ),
    thumbnails: [
      'https://images.unsplash.com/photo-1590736969955-71cc94801759?auto=format&fit=crop&w=150&q=80',
      'https://images.unsplash.com/photo-1606760227091-3dd870d97f1d?auto=format&fit=crop&w=150&q=80',
    ],
    description:
        'Espectacular montura mural con doble cornamenta simétrica, engaste de turquesas naturales del desierto y flecos de cuero de vaca teñidos a mano con corteza de roble.',
    dimensions: '75 cm x 40 cm',
    weight: '2.4 kg',
    origin: 'Sonora, México',
    artisanName: 'Taller Kornia & Hermanos Luna',
    craftingTime: '65 horas',
    gallery: [
      'https://images.unsplash.com/photo-1590736969955-71cc94801759?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1606760227091-3dd870d97f1d?auto=format&fit=crop&w=800&q=80',
    ],
  ),
  ProductCardItem(
    id: 'item_3',
    category: 'EDICIÓN DORADA',
    title: 'Sol Azteca',
    materials: 'Oro 24k & Cuero',
    priceFormatted: '\$480 USD',
    imageUrl:
        'https://images.unsplash.com/photo-1606760227091-3dd870d97f1d?auto=format&fit=crop&w=600&q=80',
    badge: ProductBadge(
      text: 'Última pieza',
      type: ProductBadgeType.lastPiece,
    ),
    description:
        'Pieza de colección imperial con lámina de latón bañada en oro de 24 quilates cincelada con la iconografía del dios solar Tonatiuh. Guarda de cuero cosida a mano con hilo encerado.',
    dimensions: '38 cm x 11 cm',
    weight: '950 g',
    origin: 'Puebla, México',
    artisanName: 'Orfebre D. Mendoza',
    craftingTime: '50 horas',
    gallery: [
      'https://images.unsplash.com/photo-1606760227091-3dd870d97f1d?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&w=800&q=80',
    ],
  ),
  ProductCardItem(
    id: 'item_4',
    category: 'CEREMONIAL',
    title: 'Águila Real',
    materials: 'Acabado ahumado',
    priceFormatted: '\$390 USD',
    imageUrl:
        'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&w=600&q=80',
    badge: ProductBadge(
      text: 'Disponible',
      type: ProductBadgeType.available,
    ),
    description:
        'Cuerno negro ahumado con madera de mezquite y grabado en bajo relieve que retrata el vuelo del águila sobre la cordillera. Base de nogal macizo tratada con cera de abejas.',
    dimensions: '48 cm x 15 cm',
    weight: '1.1 kg',
    origin: 'Zacatecas, México',
    artisanName: 'Maestro Emiliano S.',
    craftingTime: '36 horas',
    gallery: [
      'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&w=800&q=80',
    ],
  ),
  ProductCardItem(
    id: 'item_5',
    category: 'ALTA ORFEBRERÍA',
    title: 'Jaguar Sagrado',
    materials: 'Plata 925 & Jade',
    priceFormatted: '\$540 USD',
    imageUrl:
        'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?auto=format&fit=crop&w=600&q=80',
    badge: ProductBadge(
      text: 'Disponible (2)',
      type: ProductBadgeType.available,
    ),
    description:
        'Asta clara con incrustaciones de plata ley 925 fundida a la cera perdida y ojos de jade verde imperial pulido. Símbolo de fuerza y protección espiritual.',
    dimensions: '40 cm x 13 cm',
    weight: '890 g',
    origin: 'Taxco, Guerrero',
    artisanName: 'Taller de Platería Kornia',
    craftingTime: '48 horas',
    gallery: [
      'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?auto=format&fit=crop&w=800&q=80',
    ],
  ),
  ProductCardItem(
    id: 'item_6',
    category: 'TALLER MAESTRO',
    title: 'Viento del Norte',
    materials: 'Cuero repujado & Obsidiana',
    priceFormatted: '\$410 USD',
    imageUrl:
        'https://images.unsplash.com/photo-1533158307587-828f0a76ef96?auto=format&fit=crop&w=600&q=80',
    badge: ProductBadge(
      text: 'Por encargo (7d)',
      type: ProductBadgeType.customOrder,
    ),
    isFavorite: true,
    description:
        'Cuerno con remates de cuero curtido al roble repujado a mano con motivos nórdicos-mesoamericanos y punta coronada en punta de flecha de obsidiana negra pura.',
    dimensions: '44 cm x 14 cm',
    weight: '920 g',
    origin: 'Hidalgo, México',
    artisanName: 'Maestro Valerio',
    craftingTime: '32 horas',
    gallery: [
      'https://images.unsplash.com/photo-1533158307587-828f0a76ef96?auto=format&fit=crop&w=800&q=80',
    ],
  ),
];
