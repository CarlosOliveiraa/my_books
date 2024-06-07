import '../../../../models/users/user_model.dart';

abstract class AuthStates {
  final UserModel user;

  AuthStates({required this.user});
}

class FetchUserInitialState extends AuthStates {
  FetchUserInitialState() : super(user: UserModel());
}

class FetchUserLoadingState extends AuthStates {
  FetchUserLoadingState() : super(user: UserModel());
}

class FetchUserSuccessState extends AuthStates {
  FetchUserSuccessState({required UserModel user}) : super(user: user);
}

class FetchUserErrorState extends AuthStates {
  final String message;
  FetchUserErrorState({required this.message}) : super(user: UserModel());
}
