

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/modules/shop_app/register/cubit/states.dart';
import 'package:udemy/shared/network/end_points.dart';

import '../../../../models/login_model.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  late ShopLoginModel? shopLoginModel;

  void is1password (){
    isPassword = !isPassword;
    emit(RegisterIsPasswordState());
  }

  void register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }){
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        }).then((value) {
          shopLoginModel=ShopLoginModel.fromjson(value.data);
          emit(RegisterSuccessState(shopLoginModel!));
    }).catchError((onError){
      emit(RegisterErrorState());
      print("Error: " + onError.toString());

    });
  }
}