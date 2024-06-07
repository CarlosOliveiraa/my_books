import '../../../../params/book_params.dart';

abstract class SendBookEvent {}

class BookAddedEvent extends SendBookEvent {
  final BookParams params;

  BookAddedEvent({required this.params});
}
