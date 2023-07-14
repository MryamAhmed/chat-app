import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registerUser({required email,required password}) async {
    emit(RegisterLoading());

    try{
      var auth = FirebaseAuth.instance;
      UserCredential user = await auth.createUserWithEmailAndPassword(email: email!, password: password!);
      emit(RegisterSucces());
    }on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(RegisterFailure(errorMessage: 'weak password'));
      } else if (ex.code == 'email-already-in-use') {
        emit(RegisterFailure(errorMessage: 'email already in use'));
      }
    } //
    catch (ex) {
      emit(RegisterFailure(errorMessage: 'there was an error'));
    }
  }
}
