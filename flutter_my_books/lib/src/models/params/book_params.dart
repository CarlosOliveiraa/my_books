import 'dart:typed_data';

class BookParams {
  final String title;
  final int pages;
  final String description;
  final Future<Uint8List> image;

  BookParams({
    required this.title,
    required this.pages,
    required this.description,
    required this.image,
  });
}
