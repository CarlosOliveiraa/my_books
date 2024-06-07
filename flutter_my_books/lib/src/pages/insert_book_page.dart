import 'dart:io';
import 'dart:typed_data';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_books/src/params/book_params.dart';
import 'package:flutter_my_books/src/pages/widgets/add_image_widget.dart';
import 'package:flutter_my_books/src/services/bloc/books/blocs/fetch_books_bloc.dart';
import 'package:flutter_my_books/src/services/bloc/books/blocs/send_book_bloc.dart';
import 'package:flutter_my_books/src/services/bloc/books/events/fetch_books_events.dart';
import 'package:flutter_my_books/src/services/bloc/books/states/send_book_states.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/books/my_books_controller.dart';
import '../models/users/user_model.dart';
import '../services/bloc/books/events/send_book_events.dart';
import 'widgets/my_books_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InsertBookPage extends StatefulWidget {
  final UserModel user;

  const InsertBookPage({super.key, required this.user});

  @override
  State<InsertBookPage> createState() => _InsertBookPageState();
}

class _InsertBookPageState extends State<InsertBookPage> {
  final titleController = TextEditingController();
  final pagesController = TextEditingController();
  final descriptionController = TextEditingController();
  final booksController = MyBooksController();

  //Insert Image start
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickerImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  //Insert Image end

  //Convert image to bytes start
  Future<Uint8List> _convertImageToByte(File imageFile) async {
    final imageBytes = await imageFile.readAsBytes();
    return imageBytes;
  }

  //Convert image to bytes end

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ColorsExtensions>();
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
        appBar: AppBar(
          title: Text(locale.insert),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  MyBooksTextField(
                    hintText: locale.title,
                    textInputAction: TextInputAction.next,
                    controller: titleController,
                  ),
                  const SizedBox(height: 10),
                  MyBooksTextField(
                    hintText: locale.pages,
                    textInputAction: TextInputAction.next,
                    controller: pagesController,
                  ),
                  const SizedBox(height: 10),
                  MyBooksTextField(
                    maxLines: 4,
                    hintText: locale.description,
                    textInputAction: TextInputAction.done,
                    controller: descriptionController,
                  ),
                  const SizedBox(height: 20),
                  _image == null
                      ? AddImageWidget(
                          onTap: () => _pickerImage(ImageSource.camera),
                        )
                      : SizedBox(
                          height: 200,
                          child: Image.file(_image!),
                        ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<SendBookBloc, SendBookStates>(
              listener: (context, state) {
            if (state is SendBookSuccessState) {
              context.read<FetchBooksBloc>().add(FetchBooksFetchEvent());
              Navigator.pop(context, true);
            }
          }, builder: (context, state) {
            if (state is SendBookLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return MyBooksButton(
                width: 300,
                height: 50,
                title: locale.insert,
                backgroundColor: colors!.primaryColor,
                onTap: () {
                  final imageBytes = _convertImageToByte(_image!);

                  context.read<SendBookBloc>().add(
                        BookAddedEvent(
                          params: BookParams(
                              title: titleController.text,
                              pages: int.parse(pagesController.text),
                              description: descriptionController.text,
                              image: imageBytes,
                              userid: widget.user.id!),
                        ),
                      );
                });
          }),
        ));
  }
}
