import 'package:equatable/equatable.dart';

abstract class EmployeesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchEmployees extends EmployeesEvent {}

class UpdateEmployeeRating extends EmployeesEvent {
  final int index;
  final double newRating;

  UpdateEmployeeRating(this.index, this.newRating);

  @override
  List<Object?> get props => [index, newRating];
}
