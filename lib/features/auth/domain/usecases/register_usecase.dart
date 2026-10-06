import 'package:kornia/features/auth/domain/repositories/auth_repository.dart';
import 'package:kornia/features/auth/domain/entities/user_entity.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<void> call ({required String email, required String password, required UserEntity user}) async {
    final uid = await repository.registerWithEmailAndPassword(email: email, password: password);
    await repository.createUserDocument(user: user, uid: uid);
  }
}