import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kornia/features/auth/di_auth.dart';
import 'package:kornia/features/auth/domain/entities/user_entity.dart';

final authNotifierProvider =
    AsyncNotifierProvider<AuthNotifier, void>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  //register login
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () =>
          ref.read(loginUsecaseProvider).call(email: email, password: password),
    );
  }

  //register to register
  Future<void> registerUserAndCreateDoc({
    required String email,
    required String password,
    required UserEntity user,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final registerUsecase = ref.read(registerUsecaseProvider);
      await registerUsecase.call(email: email, password: password, user: user);
    });
  }

  //register to logout
  Future<void> logoutUser() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(logoutUsecaseProvider).call(),
    );
  }
}
