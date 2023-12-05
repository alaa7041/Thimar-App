import 'package:flutter/material.dart';
import 'package:thimar/views/home/pages/cart/view.dart';
import '../../../../core/logic/helper_methods.dart';
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
        appBar: AppBar(
          title: const Center(
            child: Text("إتمام الطلب"),
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
              onPressed: () {
                navigateTo(const CartView());
              },
            ),
          ),
        ),
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
            SizedBox(
              height: 11.h,
            ),
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
            SizedBox(
              height: 36.h,
            ),
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
                  SizedBox(
                    width: 125.w,
                  ),
                  const Icon(Icons.keyboard_arrow_down_rounded),
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              "تحديد وقت التوصيل",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            const SizedBox(height: 13,),
            Row(
              children: const [

              ],
            ),

          ],
        ),
      ),
    );
  }
}
