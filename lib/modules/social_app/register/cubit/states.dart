abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {
  final dynamic onError;

  SocialRegisterErrorState(this.onError);
}

class RegisterIsPasswordState extends SocialRegisterStates {}

class SocialCreateUserLoadingState extends SocialRegisterStates {}

class SocialCreateUserSuccessState extends SocialRegisterStates {}

class SocialCreateUserErrorState extends SocialRegisterStates {
  final dynamic onError;

  SocialCreateUserErrorState(this.onError);
}