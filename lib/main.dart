import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_json_data/blocs/employees_bloc.dart';
import 'package:read_json_data/blocs/employees_event.dart';
import 'package:read_json_data/pages/employees_list_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EmployeesBloc>(
          create: (context) => EmployeesBloc()..add(FetchEmployees()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: EmployeesListPage(),
      ),
    );
  }
}
