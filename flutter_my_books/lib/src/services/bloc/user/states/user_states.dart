import '../../../../models/users/user_model.dart';

abstract class UserStates {
  final UserModel user;

  UserStates({required this.user});
}

class FetchUserDataInitialState extends UserStates {
  FetchUserDataInitialState() : super(user: UserModel());
}

class FetchUserDataLoadingState extends UserStates {
  FetchUserDataLoadingState() : super(user: UserModel());
}

class FetchUserDataSuccessState extends UserStates {
  FetchUserDataSuccessState({required UserModel user}) : super(user: user);
}

class FetchUserDataErrorState extends UserStates {
  FetchUserDataErrorState() : super(user: UserModel());
}
