part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}


class RegisterSucces extends RegisterState {}
class RegisterFailure extends RegisterState {
  String errorMessage;
  RegisterFailure({required this.errorMessage});
}
class RegisterLoading extends RegisterState {}

