import 'package:cluster_passport/features/user/user_injection_container.dart';
import 'package:get_it/get_it.dart';

final sl =  GetIt.instance;

Future<void> init() async {

  await userInjectionContainer();
}