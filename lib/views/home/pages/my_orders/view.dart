 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/order_Items.dart';

class MyOrdersPages extends StatelessWidget {
  const MyOrdersPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("طلباتي"),
        ),
      ),
      body: ListView.builder(
          itemBuilder: (context, index) => const OrderItems(),
          itemCount: 4,
          padding:  EdgeInsets.all(16.w)),
    );
  }
}

