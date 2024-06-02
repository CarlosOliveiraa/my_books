// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_my_books/src/services/bloc/fetch_books/events/send_book_events.dart';
// import 'package:flutter_my_books/src/services/bloc/fetch_books/states/send_book_states.dart';

// import '../../../../controllers/my_books_controller.dart';

// class SendBookBloc extends Bloc<SendBookEvent, SendBookState> {
//   final MyBooksController booksController;

//   SendBookBloc(this.booksController) : super(SendBookInitialState()) {
//     on<SendBookSendEvent>(_onSendBook);
//   }

//   void _onSendBook(
//     SendBookSendEvent event,
//     Emitter<SendBookState> emit,
//   ) async {
//     try {
//       await booksController.insertBook(params: state.params);
//       emit(SendBookSuccessState());
//     } catch (e) {}
//   }
// }
