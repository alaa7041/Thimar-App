import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/generated/locale_keys.g.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../features/auth/forget_password/bloc.dart';
import '../confirm_code/view.dart';


class ForgetPasswordView extends StatefulWidget {
  final String phone;
  final bool isActive;

  const ForgetPasswordView({
    Key? key,
    this.phone = "",
    this.isActive = false,
  }) : super(key: key);

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final  bloc = KiwiContainer().resolve<ForgetPasswordBloc>();

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
            ListView(
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
                  LocaleKeys.forgetPassword.tr(),
                  style: TextStyle(
                    color: const Color(0xff4C8613),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  LocaleKeys.enterPhone.tr(),
                  style: TextStyle(
                    color: const Color(0xff4C8613),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Form(
                  key: bloc.formKey,
                  child: AppInput(
                    isPhone: true,
                    hintText: "رقم الجوال",
                    controller: bloc.phoneController,
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
                    text: LocaleKeys.confirmPhone.tr(),
                    onPress: () {
                      navigateTo(ConfirmCodeView(
                          phone: widget.phone, isActive: widget.isActive));
                    },
                  ),
                ),
                SizedBox(height: 45.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.haveAccount.tr(),
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: const Color(0xff4C8613),
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        LocaleKeys.registerNow.tr(),
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
            )
          ],
        ),
      ),
    );
  }
}
