class SocialUserModel {
  String? name;
  String? email;
  String? uId;
  String? phone;
  bool? isEmailVerified;
  SocialUserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.isEmailVerified,
  });
  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified']??false;
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
    };
  }
}
