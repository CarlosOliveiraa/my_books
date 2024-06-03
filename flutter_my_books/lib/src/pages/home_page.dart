import 'dart:convert';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_books/src/controllers/my_books_controller.dart';
import 'package:flutter_my_books/src/models/my_books_model.dart';
import 'package:flutter_my_books/src/pages/book_detail_page.dart';
import 'package:flutter_my_books/src/pages/insert_book_page.dart';
import 'package:flutter_my_books/src/pages/widgets/my_books_button.dart';
import 'package:flutter_my_books/src/services/bloc/fetch_books/blocs/fetch_books_bloc.dart';
import 'package:flutter_my_books/src/services/bloc/fetch_books/events/fetch_books_events.dart';
import 'package:flutter_my_books/src/services/bloc/fetch_books/states/fetch_books_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MyBooksModel> books = [];
  final controller = MyBooksController();

  @override
  void initState() {
    super.initState();
    context.read<FetchBooksBloc>().add(FetchBooksFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    context.read<FetchBooksBloc>().add(FetchBooksFetchEvent());
    final locale = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<ColorsExtensions>();
    debugPrint('Cor primária => ${colors!.primaryColor}');

    return BlocListener<FetchBooksBloc, FetchBooksState>(
      listener: (context, state) {
        if (state is FetchBooksSuccesState) {
          books = state.books;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(locale.welcome),
        ),
        body: BlocBuilder<FetchBooksBloc, FetchBooksState>(
          builder: (context, state) {
            if (state is FetchBooksInitialState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FetchBooksErrorState) {
              return Center(
                child: Text(locale.failedLoad),
              );
            } else if (state is FetchBooksSuccesState) {
              return ListView.builder(
                itemCount: books.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BookDetailPage(book: book)));
                    },
                    child: ListTile(
                      leading: Image.memory(base64Decode(book.image!)),
                      title: Text(book.title!),
                      subtitle: Text(book.description!),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text(locale.failedLoad));
            }
          },
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(15),
          child: MyBooksButton(
            width: 300,
            height: 50,
            title: locale.insert,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const InsertBookPage(),
                ),
              );
            },
            backgroundColor: colors.primaryColor,
          ),
        ),
      ),
    );
  }
}
