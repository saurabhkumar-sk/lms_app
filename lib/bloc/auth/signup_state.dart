import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/signup_repository.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class SignupSubmitted extends SignupEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String password_confirmation;

  const SignupSubmitted({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.password_confirmation,
  });

  @override
  List<Object?> get props => [name, email, phone, password, password_confirmation];
}


abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final String message;

  const SignupSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class SignupFailure extends SignupState {
  final String error;

  const SignupFailure(this.error);

  @override
  List<Object?> get props => [error];
}


class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupRepository signupRepository;

  SignupBloc({required this.signupRepository}) : super(SignupInitial()) {
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  Future<void> _onSignupSubmitted(
      SignupSubmitted event,
      Emitter<SignupState> emit,
      ) async {
    emit(SignupLoading());

    try {
      final response = await SignupRepository.signUp(
        event.name,
        event.email,
        event.phone,
        event.password,
        event.password_confirmation,
      );

      if (response.httpCode == 201) {
        emit(SignupSuccess(response.message ?? "Sign up successful"));
      } else {
        emit(SignupFailure(response.message ?? "Sign up failed"));
      }
    } catch (e) {
      emit(SignupFailure(e.toString()));
    }
  }
}
