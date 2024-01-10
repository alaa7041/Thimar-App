import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../features/home/pages/notifications/model.dart';
import 'components/notification_item.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationModel> list = [
    NotificationModel(
      image: "https://cdn-icons-png.flaticon.com/512/11498/11498772.png",
      title: "تم قبول طلبك وجاري تحضيره الأن",
      body:
          "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد\n هذا النص من مولد النص العربى",
      time: "منذ ساعه",
    ),
    NotificationModel(
      image: "https://cdn-icons-png.flaticon.com/512/11498/11498772.png",
      title: "تم قبول طلبك وجاري تحضيره الأن",
      body:
          "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد\n هذا النص من مولد النص العربى",
      time: "منذ ساعتان",
    ),
    NotificationModel(
      image: "https://cdn-icons-png.flaticon.com/512/11498/11498772.png",
      title: "تم قبول طلبك وجاري تحضيره الأن",
      body:
          "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد\n هذا النص من مولد النص العربى",
      time: "منذ ساعتان",
    ),
  ];

  @override
  void initState() {
    super.initState();
    getData();
  }

  bool isLoading = true;

  getData() async {
    await Future.delayed(const Duration(seconds: 3));
    isLoading = false;
    setState(() {});
    print("alaa");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Center(
          child: Text("الاشعارات"),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemBuilder: (context, index) => NotificationItem(model: list[index]),
              itemCount: list.length,
            ),
    );
  }
}