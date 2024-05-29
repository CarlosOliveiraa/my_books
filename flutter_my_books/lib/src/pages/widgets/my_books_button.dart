import 'package:flutter/material.dart';

class MyBooksButton extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final Color? backgroundColor;
  final void Function()? onTap;

  const MyBooksButton(
      {super.key,
      required this.width,
      required this.height,
      this.backgroundColor,
      this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    final titleColorLight =
        onTap != null ? Colors.black : Colors.black.withOpacity(0.3);

    final titleColorDark =
        onTap != null ? Colors.white : Colors.white.withOpacity(0.3);

    final brightness = MediaQuery.of(context).platformBrightness;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: onTap != null
              ? backgroundColor
              : backgroundColor!.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: brightness == Brightness.light
                ? titleColorLight
                : titleColorDark,
          ),
        ),
      ),
    );
  }
}
