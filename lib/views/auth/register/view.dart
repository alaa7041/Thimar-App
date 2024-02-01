import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/generated/locale_keys.g.dart';

import '../../../core/design/app_button.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../features/auth/register/bloc.dart';
import '../../sheets/cities.dart';
import '../login/view.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final bloc = KiwiContainer().resolve<RegisterBloc>();

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
                  SizedBox(height: 21.h),
                  Text(
                    LocaleKeys.welcomeAgain.trim(),
                    style: TextStyle(
                      color: const Color(0xff4C8613),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    LocaleKeys.createNewAccount.tr(),
                    style: TextStyle(
                      color: const Color(0xff4C8613),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AppInput(
                    controller: bloc.fullNameController,
                    paddingTop: 22.w,
                    hintText: LocaleKeys.userName.tr(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.userNameRequired.tr();
                      }
                      return null;
                    },
                    icon: "assets/icons/username.png",
                    paddingBottom: 16.w,
                  ),
                  AppInput(
                    controller: bloc.phoneController,
                    hintText: LocaleKeys.phoneNumber.tr(),
                    icon: "assets/images/phone_icon.png",
                    isPhone: true,
                    paddingBottom: 16.w,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.phoneNumberRequired.tr();
                      } else if (value.length < 9) {
                        return LocaleKeys.phoneValidation.tr();
                      }
                      return null;
                    },
                  ),
                  StatefulBuilder(
                    builder: (context, setState) => GestureDetector(
                      onTap: () async {
                        var result = await showModalBottomSheet(
                          context: context,
                          builder: (context) => const CitiesSheet(),
                        );
                        if (result != null) {
                          bloc.selectedCity = result;
                          setState(() {});
                          print("the result is ${bloc.selectedCity!.name}");
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AbsorbPointer(
                              absorbing: true,
                              child: AppInput(
                                isText: TextInputType.none,
                                hintText: bloc.selectedCity?.name ??
                                    LocaleKeys.city.tr(),
                                icon: "assets/icons/city.png",
                                paddingBottom: 0.w,
                                validator: (value) {
                                  if (bloc.selectedCity == null) {
                                    return LocaleKeys.choseCity.tr();
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          if (bloc.selectedCity != null)
                            IconButton(
                              icon: Icon(
                                Icons.clear,
                                size: 24.w,
                              ),
                              onPressed: () {
                                bloc.selectedCity = null;
                                setState(() {});
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  AppInput(
                    controller: bloc.passwordController,
                    hintText: LocaleKeys.password.tr(),
                    icon: "assets/icons/look1.png",
                    isPassword: true,
                    paddingBottom: 16.w,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return LocaleKeys.passwordRequired;
                      } else if (value.toString().length < 6) {
                        return LocaleKeys.weakPassword.tr();
                      }
                      return null;
                    },
                  ),
                  AppInput(
                    controller: bloc.confirmPasswordController,
                    hintText: LocaleKeys.password.tr(),
                    icon: "assets/icons/look1.png",
                    isPassword: true,
                    paddingBottom: 24.w,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return LocaleKeys.passwordRequired.tr();
                      } else if (value != bloc.passwordController.text) {
                        return LocaleKeys.passwordIdentical;
                      }
                      return null;
                    },
                  ),
                  BlocBuilder(
                    bloc: bloc,
                    builder: (context, state) => AppButton(
                      text: "تسجيل ",
                      isLoading: state is RegisterLoadingStates,
                      onPress: () {
                        bloc.add(RegisterEvent());
                      },
                    ),
                  ),
                  SizedBox(height: 30.h),
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
                        onPressed: () {
                          navigateTo(const LoginView());
                        },
                        child: Text(
                          LocaleKeys.register.tr(),
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
