import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/models/social_user_model.dart';
import 'package:udemy/modules/social_app/register/cubit/states.dart';
import '../../../../layout/social_app/social_layout.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/network/local/cache_helper.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  bool loading = false;

  void registerIs1password() {
    isPassword = !isPassword;
    emit(RegisterIsPasswordState());
  }

  void register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required context,
  }) {
    emit(SocialRegisterLoadingState());
    loading = true;
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      CacheHelper.saveData(
          key: 'uId', value: value.user!.uid)
          .then((value) {
        // var uId = state.uId;
        navigateAndFinish(context, SocialLayout());
      });
      // print(value.user!.email);
      // print(value.user!.uid);
      createUser(
          name: name,
          email: email,
          phone: phone,
          uId: value.user!.uid,
          context: context);
    }).catchError((onError) {
      loading = false;
      print(onError.toString());
      emit(SocialRegisterErrorState(onError));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required context,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image: 'https://thumbs.dreamstime.com/b/handsome-man-smiling-over-white-background-portrait-young-horizontal-shot-39621048.jpg',
      cover: 'https://thumbs.dreamstime.com/b/handsome-man-smiling-over-white-background-portrait-young-horizontal-shot-39621048.jpg',
      bio: 'Write your bio',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
      navigateAndFinish(context, SocialLayout());
      // print(value);
    }).catchError((onError) {
      emit(SocialCreateUserErrorState(onError));
      print(onError.toString());
    });
  }


}
