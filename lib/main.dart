import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_app/cuibt/cuibt.dart';
import 'package:flutter_application_1/layout/social_app/cuibt/cuibt.dart';
import 'package:flutter_application_1/layout/social_app/soical_layout.dart';
import 'package:flutter_application_1/modules/social_app/social_login/social_login_screen.dart';
import 'package:flutter_application_1/shared/components/constants.dart';
import 'package:flutter_application_1/shared/cubit/cubit.dart';
import 'package:flutter_application_1/shared/cubit/states.dart';
import 'package:flutter_application_1/shared/network/local/cache_helper.dart';
import 'package:flutter_application_1/shared/remote/dio_helper.dart';
import 'package:flutter_application_1/shared/styles/bloc_ofserver.dart';
import 'package:flutter_application_1/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  // ignore: unused_local_variable
  var isDark = CacheHelper.getData(key: ('isDark'));
  Widget widget;
  // var onBoarding = CacheHelper.getData(key: 'onBoarding');
  // token = CacheHelper.getData(key: 'token');
  uId = CacheHelper.getData(key: 'uId');

  // if (onBoarding != null) {
  //   if (token != null) {
  //     widget = Shoplayout();
  //   } else {
  //     widget = LoginShop_Screen();
  //   }
  // } else {
  //    widget = const OnboardingScreen();
  // }

  if (uId != null) {
    widget = SoicalLayout();
  } else {
    widget = SocialLoginScreen();
  }
  // print("token is ${token}");
  runApp(MyApp(
    isDark: false,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool isDark;
  MyApp({
    super.key,
    required this.startWidget,
    required this.isDark,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext build) => AppCubit()
              ..changeAppMode(
                fromShared: isDark,
              )),
        BlocProvider(
          create: (BuildContext build) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            // ..getFavorites()
            ..getUserData(),
        ),
        BlocProvider(
            create: (BuildContext build) => SocialCuibt()..getUserdata())
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home:startWidget,
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
