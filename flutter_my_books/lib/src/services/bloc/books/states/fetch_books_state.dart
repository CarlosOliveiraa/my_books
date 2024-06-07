import '../../../../models/books/my_books_model.dart';

abstract class FetchBooksState {
  final List<MyBooksModel> books;

  FetchBooksState({required this.books});
}

class FetchBooksInitialState extends FetchBooksState {
  FetchBooksInitialState() : super(books: []);
}

class FetchBooksSuccesState extends FetchBooksState {
  FetchBooksSuccesState({required List<MyBooksModel> books})
      : super(books: books);
}

class FetchBooksErrorState extends FetchBooksState {
  final String message;

  FetchBooksErrorState(this.message) : super(books: []);
}
