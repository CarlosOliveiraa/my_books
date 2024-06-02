import 'dart:convert';

class MyBooksModel {
  final int? id;
  final String? title;
  final int? pages;
  final String? description;
  final String? image;

  MyBooksModel({
    this.id,
    this.title,
    this.pages,
    this.description,
    this.image,
  });

  static MyBooksModel fromJson(Map<String, dynamic> json) {
    // final imageBytes = Uint8List.fromList(imageData.cast<int>());

    return MyBooksModel(
      id: json['id'],
      title: json['title'],
      pages: json['pages'],
      description: json['description'],
      image: json['image'],
    );
  }

  static List<MyBooksModel> fromList(String books) {
    final decodedList = (jsonDecode(books) as List);
    return decodedList.map((model) => fromJson(model)).toList();
  }
}
