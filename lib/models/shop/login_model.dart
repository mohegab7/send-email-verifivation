class ShopLoginModel
{
  late bool status;
  late Userdata data;
  late String message;

  ShopLoginModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status']??false;
    message=json['message']??'';
    data = (json['data'] != null ? Userdata.fromJson(json['data']) : null)!;
  }
}
class Userdata {
 late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String token;

  Userdata.fromJson(Map<String, dynamic> json)
  {
    id = json['id']??0;
    name = json['name']??'';
    email = json['email']??'';
    phone = json['phone']??'';
    image = json['image']??'';
    token = json['token']??'';
  }
}


