import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_books/src/controllers/books/my_books_controller.dart';
import 'package:flutter_my_books/src/services/bloc/books/events/fetch_books_events.dart';
import 'package:flutter_my_books/src/services/bloc/books/states/fetch_books_state.dart';

class FetchBooksBloc extends Bloc<FetchBooksEvents, FetchBooksState> {
  final MyBooksController booksController;

  FetchBooksBloc(this.booksController) : super(FetchBooksInitialState()) {
    on<FetchBooksFetchEvent>(_fetchBooks);
  }
  Future<void> _fetchBooks(
      FetchBooksFetchEvent event, Emitter<FetchBooksState> emit) async {
    try {
      emit(FetchBooksInitialState());
      final books = await booksController.fetchBooks();
      emit(FetchBooksSuccesState(books: books));
    } catch (e) {
      emit(FetchBooksErrorState(e.toString()));
    }
  }
}
