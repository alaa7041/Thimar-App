import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thimar/views/auth/forget_password/bloc.dart';
import 'package:thimar/views/auth/splash_screen/view.dart';
import 'core/logic/cashe_helper.dart';
import 'core/logic/helper_methods.dart';
import 'features/categories/cubit.dart';
import 'features/get_cities/bloc.dart';
import 'features/get_cities/events.dart';
import 'features/get_cities/states.dart';
import 'features/products/cubit.dart';
import 'features/sliders/cubit.dart';
import 'views/auth/confirm_code/bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'views/auth/register/bloc.dart';
import 'views/auth/register/states.dart';
import 'views/auth/register/view.dart';
import 'views/auth/reset_password/bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CasheHelper.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: getMaterialColor(),
  ));
  runApp(StartView());
}

class StartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SliderCubit()..getSliderDataImages(),
          ),
          BlocProvider(
            create: (context) => CategoriesCubit()..getData(),
          ),
          BlocProvider(
            create: (context) => ProductCubit()..getData(),
          ),
          BlocProvider(
            create: (context) =>
                GetCitiesBloc(GetCitiesStates())..add(GetCitiesEvent()),
          ),
          BlocProvider(
            create: (context) => ConfirmCodeBloc(),
          ),
          BlocProvider(
            create: (context) => RegisterBloc(RegisterStates()),
          ),
          BlocProvider(
            create: (context) => ForgetPasswordBloc(),
          ),
          BlocProvider(
            create: (context) => ResetPasswordBloc(),
          ),
        ],
        child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          designSize: Size(375, 812),
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
                  fixedSize: Size.fromHeight(60),
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xffF3F3F3),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
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
          child: SplashView(),
        ));
  }
}

MaterialColor getMaterialColor() {
  Color color = Color(0xff4C8613);

  return MaterialColor(color.value, {
    50: color.withOpacity(0.1),
    100: color.withOpacity(0.2),
    200: color.withOpacity(0.3),
    300: color.withOpacity(0.4),
    400: color.withOpacity(0.5),
    500: color.withOpacity(0.6),
    600: color.withOpacity(0.7),
    700: color.withOpacity(0.8),
    800: color.withOpacity(0.9),
    900: color,
  });
}
