import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_books/src/services/bloc/user/event/user_events.dart';
import 'package:flutter_my_books/src/services/bloc/user/states/user_states.dart';

import '../../../../controllers/users/user_controller.dart';

class UserBloc extends Bloc<UserEvents, UserStates> {
  final UserController _userController;

  UserBloc(this._userController) : super(FetchUserDataInitialState()) {
    on<FetchUserDataEvent>(_fetchUserData);
  }

  Future<void> _fetchUserData(
      FetchUserDataEvent event, Emitter<UserStates> emit) async {
    emit(FetchUserDataLoadingState());
    final result = await _userController.fetchUserdata();
    emit(FetchUserDataSuccessState(user: result));
    try {} catch (e) {
      throw e.toString();
    }
  }
}
