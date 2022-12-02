import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/news_app/cubit/states.dart';
import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/setting/setting_screen.dart';
import '../../../modules/news_app/sport/sport_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';
class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
    SettingScreen(),
  ];

  void changeBottomNavBar(int index){
    currentIndex = index;
    if(index==1) getSport();
    else if(index==2) getScience();

    emit(ChangeBottomNavBarState());
  }
  List<dynamic> business = [];
  // List<bool> selectedItem = [];
  List<dynamic> sport = [];
  List<dynamic> science = [];
  List<dynamic> search = [];
  bool isDesktop = false;
  int selectedItem = 0;

  void selectedItemMethod(index){
    // for(int i=0;i<selectedItem.length;i++){
    //   if(i == index){
    //     selectedItem[i] = true;
    //   }
    //   else{
    //     selectedItem[i] = false;
    //   }
    // }
    selectedItem = index;
    emit(NewsSelectedItemState());
  }

  void setDesktop(bool value){
    isDesktop=value;
    emit(NewsSetDesktopState());
  }


  void getBusiness (){
    if(business.length==0){
      emit(NewsGetBusinessLoadingState());
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'us',
            'category':'business',
            'apiKey':'e10dde71670f48a9ba65deb69b247c97',
          }).then((value) {
        business = value.data['articles'];
        // business.forEach((element) {
        //   selectedItem.add(false);
        // });
        print(business);
        emit(NewsGetBusinessSuccessState());
      }).catchError((onError){
        emit(NewsGetBusinessErrorState());
        print(onError.toString());
      });
      emit(NewsGetBusinessSuccessState());
    }
  }

  void getSport (){
    if(sport.length==0){
      emit(NewsGetSportLoadingState());
      DioHelper.getData(
          url: 'v2/everything',
          query: {
            'domains':'wsj.com',
            'apiKey':'e10dde71670f48a9ba65deb69b247c97',
          }).then((value) {
        sport = value.data['articles'];
        print(sport);
        emit(NewsGetSportSuccessState());
      }).catchError((onError){
        emit(NewsGetScienceErrorState());
        print(onError.toString());
      });
    }
    else{
      emit(NewsGetSportSuccessState());
    }
  }

  void getScience (){
    if(science.length==0)
      {
        emit(NewsGetScienceLoadingState());
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'sources':'techcrunch',
              'apiKey':'e10dde71670f48a9ba65deb69b247c97',
            }).then((value) {
          science = value.data['articles'];
          print(science);
          emit(NewsGetScienceSuccessState());
        }).catchError((onError){
          emit(NewsGetScienceErrorState());
          print(onError.toString());
        });
      }
    else{
      emit(NewsGetScienceSuccessState());
    }
  }

  void getSearch (String q){
      emit(NewsGetSearchLoadingState());
      DioHelper.getData(
          url: 'v2/everything',
          query: {
            'q':q,
            'apiKey':'e10dde71670f48a9ba65deb69b247c97',
          }).then((value) {
        search = value.data['articles'];
        print(search);
        emit(NewsGetSearchSuccessState());
      }).catchError((onError){
        emit(NewsGetSearchErrorState());
        print(onError.toString());
      });

  }


}