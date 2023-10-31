import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../core/logic/cashe_helper.dart';
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
    Timer(Duration(seconds: 7), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CasheHelper.isAuth()?
              HomeView():LoginView(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image(
            image: AssetImage("assets/images/splash_bg.png"),
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            right: -150,
            bottom: -80,
            child: Image(
              image: AssetImage("assets/images/img1.png"),
            ),
          ),
          //logo
          Center(
            child: FadeInDown(
              child: FadeInUp(
                child: Image(
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
