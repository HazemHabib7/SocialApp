import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/modules/social_app/login/cubit/cubit.dart';
import 'package:udemy/shared/bloc_observer.dart';
import 'package:udemy/shared/components/constants.dart';
import 'package:udemy/shared/network/local/cache_helper.dart';
import 'layout/social_app/cubit/cubit.dart';
import 'layout/social_app/social_layout.dart';
import 'modules/social_app/login/social_login_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  BlocOverrides.runZoned(
        () async{
          WidgetsFlutterBinding.ensureInitialized();
          await Firebase.initializeApp();
          await CacheHelper.init();
          Widget widget;
          uId = CacheHelper.getData(key: 'uId');
          if(uId != null){
            widget = SocialLayout();
          }
          else {
            widget = SocialLoginScreen();
          }
          runApp(MyApp(widget: widget,));
        },
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
        BlocProvider(create: (context) => SocialLoginCubit()),
        BlocProvider(create: (context) => SocialCubit()..getUserData()..getPosts()),
      ],
      child: BlocConsumer<SocialCubit,SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: widget,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarBrightness: Brightness.dark,
                ),
                color: Colors.white,
                elevation: 0.0,
                titleSpacing: 14.0,
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}