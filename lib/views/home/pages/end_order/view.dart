import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/core/design/app_bar.dart';
import 'package:thimar/core/design/app_image.dart';
import 'package:thimar/core/logic/helper_methods.dart';

import '../../../../core/design/app_button.dart';
import '../../../../features/home/pages/cart/get/bloc.dart';
import '../../../add_address/view.dart';
import '../cart/components/prices_detiles.dart';
import 'component/payment_method.dart';

class EndOrderView extends StatefulWidget {
  const EndOrderView({super.key});

  @override
  State<EndOrderView> createState() => _EndOrderViewState();
}

class _EndOrderViewState extends State<EndOrderView> {
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  final bloc = KiwiContainer().resolve<GetCartBloc>()..add(GetCartEvent());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            CustomAppBar(
                text: "اتمام الطلب",
                onPress: () {
                  Navigator.pop(context);
                }),
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
            SizedBox(height: 11.h,),
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
            SizedBox(height: 36.h,),
            Row(
              children: [
                Text(
                  "اختر عنوان التوصيل",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 26.w,
                  height: 26.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(.13),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      navigateTo(AddressView());
                    },
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            OutlinedButton(
              onPressed: () {},
              child: Row(
                children: const [
                  Text("المنزل : 119 طريق الملك عبدالعزيز"),
                  Spacer(),
                  Icon(Icons.keyboard_arrow_down_rounded),
                ],
              ),
            ),
            SizedBox(height: 18.h,),
            Text(
              "تحديد وقت التوصيل",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            SizedBox(height: 32.h,),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    child: Row(
                      children: [
                        Text("${date.year}/${date.month}/${date.day}"),
                        Spacer(),
                        AppImage(
                          path: "assets/icons/timer.png",
                          fit: BoxFit.scaleDown,
                          width: 15.w,
                          height: 15.h,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(1980),
                        lastDate: DateTime(2100),
                      );
                      if (newDate == null) return;

                      final newDateTime = DateTime(
                        newDate.year,
                        newDate.month,
                        newDate.day,
                      );
                      setState(() {
                        date = newDate;
                      });
                    },
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: OutlinedButton(
                    child: Row(
                      children: [
                        Text("${time.hour}:${time.minute}"),
                        Spacer(),
                        AppImage(
                          path: "assets/icons/calendar.png",
                          fit: BoxFit.scaleDown,
                          width: 15.w,
                          height: 15.h,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(
                          hour: time.hour,
                          minute: time.minute,
                        ),
                      );
                      if (newTime == null) return;
                      final newDateTime = TimeOfDay(
                        hour: newTime.hour,
                        minute: newTime.minute,
                      );
                      setState(() {
                        time = newTime;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 13.h,),
            Text(
              "ملاحظات وتعليمات",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: 120.h,
              child: TextFormField(),
            ),
            Text(
              "اختر طريقةالدفع",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            Row(
              children: const [
                PaymentMethod(
                  image: "assets/images/money.png",
                  isCash: "كاش",
                ),
                Spacer(),
                PaymentMethod(image: "assets/images/visa.png"),
                Spacer(),
                PaymentMethod(image: "assets/images/group.png"),
              ],
            ),
            Text(
              "ملخص الطلب",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            PricesDetails(
               isEndOrder: true,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: "انهاء الطلب",
                  onPress: () {

                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
