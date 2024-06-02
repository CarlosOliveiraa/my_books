abstract class FetchBooksEvents {}

class FetchBooksFetchEvent extends FetchBooksEvents {}

class BookAddedEvent extends FetchBooksEvents {}

// class FecthBooksLoadingEvent extends FetchBooksEvents {}

// class FecthBooksErrorEvent extends FetchBooksEvents {}

// class FecthBooksSuccessEvent extends FetchBooksEvents {
//   final List<MyBooksModel> books;

//   FecthBooksSuccessEvent(this.books);
// }
