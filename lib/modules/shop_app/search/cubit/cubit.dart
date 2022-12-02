import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/models/search_model.dart';
import 'package:udemy/modules/shop_app/search/cubit/states.dart';
import 'package:udemy/shared/components/constants.dart';
import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void search({
    required String text,
  }){
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text':text,
      },
        ).then((value) {
      emit(SearchSuccessState());
      searchModel=SearchModel.fromJson(value.data);
    }).catchError((onError){
      emit(SearchErrorState());
      print("Error: " + onError.toString());

    });
  }

}