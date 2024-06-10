import '../../../../models/auth/auth_model.dart';
import '../../../../models/users/user_model.dart';

abstract class AuthStates {
  final AuthModel? token;
  final UserModel? user;

  AuthStates({
    this.token,
    this.user,
  });
}

class FetchUserInitialState extends AuthStates {
  FetchUserInitialState() : super(token: AuthModel());
}

class FetchUserLoadingState extends AuthStates {
  FetchUserLoadingState() : super(token: AuthModel());
}

class FetchUserSuccessState extends AuthStates {
  FetchUserSuccessState({required AuthModel token}) : super(token: token);
}

class FetchUserErrorState extends AuthStates {
  final String message;
  FetchUserErrorState({required this.message}) : super(token: AuthModel());
}

class SignUpUserInitialState extends AuthStates {
  SignUpUserInitialState() : super(token: AuthModel());
}

class SignUpUserLoadingState extends AuthStates {
  SignUpUserLoadingState() : super(token: AuthModel());
}

class SignUpUserSuccessState extends AuthStates {
  SignUpUserSuccessState({required UserModel user}) : super(user: user);
}

class SignUpUserErrorState extends AuthStates {
  final String message;
  SignUpUserErrorState({required this.message}) : super(token: AuthModel());
}
