import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_json_data/blocs/employees_bloc.dart';
import 'package:read_json_data/blocs/employees_state.dart';
import 'package:read_json_data/pages/view/employee_list_item.dart';

class EmployeesListPage extends StatelessWidget {
  const EmployeesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees'),
        backgroundColor: const Color.fromARGB(255, 2, 70, 70),
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<EmployeesBloc, EmployeesState>(
        builder: (context, state) {
          if (state is EmployeesLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.lightBlue),
            );
          } else if (state is EmployeesLoaded) {
            return ListView.builder(
              itemCount: state.employees.length,
              itemBuilder: (context, index) {
                final employee = state.employees[index];
                return EmployeeListItem(
                  key: ValueKey(employee.id),
                  employee: employee,
                );
              },
            );
          } else if (state is EmployeesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('Unknown state'),
            );
          }
        },
      ),
    );
  }
}
