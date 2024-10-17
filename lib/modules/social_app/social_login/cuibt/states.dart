
abstract class SocialLoginStates {}

class SocialLoginintinalstate extends SocialLoginStates {}

class SocialLoginloadingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
  final String uId;

  SocialLoginSuccessState(this.uId);
  
}

class SocialLoginErrorState extends SocialLoginStates {
  SocialLoginErrorState(this.error);

  final String error;
}

class SocialChangePasswordState extends SocialLoginStates {}
