import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/modules/social_app/login/cubit/states.dart';

import '../../../../layout/social_app/social_layout.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());
  static SocialLoginCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  // late SocialLoginModel? shopLoginModel;

  void is1password (){
    isPassword = !isPassword;
    emit(SocialIsPasswordState());
  }

  void login({
    required String email,
    required String password,
    required context,
}){
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      emit(SocialLoginSuccessState(value.user!.uid));
      CacheHelper.saveData(
          key: 'uId', value: value.user!.uid)
          .then((value) {
        // var uId = state.uId;
        navigateAndFinish(context, SocialLayout());
      });
      // print(value.user!.email);
    }).catchError((onError){
      emit(SocialLoginErrorState(onError));
      print(onError.toString());
    });
  }

}