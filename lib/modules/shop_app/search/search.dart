import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/shop/home_model.dart';
import 'package:flutter_application_1/modules/shop_app/search/cuibt/cuibt.dart';
import 'package:flutter_application_1/modules/shop_app/search/cuibt/states.dart';

import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_application_1/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var seacrchcontroller = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCuibt(),
      child: BlocConsumer<SearchCuibt, SearchStates>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                        type: TextInputType.text,
                        controller: seacrchcontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Search is empty';
                          }
                          return null;
                        },
                        onSubmit: (String text) {
                          SearchCuibt.get(context).search(text);
                        },
                        prefix: Icons.search,
                        label: 'Search',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (state is SearchloadingState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                          child: ListView.separated(
                        itemBuilder: (context, index) => buildFavItem(
                            SearchCuibt.get(context)
                                .searchModel!
                                .data!
                                .data[index] as ProductModel,
                            context),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: SearchCuibt.get(context)
                            .searchModel!
                            .data!
                            .data
                            .length,
                      ))
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {}),
    );
  }

  Widget buildFavItem(ProductModel model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.image),
                    width: 120,
                    height: 120,

                    // fit: BoxFit.cover,
                  ),
                  if (model.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(height: 1.3, fontSize: 12.0),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          model.price,
                          style: TextStyle(
                              height: 1.3, fontSize: 15.0, color: defaultColor),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        // if (model.discount != 0)
                        //   Text(
                        //     model.oldPrice,
                        //     style: TextStyle(
                        //       height: 1.3,
                        //       fontSize: 12.0,
                        //       color: Colors.black,
                        //       decoration: TextDecoration.lineThrough,
                        //     ),
                        //   ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
