import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'model.dart';

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
    await Future.delayed(Duration(seconds: 3));
    isLoading = false;
    setState(() {

    });
    print("alaa");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text("الاشعارات"),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) => _Item(model: list[index]),
              itemCount: list.length,
            ),
    );
  }
}

class _Item extends StatelessWidget {
  final NotificationModel model;

  const _Item({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16).w,
      child: Row(
        children: [
          Container(
            width: 33.h,
            height: 33.h,
            padding: EdgeInsets.all(6.5.w),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(.13),
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: Image.network(model.image),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
              Text(
                model.body,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w300,
                  color: Color(0xff989898),
                ),
              ),
              Text(
                model.time,
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }
}
