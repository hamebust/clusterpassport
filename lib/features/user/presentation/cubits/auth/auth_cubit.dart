import 'package:bloc/bloc.dart';
import 'package:cluster_passport/features/user/domain/usescases/credential/get_current_uid_usecase.dart';
import 'package:cluster_passport/features/user/domain/usescases/credential/is_sign_in_usecase.dart';
import 'package:cluster_passport/features/user/domain/usescases/credential/sign_out_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUidUsecase getCurrentUidUsecase;
  final IsSignInUsecase isSignInUsecase;
  final SignOutUsecase signOutUsecase;

  AuthCubit(
      {required this.getCurrentUidUsecase,
      required this.isSignInUsecase,
      required this.signOutUsecase})
      : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      bool isSignIn = await isSignInUsecase.call();

      if (isSignIn) {
        final uid = await getCurrentUidUsecase.call();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUsecase.call();
      emit(Authenticated(uid: uid));
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUsecase.call();
      emit(UnAuthenticated());
    } catch (_) {
      emit(UnAuthenticated());
    }
  }
}
