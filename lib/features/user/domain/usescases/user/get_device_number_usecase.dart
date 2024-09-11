import 'package:cluster_passport/features/user/domain/entities/contact_entity.dart';
import 'package:cluster_passport/features/user/domain/repositories/user_repository.dart';

/// Use case for retrieving device numbers from the user repository.
class GetDeviceNumberUsecase {
  final UserRepository repository;

  /// Constructor for GetDeviceNumberUsecase.
  /// The repository is injected via the constructor.
  GetDeviceNumberUsecase({required this.repository});

  /// Calls the repository to get the device numbers.
  /// Returns a list of [ContactEntity].
  /// Throws an exception if the retrieval fails.
  Future<List<ContactEntity>> call() async {
    try {
      // Fetch the device numbers from the repository.
      return await repository.getDeviceNumber();
    } catch (e) {
      // Handle any errors that occur during the fetch.
      throw Exception('Failed to fetch device numbers: $e');
    }
  }
}
