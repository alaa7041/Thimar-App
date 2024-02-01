import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import '../../../../core/design/app_image.dart';
import '../../../../features/home/pages/my_account/bloc.dart';
import 'component/account_items.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
   final bloc = KiwiContainer().resolve<MyAccountBloc>()
    ..add(MyAccountEvent());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              height: 217.h,
              width: 375.w,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r),
                ),
              ),
              child: BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is MyAccountFailedState) {
                    return  Text(state.msg);
                  } else if (state is MyAccountSuccessState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 33.h),
                        Text(
                          "حسابي",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 23.h),
                        Container(
                          width: 76.w,
                          height: 71.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),

                          ),
                          child: AppImage(
                            path: state.model.data.image,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          state.model.data.fullName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          state.model.data.phone,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
            AccountItem(),
          ],
        ),
      ),
    );
  }
}
