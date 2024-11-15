
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/category.dart';
import '../repository/home_repository.dart';

// Events
abstract class CourseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCourses extends CourseEvent {}

// States
abstract class CourseState extends Equatable {
  @override
  List<Object> get props => [];
}

class CourseLoading extends CourseState {}

class CourseLoaded extends CourseState {
  final List<CourseCategory> courses;

  CourseLoaded(this.courses);

  @override
  List<Object> get props => [courses];
}

class CourseError extends CourseState {
  final String message;

  CourseError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseRepository repository;

  CourseBloc(this.repository) : super(CourseLoading()) {
    // Register event handler
    on<FetchCourses>((event, emit) async {
      emit(CourseLoading());

      try {
        final courses = await repository.fetchCourseCategories();
        emit(CourseLoaded(courses));
      } catch (e) {
        emit(CourseError('Failed to load courses'));
      }
    });
  }
}
