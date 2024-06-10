import 'dart:io';
import 'dart:typed_data';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_books/src/controllers/auth/auth_controller.dart';
import 'package:flutter_my_books/src/pages/auth/login_page.dart';
import 'package:flutter_my_books/src/params/user_params.dart';
import 'package:flutter_my_books/src/services/bloc/auth/event/auth_events.dart';
import 'package:flutter_my_books/src/services/bloc/auth/state/auth_states.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import '../../services/bloc/auth/bloc/auth_bloc.dart';
import '../widgets/my_books_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final authController = AuthController();

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickerImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        File? croppedFile = await _croppImage(File(pickedFile.path));

        if (croppedFile != null) {
          final imageBytes = await croppedFile.readAsBytes();
          final image = img.decodeImage(imageBytes);
          if (image != null) {
            final resizedImage = img.copyResize(
              image,
              width: 140,
              height: 140,
            );

            final resizedBytes = img.encodePng(resizedImage);

            final resizedFile = await croppedFile.writeAsBytes(resizedBytes);

            setState(() {
              _image = resizedFile;
            });
          }
        }
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  Future<File?> _croppImage(File imageFile) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Recortar Imagem',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Recortar Imagem',
            minimumAspectRatio: 1.0,
          ),
        ],
      );
      if (croppedFile != null) {
        return File(croppedFile.path);
      }
    } catch (e) {
      debugPrint("Error cropping image: $e");
    }
    return null;
  }

  Future<Uint8List> _convertImageToByte(File imageFile) async {
    final imageBytes = await imageFile.readAsBytes();
    return imageBytes;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ColorsExtensions>()!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: InkWell(
                onTap: () => _pickerImage(ImageSource.gallery),
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.grey,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? const Icon(Icons.camera_enhance, size: 50)
                      : null,
                ),
              ),
            ),
            MyBooksTextField(
              hintText: 'Name',
              controller: nameController,
            ),
            const SizedBox(height: 10),
            MyBooksTextField(
              hintText: 'Email',
              controller: emailController,
            ),
            const SizedBox(height: 10),
            MyBooksTextField(
              hintText: 'Password',
              controller: passController,
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          BlocConsumer<AuthBloc, AuthStates>(listener: (context, state) {
        if (state is SignUpUserSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
          );
        }
      }, builder: ((context, state) {
        return Container(
          padding: const EdgeInsets.all(15),
          child: MyBooksButton(
            width: 300,
            height: 50,
            title: 'Cadastrar',
            onTap: () async {
              final imageBytes = await _convertImageToByte(_image!);

              // ignore: use_build_context_synchronously
              context.read<AuthBloc>().add(
                    SignUpUserEvent(
                      params: UserParams(
                        name: nameController.text,
                        email: emailController.text,
                        password: passController.text,
                        imageProfile: imageBytes,
                      ),
                    ),
                  );
            },
            backgroundColor: colors.primaryColor,
          ),
        );
      })),
    );
  }
}
