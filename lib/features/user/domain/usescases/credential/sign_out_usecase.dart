import 'package:cluster_passport/features/user/domain/repositories/user_repository.dart';

class SignOutUsecase {
  final UserRepository repository;

  SignOutUsecase({required this.repository});

  Future<void> call() async {
    return repository.signOut();
  }

}