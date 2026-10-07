import 'package:kornia/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;
  
  LoginUsecase(this.repository);

 Future<void> call ({required String email, required String password}) async {
  return repository.loginWithEmailAndPassword(email: email, password: password);
 }
  
}
