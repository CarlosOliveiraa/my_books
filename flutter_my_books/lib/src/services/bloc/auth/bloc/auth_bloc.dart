import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_books/src/services/bloc/auth/event/auth_events.dart';
import 'package:flutter_my_books/src/services/bloc/auth/state/auth_states.dart';

import '../../../../controllers/auth/auth_controller.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStates> {
  final AuthController _authController;

  AuthBloc(this._authController) : super(FetchUserInitialState()) {
    on<FetchUserEvent>(_fetchUser);
  }

  Future<void> _fetchUser(
    FetchUserEvent event,
    Emitter<AuthStates> emit,
  ) async {
    try {
      emit(FetchUserLoadingState());
      final result = await _authController.login(
          email: event.email, password: event.password);
      emit(FetchUserSuccessState(user: result));
    } catch (error) {
      throw error.toString();
    }
  }
}
