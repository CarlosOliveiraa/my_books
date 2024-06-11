import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_books/src/pages/book_detail_page.dart';
import 'package:flutter_my_books/src/pages/widgets/base64_circle_avatar.dart';
import 'package:flutter_my_books/src/pages/widgets/book_card_widget.dart';
import 'package:flutter_my_books/src/services/bloc/books/states/fetch_books_state.dart';

import '../../models/users/user_model.dart';
import '../../services/bloc/books/blocs/fetch_books_bloc.dart';
import '../../services/bloc/books/events/fetch_books_events.dart';

class ProfilePage extends StatefulWidget {
  final UserModel user;

  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel get user => widget.user;

  @override
  void initState() {
    super.initState();
    context.read<FetchBooksBloc>().add(FetchBooksFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding.top;
    debugPrint('$padding');
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Base64CircleAvatar(
                    base64String: user.imageProfile!,
                    radius: 60,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name!,
                        textAlign: TextAlign.start,
                      ),
                      Text(user.email!),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 50),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Seus livros',
                style: TextStyle(fontSize: 25),
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<FetchBooksBloc, FetchBooksState>(
              builder: (context, state) {
                if (state is FetchBooksInitialState) {
                  return SizedBox(
                    height: 170,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: ((context, index) =>
                          const SizedBox(width: 10)),
                      itemBuilder: ((context, index) {
                        return const BookCardShimmer();
                      }),
                    ),
                  );
                } else if (state is FetchBooksSuccesState) {
                  return SizedBox(
                    height: 170,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: state.books.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: ((context, index) =>
                          const SizedBox(width: 10)),
                      itemBuilder: ((context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BookDetailPage(book: state.books[index]),
                              ),
                            );
                          },
                          child: BookCardWidget(
                            title: state.books[index].title!,
                            image: state.books[index].image!,
                          ),
                        );
                      }),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
