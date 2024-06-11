import 'dart:convert';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_books/src/controllers/books/my_books_controller.dart';
import 'package:flutter_my_books/src/controllers/users/user_controller.dart';
import 'package:flutter_my_books/src/pages/book_detail_page.dart';
import 'package:flutter_my_books/src/pages/insert_book_page.dart';
import 'package:flutter_my_books/src/pages/widgets/empty_list.dart';
import 'package:flutter_my_books/src/services/bloc/books/blocs/fetch_books_bloc.dart';
import 'package:flutter_my_books/src/services/bloc/books/states/fetch_books_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_my_books/src/services/bloc/user/bloc/user_bloc.dart';
import 'package:flutter_my_books/src/services/bloc/user/event/user_events.dart';
import 'package:flutter_my_books/src/services/bloc/user/states/user_states.dart';
import 'profile/profile_page.dart';
import 'widgets/base64_circle_avatar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = MyBooksController();
  final userController = UserController();

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(FetchUserDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<ColorsExtensions>();
    debugPrint('Cor primária => ${colors!.primaryColor}');

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              title: Text('Bem vindo'),
            ),
          ),
          BlocBuilder<FetchBooksBloc, FetchBooksState>(
            builder: (context, state) {
              final books = state.books;

              if (state is FetchBooksInitialState) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is FetchBooksErrorState) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text('Failed to load books'),
                  ),
                );
              } else if (state.books.isEmpty) {
                return const SliverFillRemaining(
                    child: Center(child: EmptyList()));
              } else if (state is FetchBooksSuccesState) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(childCount: books.length,
                      (context, index) {
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
                  }),
                );
              } else {
                return Center(child: Text(locale.failedLoad));
              }
            },
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 75,
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<UserBloc, UserStates>(builder: (context, state) {
          if (state is FetchUserDataSuccessState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.home,
                  size: 32,
                ),
                const Icon(Icons.search, size: 32),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              InsertBookPage(user: state.user),
                        ),
                      );
                    },
                    child: const Icon(Icons.add_box_outlined, size: 32)),
                const Icon(Icons.notes, size: 32),
                InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage(
                                    user: state.user,
                                  )));
                    },
                    child: Base64CircleAvatar(
                        base64String: state.user.imageProfile!))
              ],
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
