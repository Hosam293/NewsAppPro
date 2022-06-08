import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/NewsCubit.dart';
import 'package:newsapp/layout/cubit/NewsStates.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder:(context,state)
      {

        List list = BlocProvider.of<NewsCubit>(context).business;
        return ConditionalBuilder(
          condition: list.length > 0,
          builder:(context) =>ListView.separated(
            separatorBuilder: (context,index) => const SizedBox(
              height: 10.0,
            ), itemCount: list.length,
            itemBuilder: (BuildContext context, int index)
            {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children:
                  [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(
                            '${list[index]['urlToImage']}'
                          ),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,

                    ),
                    Expanded(
                      child: Container(
                        height: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children:
                          [
                            Expanded(
                              child: Text(
                                '${list[index]['title']}',
                                style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.right,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              '${list[index]['publishedAt']}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },

          ) ,
          fallback: (context) => Center(child: CircularProgressIndicator(),),
        );
      } ,
    );
  }
}
