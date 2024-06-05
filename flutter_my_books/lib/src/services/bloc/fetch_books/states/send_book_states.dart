abstract class SendBookStates {}

class SendBookInitialState extends SendBookStates {}

class SendBookLoadingState extends SendBookStates {}

class SendBookSuccessState extends SendBookStates {}

class SendBookErrorState extends SendBookStates {
  final String message;

  SendBookErrorState({required this.message});
}
