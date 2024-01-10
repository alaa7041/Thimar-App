import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/logic/helper_methods.dart';

import '../../../core/logic/cache_helper.dart';
import '../../home/view.dart';
import '../login/view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (CacheHelper.getToken().isEmpty){
        navigateTo(const LoginView());
      }else{
        navigateTo(const HomeView());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Image(
            image: AssetImage("assets/images/splash_bg.png"),
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            right: -150.w,
            bottom: -80.w,
            child: const Image(
              image: AssetImage("assets/images/splash_image.png"),
            ),
          ),
          //logo
          Center(
            child: FadeInDown(
              child: FadeInUp(
                child: const Image(
                  image: AssetImage("assets/images/logo.png"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
