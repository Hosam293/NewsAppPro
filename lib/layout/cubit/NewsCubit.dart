import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/controller/SharedPref/SharedPref.dart';
import 'package:newsapp/layout/cubit/NewsStates.dart';
import 'package:newsapp/view/screens/BusinessScreen.dart';
import 'package:newsapp/view/screens/SportScreen.dart';
import 'package:newsapp/view/screens/ScienceScreen.dart';

import '../../controller/DioHelper/DioHelper.dart';
import '../../view/screens/SettingsScreen.dart';

class NewsCubit extends Cubit<NewsStates> {

  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of<NewsCubit>(context);
  int currentIndex = 0;

  List<BottomNavigationBarItem> newsNavBar =
  [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'Business'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sports_bar_rounded), label: 'Sport'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.science_outlined), label: 'Science'),

  ];

  void changeIndex(int index) {
    currentIndex = index;
    if(index ==1) {
      getSport();
    }
    else if(index == 2) {
      getScience();
    }

    emit(ChangeBotNavIndex());
  }

  List<Widget> screens =
  [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];
  List  business=[];

 void getBusiness() {
    emit(NewsLoadState());
    DioHelper.getData(
        url: 'v2/top-headlines', query:
    {
      'country': 'eg',
      'category': 'business',
      'apiKey': '0414a5df728d45c6a28732845daa8f20'
    }
    ).then((value)
    {
      print(value.data);
      business=value.data['articles'];
      emit(GetBusinessSuccessState());

    }).catchError((error)
    {
      print(error.toString());
      emit(GetBusinessErrorState());
    });
  }

  List  sport=[];

  void getSport() {
    emit(SportLoadState());
    DioHelper.getData(
        url: 'v2/top-headlines', query:
    {
      'country': 'eg',
      'category': 'sports',
      'apiKey': '0414a5df728d45c6a28732845daa8f20'
    }
    ).then((value)
    {
      print(value.data);
      sport=value.data['articles'];
      emit(GetSportSuccessState());

    }).catchError((error)
    {
      print(error.toString());
      emit(GetSportErrorState());
    });
  }

  List  science=[];

  void getScience() {
    emit(NewsLoadState());
    DioHelper.getData(
        url: 'v2/top-headlines', query:
    {
      'country': 'eg',
      'category': 'science',
      'apiKey': '0414a5df728d45c6a28732845daa8f20'
    }
    ).then((value)
    {
      print(value.data);
      science=value.data['articles'];
      emit(GetBusinessSuccessState());

    }).catchError((error)
    {
      print(error.toString());
      emit(GetBusinessErrorState());
    });
  }

  List  search=[];
//https://newsapi.org/v2/everything?q=bitcoin&apiKey=0414a5df728d45c6a28732845daa8f20
  void getsearch(String value) {
    emit(NewsLoadState());

    DioHelper.getData(
        url: 'v2/everything', query:
    {
      'q': value,
      'apiKey': '0414a5df728d45c6a28732845daa8f20'
    }
    ).then((value)
    {

      print(value.data);
      search=value.data['articles'];
      emit(GetBusinessSuccessState());

    }).catchError((error)
    {
      print(error.toString());
      emit(GetBusinessErrorState());
    });
  }

  bool isDark = false;
   changeThemeMode() {

       isDark = !isDark;
       emit(ChaneThemeMode());


   }

  }