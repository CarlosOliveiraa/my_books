import 'package:flutter/material.dart';

class AddImageWidget extends StatelessWidget {
  final void Function()? onTap;
  const AddImageWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 150,
        child: Image.asset('assets/images/png/adicionar-imagem.png'),
      ),
    );
  }
}
