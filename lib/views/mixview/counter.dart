import 'package:flutter/material.dart';

import '../../core/logic/cache_helper.dart';

class CounterView extends StatefulWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  State<CounterView> createState() => _CounterViewState();
}


int count = CacheHelper.getCount();
class _CounterViewState extends State<CounterView> {


  @override
  void initState() {
    super.initState();
    // CacheHelper.clear();
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
                CacheHelper.setCount(count);
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
                CacheHelper.setCount(count);
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
