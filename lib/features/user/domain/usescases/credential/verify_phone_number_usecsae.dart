import 'package:cluster_passport/features/user/domain/repositories/user_repository.dart';

class VerifyPhoneNumberUsecase {
  final UserRepository repository;

  VerifyPhoneNumberUsecase({required this.repository});

  Future<void> call(String phoneNumber) async {
    return repository.verifyPhoneNumber(phoneNumber);
  }
}
