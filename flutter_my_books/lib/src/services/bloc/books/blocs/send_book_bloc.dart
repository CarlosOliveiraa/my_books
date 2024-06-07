import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_books/src/controllers/books/my_books_controller.dart';
import 'package:flutter_my_books/src/services/bloc/books/events/send_book_events.dart';
import 'package:flutter_my_books/src/services/bloc/books/states/send_book_states.dart';

class SendBookBloc extends Bloc<SendBookEvent, SendBookStates> {
  final MyBooksController _booksController;

  SendBookBloc(this._booksController) : super(SendBookInitialState()) {
    on<BookAddedEvent>(_addBook);
  }

  Future<void> _addBook(
      BookAddedEvent event, Emitter<SendBookStates> emit) async {
    try {
      emit(SendBookLoadingState());
      await _booksController.insertBook(params: event.params);
      emit(SendBookSuccessState());
    } catch (e) {
      emit(SendBookErrorState(message: e.toString()));
    }
  }
}
