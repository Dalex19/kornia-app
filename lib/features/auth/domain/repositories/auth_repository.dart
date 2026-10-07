
import 'package:kornia/features/auth/domain/entities/auth_user_entity.dart';
import 'package:kornia/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<String> registerWithEmailAndPassword ({required String email, required String password,});
  Future<void> loginWithEmailAndPassword ({required String email, required String password,});
  Future <void> createUserDocument({required UserEntity user, required String uid});
  Stream<AuthUserEntity?> onAuthStateChanges();
  Future<void> signOut();
}