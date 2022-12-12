import 'dart:io';
import '../../modules/social_app/login/social_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

// void signOut(context){
//
//     CacheHelper.removeData(key: 'token').then((value) {
//       navigateAndFinish(context, ShopLoginScreen());
//     });}


void socialSignOut(context){

    CacheHelper.removeData(key: 'uId').then((value) {
      navigateAndFinish(context, SocialLoginScreen());
    });}

void printFullText(String text){
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String getOS(){
  return Platform.operatingSystem.toString();
}

String? token;

String? uId;