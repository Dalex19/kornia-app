import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kornia/features/home/domain/entities/photo_entity.dart';
import 'package:kornia/features/home/presentation/providers/photo_provider.dart';

class PhotoNotifier extends AsyncNotifier<List<PhotoEntity>> {

  @override
  FutureOr<List<PhotoEntity>> build() async {
   return await ref.watch(photoUsecaseProvider).call();
  }
}

final photoNotifierProvider = AsyncNotifierProvider.autoDispose<PhotoNotifier, List<PhotoEntity>>(PhotoNotifier.new);