import 'package:flutter/material.dart';
import '../../../core/design/app_button.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../confirm_code/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class ForgetPasswordView extends StatefulWidget {
  final String phone;
  final bool isActive;

  const ForgetPasswordView({
    Key? key,
    this.phone = "",
    this.isActive = false,
  }) : super
      (key: key);

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        ForgetPasswordBloc bloc = BlocProvider.of(context);
        return Scaffold(
          body: SafeArea(
            child: Stack(
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
                      "نسيت كلمة المرور",
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
                      "أدخل رقم الجوال المرتبط بحسابك",
                      style: TextStyle(
                        color: Color(0xff4C8613),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: AppInput(
                        isPhone: true,
                        hintText: "رقم الجوال",
                        controller: phoneController,
                        icon: "assets/images/phone_icon.png",
                        paddingBottom: 21,
                        paddingTop: 27,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return " رقم الهاتف مطلوب";
                          } else if (value.length < 9) {
                            return " يجب ان يكون رقم الهاتف 9 ارقام";
                          }
                          return null;
                        },
                      ),
                    ),
                    BlocBuilder(
                      bloc: bloc,
                      builder: (context, state) => AppButton(
                        text: "تأكيد رقم الجوال",
                        onPress: () {

                          navigateTo(ConfirmCodeView(phone: widget.phone,
                          isActive: widget.isActive));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 45,
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
                          onPressed: () {},
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
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
