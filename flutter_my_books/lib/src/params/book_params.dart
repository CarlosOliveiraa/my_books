import 'dart:typed_data';

class BookParams {
  final String title;
  final int pages;
  final String description;
  final Future<Uint8List> image;
  final int userid;

  BookParams({
    required this.title,
    required this.pages,
    required this.description,
    required this.image,
    required this.userid,
  });
}
