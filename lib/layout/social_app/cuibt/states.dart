abstract class SocialStates {}

class SocialIntinalstate extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  SocialGetUserErrorState(this.error);

  final String error;
}
