 import 'package:flutter/material.dart';
 import 'package:flutter_screenutil/flutter_screenutil.dart';


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
          itemBuilder: (context, index) => const _Item(),
          itemCount: 4,
          padding: const EdgeInsets.all(16)),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            offset: const Offset(0, 6),
            blurRadius: 17,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      height: 130.h,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "طلب #4587",
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                "يونيو,2021,27",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff9C9C9C),
                ),
              ),
              SizedBox(
                height: 13.h,
              ),
              Row(
                children: [
                  ...List.generate(
                      3,
                      (index) => Container(
                        height: 35.h,
                        width: 35.w,
                        margin: EdgeInsetsDirectional.only(end: 3.w),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.r),
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xffEDF5E6).withOpacity(.6),
                          ),
                        ),
                        child: Image.network(
                          "https://images.fineartamerica.com/images/artworkimages/mediumlarge/2/two-tomatoes-with-clipping-path-ursula-alter.jpg",
                          fit: BoxFit.fill,
                        ),
                      )),
                  Container(
                    height: 35.h,
                    width: 35.w,
                    margin: EdgeInsetsDirectional.only(end: 3.w),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.r),
                      color: const Color(0xffEDF5E6),
                      border: Border.all(
                        color: const Color(0xffEDF5E6).withOpacity(.6),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "2+",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(right: 15.w),
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
                height: 23,
                width: 95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.r),
                  color: Theme.of(context).primaryColor.withOpacity(.13),
                ),
                child: Center(
                  child: Text(
                    "بإنتظار الموافقة",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              ),
              Text(
                "180ر.س",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
