import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/NewsCubit.dart';
import 'package:newsapp/layout/cubit/NewsStates.dart';

class WebViewScreen extends StatelessWidget {
String url;

WebViewScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          appBar: AppBar(),
          body: Column(),
          // body: WebView(
          //   initialUrl: url,
          // ),
        );
      },
    );
  }
}
