import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/controller/DioHelper/DioHelper.dart';
import 'package:newsapp/controller/SharedPref/SharedPref.dart';
import 'package:newsapp/layout/cubit/NewsCubit.dart';
import 'package:newsapp/layout/cubit/NewsStates.dart';

import 'layout/NewsBotNavBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  // bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final bool isDark;
  //
  // MyApp(this.isDark); // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => NewsCubit()
              ..getBusiness()
              ),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<NewsCubit>(context);
          return MaterialApp(
            title: 'NewsApp',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black,
                      statusBarBrightness: Brightness.light),
                  actionsIconTheme: IconThemeData(color: Colors.black),
                ),
                textTheme: const TextTheme(
                    bodyText1: TextStyle(color: Colors.black, fontSize: 18),),
                scaffoldBackgroundColor: Colors.white,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    backgroundColor: Colors.white)),
            darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: const Color(0xff333739),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.grey,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  actionsIconTheme: IconThemeData(color: Colors.white),
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarBrightness: Brightness.dark),
                ),
                textTheme: const TextTheme(
                    bodyText1: TextStyle(color: Colors.white, fontSize: 18)),
                bottomNavigationBarTheme:
                    BottomNavigationBarThemeData(backgroundColor: Colors.grey)),
            themeMode: (cubit.isDark) ? ThemeMode.dark : ThemeMode.light,
            home: NewsBotNavBar(),
          );
        },
      ),
    );
  }
}
