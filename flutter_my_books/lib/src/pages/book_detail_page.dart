import 'dart:convert';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_books/src/controllers/books/my_books_controller.dart';
import 'package:flutter_my_books/src/models/books/my_books_model.dart';
import 'package:flutter_my_books/src/services/bloc/books/blocs/fetch_books_bloc.dart';
import 'package:flutter_my_books/src/services/bloc/books/events/fetch_books_events.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'widgets/my_books_button.dart';

class BookDetailPage extends StatefulWidget {
  final MyBooksModel book;

  const BookDetailPage({
    super.key,
    required this.book,
  });

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  MyBooksModel get book => widget.book;
  final controller = MyBooksController();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ColorsExtensions>();
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.detail),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.memory(base64Decode(book.image!)),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${locale.title}: ${book.title!}',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${locale.pages}: ${book.pages!}',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${locale.description}:\n${book.description!}',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        child: MyBooksButton(
          width: 300,
          height: 50,
          title: locale.remove,
          onTap: () {
            controller.removeBook(book.id!);
            context.read<FetchBooksBloc>().add(FetchBooksFetchEvent());
            Navigator.pop(context, true);
          },
          backgroundColor: colors!.errorColor,
        ),
      ),
    );
  }
}
