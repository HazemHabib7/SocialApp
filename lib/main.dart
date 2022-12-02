import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:udemy/desktop_secreen.dart';
import 'package:udemy/layout/shop_app/cubit/cubit.dart';
import 'package:udemy/layout/shop_app/shop_layout.dart';
import 'package:udemy/layout/social_app/social_layout.dart';
import 'package:udemy/mobile_screen.dart';
import 'package:udemy/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:udemy/modules/shop_app/register/cubit/cubit.dart';
import 'package:udemy/modules/social_app/login/social_login_screen.dart';
import 'package:udemy/shared/bloc_observer.dart';
import 'package:udemy/shared/components/components.dart';
import 'package:udemy/shared/components/constants.dart';
import 'package:udemy/shared/network/local/cache_helper.dart';
import 'package:udemy/shared/network/remote/dio_helper.dart';
import 'package:udemy/shared/simple_bloc_observer.dart';
import 'package:udemy/shared/styles/themes.dart';
import 'layout/news_app/cubit/cubit.dart';
import 'layout/news_app/cubit/dark_mode_cubit.dart';
import 'layout/news_app/cubit/dark_mode_states.dart';
import 'layout/news_app/news_layout.dart';
import 'layout/social_app/cubit/cubit.dart';

// Future<void> firebaseMessagingBackgroundHandler (RemoteMessage message) async{
//   print('onBackgroundMessage');
//   print(message.data.toString());
//   defaultToast(message: 'onBackgroundMessage', state: ToastStates.SUCCESS);
// }

void main() {
  Bloc.observer = MyBlocObserver();
  BlocOverrides.runZoned(
        () async{
          WidgetsFlutterBinding.ensureInitialized();

          // if(Platform.isWindows)
          //   await DesktopWindow.setMinWindowSize(Size(300, 400));

          // await Firebase.initializeApp();
          // var socialToken = FirebaseMessaging.instance.getToken();
          // print(socialToken);
          //
          // FirebaseMessaging.onMessage.listen((event) {
          //   print('onMessage');
          //   print(event.data.toString());
          //   defaultToast(message: 'onMessage', state: ToastStates.SUCCESS);
          // });
          //
          // FirebaseMessaging.onMessageOpenedApp.listen((event) {
          //   print('onMessageOpenedApp');
          //   print(event.data.toString());
          //   defaultToast(message: 'onMessageOpenedApp', state: ToastStates.SUCCESS);
          // });
          //
          // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
          //
          DioHelper.init();
          await CacheHelper.init();
          Widget widget;
          bool? isDark = CacheHelper.getData(key: 'isDark');
          bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
          token = CacheHelper.getData(key: 'token');
          uId = CacheHelper.getData(key: 'uId');
          // if(onBoarding != null){
          //   if(token != null){
          //     widget=ShopLayout();
          //   }
          //   else{
          //     widget=ShopLoginScreen();
          //   }
          // }
          // else widget =OnBoardingScreen();
          if(uId != null){
            widget = SocialLayout();
          }
          else {
            widget = SocialLoginScreen();
          }
          runApp(MyApp(isDark: isDark,widget: widget,));
        },
    // blocObserver: SimpleBlocObserver(),
  );
}


class MyApp extends StatelessWidget{
  bool? isDark;
  Widget widget;
  MyApp({this.isDark,required this.widget});

  @override
  Widget build(BuildContext context){
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData(),),
        BlocProvider(create: (context) => NewsCubit()..getBusiness(),),
        BlocProvider(create: (context) => DarkModeCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => SocialCubit()..getUserData()..getPosts()),
      ],
      child: BlocConsumer<DarkModeCubit,DarkStates>(
        listener: (context, state) {},
        builder: (context, state) {
          DarkModeCubit cubit = DarkModeCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home:Builder(
              builder: (context) {
                if(MediaQuery.of(context).size.width <= 765)
                      return MediaQuery(data: MediaQueryData(
                        textScaleFactor: 0.8,
                      ), child: MobileScreen());
                      return DesktopScreen();
              },
            ),
            // LayoutBuilder(
            //     builder: (BuildContext context, BoxConstraints constraints) {
            //       print(constraints.minWidth.toInt());
            //       if(constraints.minWidth.toInt() <= 765)
            //       return MobileScreen();
            //       return DesktopScreen();
            //     },
            // ),
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:cubit.mode ? ThemeMode.dark:ThemeMode.light,
          );
        },
      ),
    );
  }
}