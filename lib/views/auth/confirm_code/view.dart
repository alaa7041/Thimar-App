import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/design/app_button.dart';
import '../../../core/logic/helper_methods.dart';
import '../register/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'events.dart';
import 'states.dart';

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
                  Image(
                    image: AssetImage("assets/images/splash_bg.png"),
                    fit: BoxFit.fill,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  ListView(
                    padding: EdgeInsets.all(20),
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Image(
                          image: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        widget.isActive ? "تفعيل الحساب" : "نسيت كلمة المرور",
                        style: TextStyle(
                          color: Color(0xff4C8613),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "أدخل الكود المكون من 4 أرقام المرسل علي رقم الجوال",
                        style: TextStyle(
                          color: Color(0xff4C8613),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "+9660548745",
                            textDirection: TextDirection.ltr,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "تغيير رقم الجوال",
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 22,
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
                          borderRadius: BorderRadius.circular(15),
                          fieldHeight: 60,
                          fieldWidth: 70,
                          inactiveColor: Color(0xffF3F3F3455),
                          selectedColor: Theme.of(context).primaryColor,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 22,
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
                      SizedBox(
                        height: 45,
                      ),
                      Text(
                        "لم تستلم الكود؟ \n يمكنك إعادة إرسال الكود",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 2,
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      !bloc.isTimerFinished
                          ? CircularCountDownTimer(
                        duration: 5,
                        initialDuration: 0,
                        width: 60,
                        height: 60,
                        ringColor: Theme.of(context).primaryColor,
                        fillColor: Color(0xffD8D8D8),
                        strokeWidth: 3.0,
                        isReverseAnimation: true,
                        textStyle: TextStyle(
                            fontSize: 21.0,
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
                          child: Text(
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
                              fontSize: 15,
                              color: Color(0xff4C8613),
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(RegisterView());
                            },
                            child: Text(
                              " تسجيل الأن",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff4C8613),
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
