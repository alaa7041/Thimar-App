import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../core/design/app_button.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../features/auth/confirm_code/bloc.dart';
import '../../../features/auth/confirm_code/events.dart';
import '../../../features/auth/confirm_code/states.dart';
import '../register/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ConfirmCodeView extends StatefulWidget {
  final bool isActive;
  final String phone;

  const ConfirmCodeView({Key? key, required this.phone, required this.isActive})
      : super(key: key);

  @override
  State<ConfirmCodeView> createState() => _ConfirmCodeViewState();
}

class _ConfirmCodeViewState extends State<ConfirmCodeView> {
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          ConfirmCodeBloc bloc = BlocProvider.of(context);
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  const Image(
                    image: AssetImage("assets/images/splash_bg.png"),
                    fit: BoxFit.fill,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  ListView(
                    padding: const EdgeInsets.all(20).w,
                    children: [
                      const Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Image(
                          image: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        widget.isActive ? "تفعيل الحساب" : "نسيت كلمة المرور",
                        style: TextStyle(
                          color: const Color(0xff4C8613),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        "أدخل الكود المكون من 4 أرقام المرسل علي رقم الجوال",
                        style: TextStyle(
                          color: const Color(0xff4C8613),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            "+9660548745",
                            textDirection: TextDirection.ltr,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                "تغيير رقم الجوال",
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      PinCodeTextField(
                        controller: bloc.codeController,
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 4,
                        blinkWhenObscuring: true,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(15.r),
                          fieldHeight: 60.h,
                          fieldWidth: 70.w,
                          inactiveColor: const Color(0xfff3f3f3455),
                          selectedColor: Theme.of(context).primaryColor,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      BlocBuilder(
                        bloc: bloc,
                        builder: (context, state) => AppButton(
                          isLoading: state is ConfirmCodeLoadingState,
                          text: "تأكيد الكود",
                          onPress: () {
                            bloc.add(ConfirmCodeEvent(isActive: widget.isActive, phone: widget.phone));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      Text(
                        "لم تستلم الكود؟ \n يمكنك إعادة إرسال الكود",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 2.h,
                        ),
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      !bloc.isTimerFinished
                          ? CircularCountDownTimer(
                        duration: 5,
                        initialDuration: 0,
                        width: 60.w,
                        height: 60.h,
                        ringColor: Theme.of(context).primaryColor,
                        fillColor: const Color(0xffD8D8D8),
                        strokeWidth: 3.0,
                        isReverseAnimation: true,
                        textStyle: TextStyle(
                            fontSize: 21.0.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                        textFormat: CountdownTextFormat.MM_SS,
                        onComplete: () {
                          bloc.isTimerFinished = true;
                          setState(() {});
                        },
                      )
                          : Center(
                        child: OutlinedButton(
                          onPressed: () async {
                            bloc.add(ResendCodeEvent(phone: widget.phone));
                            bloc.isTimerFinished = false;
                            setState(() {});
                          },
                          child: const Text(
                            "إعادة الإرسال",
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ليس لديك حساب ؟",
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: const Color(0xff4C8613),
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(const RegisterView());
                            },
                            child: Text(
                              " تسجيل الأن",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: const Color(0xff4C8613),
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
    );
  }
}
