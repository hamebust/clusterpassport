import 'package:cluster_passport/features/user/domain/entities/user_entity.dart';
import 'package:cluster_passport/features/user/domain/repositories/user_repository.dart';

class GetAllUsersUsecase {
  final UserRepository repository;

  GetAllUsersUsecase({required this.repository});

  Stream<List<UserEntity>> call() {
    return repository.getAllUsers();
  }
}
