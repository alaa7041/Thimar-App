import 'package:flutter/material.dart';
import '../../../core/design/app_button.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../home/view.dart';
import '../register/view.dart';
import 'bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events.dart';
import 'states.dart';

class ResetPasswordView extends StatefulWidget {
  final String phone;
  final String code;

  const ResetPasswordView({Key? key, required this.phone, required this.code})
      : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        ResetPasswordBloc bloc = BlocProvider.of(context);
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
                Form(
                  key: bloc.formKey,
                  child: ListView(
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
                        "أدخل كلمة المرور الجديدة",
                        style: TextStyle(
                          color: Color(0xff4C8613),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      AppInput(
                        controller: bloc.passwordController,
                        hintText: "كلمة المرور",
                        icon: "assets/icons/look1.png",
                        isPassword: true,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "كلمة المرور مطلوبه";
                          } else if (value.toString().length < 6) {
                            return "كلمة المرور ضعيفه";
                          }
                          return null;
                        },
                      ),
                      AppInput(
                        controller: bloc.confirmPasswordController,
                        hintText: "كلمة المرور",
                        icon: "assets/icons/look1.png",
                        isPassword: true,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "كلمة المرور مطلوبه";
                          } else if (value != bloc.passwordController.text) {
                            return "كلمتا المرور غير متطابقتين";
                          }
                          return null;
                        },
                      ),
                      BlocBuilder(builder: (context, state) => AppButton(
                        isLoading: state is ResetPasswordLoadingState,
                        text: "تأكيد رقم الجوال ",
                        onPress: () {
                          bloc.add(ResetPasswordEvent(
                              phone: widget.phone, code: widget.code));
                          navigateTo(HomeView());
                        },
                      ),),
                      SizedBox(
                        height: 255,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ليس لديك حساب؟",
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
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
