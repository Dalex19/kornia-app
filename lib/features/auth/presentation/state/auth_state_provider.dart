import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kornia/features/auth/di_auth.dart';
import 'package:kornia/features/auth/domain/entities/auth_user_entity.dart';

final authStateProvider = StreamProvider<AuthUserEntity?>(
  (ref) => ref.watch(authRepositoryProvider).onAuthStateChanges(),
);