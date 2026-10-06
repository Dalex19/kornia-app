import 'package:kornia/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:kornia/features/auth/data/dto/user_dto.dart';
import 'package:kornia/features/auth/domain/entities/auth_user_entity.dart';
import 'package:kornia/features/auth/domain/repositories/auth_repository.dart';
import 'package:kornia/features/auth/domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<void> createUserDocument({required String uid, required UserEntity user}) async {
    final dto = UserDto.fromEntity(user);
    final json = dto.toMap();
    await remoteDatasource.createDocument(data: json, uid: uid);
  }

  @override
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await remoteDatasource.loginWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<String> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await remoteDatasource.registerWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await remoteDatasource.signOut();
  }

  @override
  Stream<AuthUserEntity?> onAuthStateChanges() {
    return remoteDatasource.authStateChanges().map((user) {
      if (user == null) return null;
      return AuthUserEntity(uid: user.uid, email: user.email ?? '');
    });
  }
}

