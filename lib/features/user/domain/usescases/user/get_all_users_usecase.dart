import 'package:cluster_passport/features/user/domain/entities/user_entity.dart';
import 'package:cluster_passport/features/user/domain/repositories/user_repository.dart';

class GetAllUsersUseCase {
  final UserRepository repository;

  GetAllUsersUseCase({required this.repository});

  Stream<List<UserEntity>> call() {
    return repository.getAllUsers();
  }

}