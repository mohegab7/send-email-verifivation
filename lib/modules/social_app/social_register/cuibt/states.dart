

abstract class SocialRegisterStates {}

class SocialRegisterintinalstate extends SocialRegisterStates {}

class SocialRegisterloadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {
  
}

class SocialRegisterErrorState extends SocialRegisterStates {
  SocialRegisterErrorState(this.error);

  final String error;
}

class SocialCreateUserSuccessState extends SocialRegisterStates {
  
}

class SocialCreateUserErrorState extends SocialRegisterStates {
  SocialCreateUserErrorState(this.error);

  final String error;
}

class SocialRegisterChangePasswordState extends SocialRegisterStates {}
