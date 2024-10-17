import 'package:flutter_application_1/models/shop/changefavorites_model.dart';
import 'package:flutter_application_1/models/shop/login_model.dart';

abstract class ShopStates {}

class ShopIntialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopCategoriesLoadingState extends ShopStates {}

class ShopCategoriesSuccessState extends ShopStates {}

class ShopCategoriesErrorState extends ShopStates {}

class ShopChangeFavoritesLoadingState extends ShopStates {}

class ShopChangeFavoritesSuccessState extends ShopStates {
  final ChangefavoritesModel model;
  ShopChangeFavoritesSuccessState(this.model);
}

class ShopChangeFavoritesErrorState extends ShopStates {}

class ShopGetFavoritesLoadingState extends ShopStates {}

class ShopGetFavoritesSuccessState extends ShopStates {}

class ShopGetFavoritesErrorState extends ShopStates {}

class ShopUserDataLoadingState extends ShopStates {}

class ShopUserDataSuccessState extends ShopStates {
  final ShopLoginModel loginModel;
   ShopUserDataSuccessState(this.loginModel);
}

class ShopUserDataErrorState extends ShopStates {}

class ShopUpdateUserDataLoadingState extends ShopStates {}

class ShopUpdateUserDataSuccessState extends ShopStates {
  final ShopLoginModel loginModel;
   ShopUpdateUserDataSuccessState(this.loginModel);
}

class ShopUpdateUserDataErrorState extends ShopStates {}

