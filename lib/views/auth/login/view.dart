import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../features/auth/login/bloc.dart';
import '../../../generated/locale_keys.g.dart';
import '../forget_password/view.dart';
import '../register/view.dart';


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final bloc = KiwiContainer().resolve<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Image(
              image: AssetImage("assets/images/splash_bg.png"),
              fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity,
            ),
            Form(
              key: bloc.formKey,
              child: ListView(
                padding: EdgeInsets.all(20.w),
                children: [
                  const Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Image(
                      image: AssetImage("assets/images/logo.png"),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    LocaleKeys.welcomeAgain.tr(),
                    style: TextStyle(
                      color: const Color(0xff4C8613),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                   SizedBox(height: 16.h),
                  Text(
                    "يمكنك تسجيل الدخول الأن",
                    style: TextStyle(
                      color: const Color(0xff4C8613),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AppInput(
                    paddingTop: 28.w,
                    hintText: "رقم الجوال",
                    icon: "assets/images/phone_icon.png",
                    isPhone: true,
                    controller: bloc.phoneController,
                    paddingBottom: 16.w,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return " رقم الهاتف مطلوب";
                      } else if (value.length < 9) {
                        return " يجب ان يكون رقم الهاتف 9 ارقام";
                      }
                      return null;
                    },
                  ),
                  AppInput(
                    hintText: "كلمة المرور",
                    icon: "assets/icons/look1.png",
                    isPassword: true,
                    controller: bloc.passwordController,
                    paddingBottom: 19.w,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "كلمة المرور مطلوبه";
                      } else if (value.toString().length < 6) {
                        return "كلمة المرور ضعيفه";
                      }
                      return null;
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      navigateTo(const ForgetPasswordView());
                    },
                    child: Text(
                      "نسيت كلمة المرور ؟",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0xff707070),
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  SizedBox(height: 22.h),
                  BlocBuilder(
                    bloc: bloc,
                    builder: (context, state) => AppButton(
                      isLoading: state is LoginLoadingState,
                      text: "تسجيل الدخول",
                      onPress: () {
                        bloc.add(LoginEvent());
                      },
                    ),
                  ),
                  SizedBox(height: 45.h),
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
