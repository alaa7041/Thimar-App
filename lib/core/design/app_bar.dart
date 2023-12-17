import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  final String text;
  final VoidCallback onPress;


  const CustomAppBar({Key? key, required this.text, required this.onPress})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(widget.text),
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
            onPressed: widget.onPress,
          ),
        ),

      ),
    ));
  }
}
