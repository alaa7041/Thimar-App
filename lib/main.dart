import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thimar/features/auth/login/events.dart';
import 'package:thimar/features/auth/register/events.dart';
import 'package:thimar/features/categories/events.dart';
import 'package:thimar/features/sliders/events.dart';
import 'package:thimar/views/auth/register/view.dart';
import 'package:thimar/views/auth/splash_screen/view.dart';
import 'package:thimar/views/home/pages/cart/view.dart';
import 'package:thimar/views/home/pages/end_order/view.dart';
import 'package:thimar/views/home/view.dart';
import 'core/logic/cache_helper.dart';
import 'core/logic/helper_methods.dart';
import 'features/auth/confirm_code/bloc.dart';
import 'features/auth/forget_password/bloc.dart';
import 'features/auth/login/bloc.dart';
import 'features/auth/login/states.dart';
import 'features/auth/register/bloc.dart';
import 'features/auth/register/states.dart';
import 'features/auth/reset_password/bloc.dart';
import 'features/categories/bloc.dart';
import 'features/get_cities/bloc.dart';
import 'features/get_cities/events.dart';
import 'features/get_cities/states.dart';
import 'features/home/pages/cart/bloc.dart';
import 'features/home/pages/cart/events.dart';
import 'features/products/bloc.dart';
import 'features/sliders/bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'views/auth/login/view.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: getMaterialColor(),
  ));
  runApp(const StartView());
}


class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SliderBloc()..add(GetSliderDataEvent()),),
          BlocProvider(create: (context) => CategoriesBloc()..add(GetCategoriesEvent()),),
          BlocProvider(create: (context) => ProductBloc()..getData(),),
          BlocProvider(create: (context) => GetCitiesBloc(GetCitiesStates())..add(GetCitiesEvent()),),
          BlocProvider(create: (context) => ConfirmCodeBloc(),),
          BlocProvider(create: (context) => RegisterBloc()..add(RegisterEvent())),
          BlocProvider(create: (context) => ForgetPasswordBloc(),),
          BlocProvider(create: (context) => ResetPasswordBloc(),),
          BlocProvider(create: (context) => LoginBloc()..add(LoginEvent()),),
          BlocProvider(create: (context) => CartBloc()..add(CartEvent()),),
        ],
        child: ScreenUtilInit(
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
            builder: (context, child) =>
                Directionality(textDirection: TextDirection.rtl, child: child!),
            title: "Thimar",
            home: child,
          ),
          child: const  HomeView(),
        )
    );
  }
}
//01061659611

