import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kornia/features/gospel/di/gospel_providers.dart';
import 'package:kornia/features/gospel/domain/gospel_entity.dart';

class GospelNotifier extends AsyncNotifier<GospelEntity> {
  @override
  FutureOr<GospelEntity> build() async {
    return await ref.watch(gospelUsecaseProvider).call(DateTime.now());
  }
}

final gospelNotifierProvider =
    AsyncNotifierProvider.autoDispose<GospelNotifier, GospelEntity>(
      GospelNotifier.new,
    );
