
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kornia/core/network/firebase_provider.dart';
import 'package:kornia/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:kornia/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:kornia/features/auth/domain/repositories/auth_repository.dart';
import 'package:kornia/features/auth/domain/usecases/login_usecase.dart';
import 'package:kornia/features/auth/domain/usecases/logout_usecase.dart';
import 'package:kornia/features/auth/domain/usecases/register_usecase.dart';

final authDataSourceProvider = Provider<AuthRemoteDatasource>((ref) {
  return AuthRemoteDatasource(ref.watch(firestoreProvider),ref.watch(firebaseAuthProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(authDataSourceProvider));
});


final loginUsecaseProvider = Provider<LoginUsecase>((ref) {
  return LoginUsecase(ref.watch(authRepositoryProvider));
});

final registerUsecaseProvider = Provider<RegisterUsecase>((ref) {
  return RegisterUsecase(ref.watch(authRepositoryProvider));
});

final logoutUsecaseProvider = Provider<LogoutUsecase>((ref) {
  return LogoutUsecase(ref.watch(authRepositoryProvider));
});