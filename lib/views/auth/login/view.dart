import 'package:flutter/material.dart';
import '../../../core/design/app_button.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../forget_password/view.dart';
import '../register/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'states.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => LoginBloc(LoginStates()),
      child: Builder(
        builder: (context) {
          LoginBloc bloc = BlocProvider.of(context);

          return Scaffold(
            body: SafeArea(
              child: Stack(
                children:  [
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
                          "مرحبا بك مرة أخرى",
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
                          "يمكنك تسجيل الدخول الأن",
                          style: TextStyle(
                            color: Color(0xff4C8613),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        //phone
                        AppInput(
                          paddingTop: 28,
                          hintText: "رقم الجوال",
                          icon: "assets/images/phone_icon.png",
                          isPhone: true,
                          paddingBottom: 16,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return " رقم الهاتف مطلوب";
                            } else if (value.length < 9) {
                              return " يجب ان يكون رقم الهاتف 9 ارقام";
                            }
                            return null;
                          },
                        ),
                        //pass
                        AppInput(
                          hintText: "كلمة المرور",
                          icon: "assets/icons/look1.png",
                          isPassword: true,
                          paddingBottom: 19,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "كلمة المرور مطلوبه";
                            } else if (value.toString().length < 6) {
                              return "كلمة المرور ضعيفه";
                            }
                            return null;
                          },
                        ),

                        TextButton(onPressed: (){
                          navigateTo(ForgetPasswordView());
                        }, child: Text(
                          "نسيت كلمة المرور ؟",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff707070),
                          ),
                          textAlign: TextAlign.end,
                        ),),
                        SizedBox(
                          height: 22,
                        ),
                        //buttom
                        BlocBuilder(
                          bloc: bloc,
                          builder: (context, state) => AppButton(
                            isLoading: state is LoginLodingState,
                            text: "تسجيل الدخول",
                            onPress: () {
                              bloc.login();
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
      ),
    );
  }
}
