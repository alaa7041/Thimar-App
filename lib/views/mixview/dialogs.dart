import 'package:flutter/cupertino.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter/material.dart';

class DialogTypes extends StatefulWidget {
  const DialogTypes({Key? key}) : super(key: key);

  @override
  State<DialogTypes> createState() => _DialogTypesState();
}

class _DialogTypesState extends State<DialogTypes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              ElevatedButton(onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Welcome from AlertDialog'),
                    actions: [
                      ElevatedButton(onPressed: (){}, child: Text("CANCEL")),
                      ElevatedButton(onPressed: (){}, child: Text("ACCEPT")),
                    ],
                  ),
                );
              }, child: Text("show Alert Dialog")),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: Text("welcom from Simple Dialog"),
                    children: [
                      ElevatedButton(onPressed: (){}, child: Text("CANCEL"),),
                      ElevatedButton(onPressed: (){}, child: Text("ACCEPT")),
                    ],
                  ),
                );
              }, child: Text("show Simple Dialog")),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AboutDialog(
                    children: [
                      ElevatedButton(onPressed: (){}, child: Text("CANCEL"),),
                      ElevatedButton(onPressed: (){}, child: Text("ACCEPT")),
                    ],
                  ),
                );
              }, child: Text("show About Dialog")),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: Text("show Cupertino Dialog"),
                    actions: [
                      ElevatedButton(onPressed: (){}, child: Text("CANCEL"),),
                      ElevatedButton(onPressed: (){}, child: Text("ACCEPT")),
                    ],
                  ),
                );
              }, child: Text("show About Dialog")),

            ],
          ),
        ),
      ),
    );
  }
}
