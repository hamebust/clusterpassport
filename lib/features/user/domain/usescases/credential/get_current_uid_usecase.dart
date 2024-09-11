import 'package:cluster_passport/features/user/domain/repositories/user_repository.dart';

class GetCurrentUidUsecase {
  final UserRepository repository;

  GetCurrentUidUsecase({required this.repository});

  Future<String> call() async {
    return repository.getCurrentUID();
  }
}
