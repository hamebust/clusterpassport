import 'package:cluster_passport/features/user/domain/entities/contact_entity.dart';
import 'package:cluster_passport/features/user/domain/repository/user_repository.dart';

/// Use case for retrieving device numbers from the user repository.
class GetDeviceNumberUseCase {
  final UserRepository repository;

  /// Constructor for GetDeviceNumberUseCase.
  /// The repository is injected via the constructor.
  GetDeviceNumberUseCase({required this.repository});

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