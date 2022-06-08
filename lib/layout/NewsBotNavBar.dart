import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/NewsCubit.dart';
import 'package:newsapp/layout/cubit/NewsStates.dart';
import 'package:newsapp/view/screens/SearchScreen.dart';

class NewsBotNavBar extends StatelessWidget {
  const NewsBotNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        NewsCubit cubit= BlocProvider.of<NewsCubit>(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App'
            ),
            actions: [
              IconButton(onPressed: ()
              {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => SearchScreen()),
                    ModalRoute.withName('/')
                );
              }, icon: Icon(Icons.search_outlined,)),
              IconButton(onPressed: ()
              {
                cubit.changeThemeMode();
              }, icon: Icon(Icons.brightness_4_outlined,)),
            ],
          ),
        bottomNavigationBar:BottomNavigationBar(
          items: cubit.newsNavBar,
          currentIndex: cubit.currentIndex,
          onTap: (index)
          {
            cubit.changeIndex(index);
          },
          type:BottomNavigationBarType.fixed ,
          elevation: 20.0,
          selectedItemColor: Colors.deepOrange,
        ) ,
          body: cubit.screens[cubit.currentIndex],

        );
      },
    );
  }
}
