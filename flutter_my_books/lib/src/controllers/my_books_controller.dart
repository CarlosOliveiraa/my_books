import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_my_books/src/models/my_books_model.dart';
import 'package:flutter_my_books/src/models/params/book_params.dart';
import 'package:http/http.dart' as http;

class MyBooksController {
  Future<void> insertBook({required BookParams params}) async {
    String imageBase64 = base64Encode(await params.image);
    debugPrint(imageBase64);
    final body = jsonEncode({
      'title': params.title,
      'pages': params.pages,
      'description': params.description,
      'image': imageBase64,
    });
    try {
      final response = await http.post(
        Uri.parse('${dotenv.env["BASE_URL"]}/books/insertbook'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: body,
      );

      if (response.statusCode != 200) {
        throw 'Erro ao inserir livro';
      }
    } catch (error) {
      throw error.toString();
    }
  }

  Future<List<MyBooksModel>> fetchBooks() async {
    try {
      final response =
          await http.get(Uri.parse('${dotenv.env["BASE_URL"]}/allBooks'));
      return MyBooksModel.fromList(response.body);
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
