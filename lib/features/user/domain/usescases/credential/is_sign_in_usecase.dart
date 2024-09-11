import 'package:cluster_passport/features/user/domain/repositories/user_repository.dart';

class IsSignInUsecase {
  final UserRepository repository;

  IsSignInUsecase({required this.repository});

  Future<bool> call() async {
    return repository.isSignIn();
  }
}
