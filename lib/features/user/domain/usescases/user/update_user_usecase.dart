import 'package:cluster_passport/features/user/domain/entities/user_entity.dart';
import 'package:cluster_passport/features/user/domain/repositories/user_repository.dart';

class UpdateUserUsecase {
  final UserRepository repository;

  UpdateUserUsecase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.updateUser(user);
  }
}
