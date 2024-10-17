import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_app/cuibt/cuibt.dart';
import 'package:flutter_application_1/layout/shop_app/cuibt/state.dart';
import 'package:flutter_application_1/modules/shop_app/search/search.dart';
import 'package:flutter_application_1/shared/components/components.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Shoplayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('data'),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigateto(context, ShopSearch());
                    },
                    icon: Icon(Icons.search))
              ],
            ),
            body: cubit.bottomScreens[cubit.current_index],
            bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  cubit.ChangeBottom(index);
                },
                currentIndex: cubit.current_index,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.apps), label: 'cateogires'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: 'Favorites'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'settings'),
                ]),
          );
        },
        listener: (context, state) {});
  }
}
