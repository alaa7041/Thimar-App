import 'package:flutter/material.dart';

class BarApp extends StatelessWidget {
  final String text;
  final VoidCallback onPress;

  const BarApp({Key? key, required this.text, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(text),
        ),
        leading: Container(
          margin: const EdgeInsets.all(9),
          width: 30,
          height: 32,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.13),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: onPress,
          ),
        ),
      ),
    ));
  }
}
