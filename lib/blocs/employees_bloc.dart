import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:read_json_data/blocs/employees_event.dart';
import 'package:read_json_data/blocs/employees_state.dart';
import 'package:read_json_data/models/employee.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  final String jsonPath = 'assets/employees.json';
  late List<Employee> _employees;

  EmployeesBloc() : super(EmployeesInitial()) {
    _employees = []; // Initialize employees list
    on<FetchEmployees>(_onFetchEmployees);
    on<UpdateEmployeeRating>(_updateEmployeeRating);
  }

  void _onFetchEmployees(
      FetchEmployees event, Emitter<EmployeesState> emit) async {
    emit(EmployeesLoading());
    try {
      var result = await rootBundle.loadString(jsonPath);
      var response = jsonDecode(result);
      if (response['success']) {
        _employees = List<Employee>.from(
          response['data'].map((e) => Employee.fromJson(e)).toList(),
        );
        emit(EmployeesLoaded(List.from(_employees)));
      } else {
        emit(const EmployeesError('Failed to parse employees data'));
      }
    } catch (e) {
      emit(EmployeesError('Failed to load employees file: $e'));
    }
  }

  void _updateEmployeeRating(
      UpdateEmployeeRating event, Emitter<EmployeesState> emit) {
    if (event.index >= 0 && event.index < _employees.length) {
      _employees[event.index].rating = event.newRating;
      emit(EmployeesLoaded(List.from(_employees)));
    }
  }
}
