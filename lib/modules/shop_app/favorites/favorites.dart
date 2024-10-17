import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_app/cuibt/cuibt.dart';
import 'package:flutter_application_1/layout/shop_app/cuibt/state.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_application_1/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(builder: (context,state){
      return ListView.separated(itemBuilder: (context,index)=>buildFavItem(), separatorBuilder: (context,index)=>myDivider(), itemCount: 10,);
    }, listener: (context,state){}) ;
  }

  Widget buildFavItem()=>Padding(
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
                  image: NetworkImage('https://student.valuxapps.com/storage/uploads/products/1615442168bVx52.item_XXL_36581132_143760083.jpeg'),
                  width: 120,
                  height: 120,
            
                  // fit: BoxFit.cover,
                ),
                if (1 != 0)
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
                    'name',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.3, fontSize: 12.0),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        'price: 2000',
                        style: TextStyle(
                            height: 1.3, fontSize: 15.0, color: defaultColor),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (1 != 0)
                        Text(
                          '2000',
                          style: TextStyle(
                            height: 1.3,
                            fontSize: 12.0,
                            color: Colors.black,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            // ShopCubit.get(context).changeFavorites(model.id);
                            
                          },
                          icon: CircleAvatar(
                            radius: 20,
                            backgroundColor: defaultColor,
                            child: Icon(
                              // ShopCubit.get(context).favorites[model.id]!
                                   Icons.favorite,
                              //     : Icons.favorite_border_outlined,
                              size: 20,
                            ),
                          )),
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
