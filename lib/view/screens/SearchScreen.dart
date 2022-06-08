import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/NewsCubit.dart';

import '../../layout/cubit/NewsStates.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List list = BlocProvider.of<NewsCubit>(context).search;

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: searchController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'this field must not be empty';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value)
                  {
                    NewsCubit.get(context).getsearch(value);
                  },

                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search_outlined),
                      border: OutlineInputBorder(),
                      labelText: 'Search',
                      labelStyle: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 15,

                      ),
                  ),
                ),
                ConditionalBuilder(
                  condition: list.length > 0,
                  builder: (context) => Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10.0,
                      ),
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            '${list[index]['urlToImage']}'),
                                        fit: BoxFit.cover)),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: Container(
                                  height: 120,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${list[index]['title']}',
                                          style:
                                              Theme.of(context).textTheme.bodyText1,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.right,

                                        ),
                                      ),
                                      Text(
                                        '${list[index]['publishedAt']}',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
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
                    ),
                  ),
                  fallback: (context) => Center(
                    child: Center(child:  CircularProgressIndicator()),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
