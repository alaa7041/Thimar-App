import 'package:flutter/cupertino.dart';
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ElevatedButton(onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Welcome from AlertDialog'),
                    actions: [
                      ElevatedButton(onPressed: (){}, child: const Text("CANCEL")),
                      ElevatedButton(onPressed: (){}, child: const Text("ACCEPT")),
                    ],
                  ),
                );
              }, child: const Text("show Alert Dialog")),
              const SizedBox(height: 10,),
              ElevatedButton(onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: const Text("welcom from Simple Dialog"),
                    children: [
                      ElevatedButton(onPressed: (){}, child: const Text("CANCEL"),),
                      ElevatedButton(onPressed: (){}, child: const Text("ACCEPT")),
                    ],
                  ),
                );
              }, child: const Text("show Simple Dialog")),
              const SizedBox(height: 10,),
              ElevatedButton(onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AboutDialog(
                    children: [
                      ElevatedButton(onPressed: (){}, child: const Text("CANCEL"),),
                      ElevatedButton(onPressed: (){}, child: const Text("ACCEPT")),
                    ],
                  ),
                );
              }, child: const Text("show About Dialog")),
              const SizedBox(height: 10,),
              ElevatedButton(onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text("show Cupertino Dialog"),
                    actions: [
                      ElevatedButton(onPressed: (){}, child: const Text("CANCEL"),),
                      ElevatedButton(onPressed: (){}, child: const Text("ACCEPT")),
                    ],
                  ),
                );
              }, child: const Text("show About Dialog")),

            ],
          ),
        ),
      ),
    );
  }
}
