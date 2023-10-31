import 'package:flutter/material.dart';
import '../core/logic/cashe_helper.dart';

class CounterView extends StatefulWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  State<CounterView> createState() => _CounterViewState();
}


int count = CasheHelper.getCount();
class _CounterViewState extends State<CounterView> {


  @override
  void initState() {
    super.initState();
    CasheHelper.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                count++;
                CasheHelper.setCount(count);
                setState(() {

                });
              },
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 16),
            Text("$count"),
            const SizedBox(width: 16),
            FloatingActionButton(
              onPressed: () {
                count--;
                CasheHelper.setCount(count);
                setState(() {

                });
              },
              child: const Icon(Icons.minimize),
            ),
          ],
        ),),
    );
  }
}
