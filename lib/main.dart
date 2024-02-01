import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/Kiwi.dart';
import 'package:thimar/views/auth/splash_screen/view.dart';
import 'core/logic/cache_helper.dart';
import 'core/logic/helper_methods.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: getMaterialColor(),
  ));
  initKiwi();
  runApp(const StartView());
}

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: getMaterialColor(),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          primarySwatch: getMaterialColor(),
          scaffoldBackgroundColor: Colors.white,
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              fixedSize: const Size.fromHeight(60),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: const OutlineInputBorder(),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xffF3F3F3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xffF3F3F3),
              ),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              side: BorderSide(
                color: getMaterialColor(),
              ),
            ),
          ),
        ),
        builder: (context, child) => Directionality(textDirection: TextDirection.rtl, child: child!),
        title: "Thimar",
        home: child,
      ),
      child: const SplashView(),
    );
  }
}
//01061659611

