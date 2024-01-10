import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EndOrderView extends StatefulWidget {
  const EndOrderView({super.key});

  @override
  State<EndOrderView> createState() => _EndOrderViewState();
}

class _EndOrderViewState extends State<EndOrderView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                Text(
                  "الإسم :",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  "الاء مجدي",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 11.h),
            Row(
              children: [
                Text(
                  "الجوال:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  "01550301245",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 36.h),
            Row(
              children: [
                Text(
                  "اختر عنوان التوصيل",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(width: 210.w),
                Icon(Icons.add, color: Theme.of(context).primaryColor),
              ],
            ),
            OutlinedButton(
              onPressed: () {},
              child: Row(
                children: [
                  const Text("المنزل : 119 طريق الملك عبدالعزيز"),
                  SizedBox(width: 125.w),
                  const Icon(Icons.keyboard_arrow_down_rounded),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              "تحديد وقت التوصيل",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            SizedBox(height: 13.h),
            Row(
              children: const [],
            ),
          ],
        ),
      ),
    );
  }
}
