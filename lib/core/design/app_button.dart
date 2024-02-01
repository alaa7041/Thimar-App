import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback onPress;

  const AppButton(
      {Key? key,
      this.isLoading = false,
      required this.text,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return FilledButton(
      onPressed: onPress,
      child: Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize:
      15)),
    );
  }
}
