import 'package:cluster_passport/features/user/domain/entities/user_entity.dart';
import 'package:cluster_passport/features/user/domain/repositories/user_repository.dart';

class GetSingleUserUseCase {
  final UserRepository repository;

  GetSingleUserUseCase({required this.repository});

  Stream<List<UserEntity>> call(String uid) {
    return repository.getSingleUser(uid);
  }

}