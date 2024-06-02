import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_my_books/src/models/my_books_model.dart';
import 'package:flutter_my_books/src/models/params/book_params.dart';
import 'package:http/http.dart' as http;

class MyBooksController {
  List<MyBooksModel> books = [];
  Future<void> insertBook({required BookParams params}) async {
    String imageBase64 = base64Encode(await params.image);

    final body = jsonEncode({
      'title': params.title,
      'pages': params.pages,
      'description': params.description,
      'image': imageBase64,
    });
    try {
      await http.post(
        Uri.parse('${dotenv.env["BASE_URL"]}/books/insertbook'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: body,
      );
    } catch (e) {}
  }

  Future<List<MyBooksModel>> fetchBooks() async {
    try {
      final response =
          await http.get(Uri.parse('${dotenv.env["BASE_URL"]}/allBooks'));
      books = MyBooksModel.fromList(response.body);
      return books;
    } catch (e) {
      return throw (e.toString());
    }
  }

  Future<void> removeBook(int id) async {
    try {
      await http.post(Uri.parse('${dotenv.env["BASE_URL"]}/books/remove/$id'));
    } catch (e) {
      return;
    }
  }
}
