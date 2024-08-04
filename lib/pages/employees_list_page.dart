import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_json_data/blocs/employees_bloc.dart';
import 'package:read_json_data/blocs/employees_event.dart';
import 'package:read_json_data/blocs/employees_state.dart';
import 'package:read_json_data/models/employee.dart';

class EmployeesListPage extends StatefulWidget {
  @override
  _EmployeesListPageState createState() => _EmployeesListPageState();
}

class _EmployeesListPageState extends State<EmployeesListPage> {
  late EmployeesBloc _employeesBloc;

  @override
  void initState() {
    super.initState();
    _employeesBloc = context.read<EmployeesBloc>();
    _employeesBloc.add(FetchEmployees());
  }

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
                  employee: employee,
                  index: index,
                  onRatingUpdated: (newRating) {
                    // Update the rating locally and trigger UI update
                    setState(() {
                      state.employees[index].rating = newRating;
                    });
                  },
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

class EmployeeListItem extends StatelessWidget {
  final Employee employee;
  final int index;
  final Function(double) onRatingUpdated;

  const EmployeeListItem({
    super.key,
    required this.employee,
    required this.index,
    required this.onRatingUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        employee.userName,
        style: const TextStyle(color: Color.fromARGB(255, 70, 4, 152)),
      ),
      leading: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: NetworkImage(employee.image),
            fit: BoxFit.fill,
          ),
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            employee.emailAddress,
            style: const TextStyle(color: Colors.brown),
          ),
          Row(
            children: [
              const Text(
                'Tech:',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              Row(
                children: employee.techStack
                    .map(
                      (tech) => Text(
                        '$tech,',
                        style: const TextStyle(
                          color: Colors.lightBlue,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Rating: '),
              GestureDetector(
                onTap: () {
                  _showRatingDialog(context, index, employee.rating);
                },
                child: Row(
                  children: List.generate(
                    5,
                    (i) => Icon(
                      Icons.star,
                      color: i < employee.rating.floor()
                          ? Colors.amber
                          : Colors.grey,
                    ),
                  ).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
      onTap: () {},
    );
  }

  void _showRatingDialog(
    BuildContext context,
    int index,
    double currentRating,
  ) {
    double newRating = currentRating;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rate Employee'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (i) => IconButton(
                    icon: Icon(
                      i < newRating.floor() ? Icons.star : Icons.star_border,
                      color: i < newRating.floor() ? Colors.amber : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        newRating = i + 1.0;
                      });
                    },
                  ),
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Rate'),
              onPressed: () {
                // Update the rating using Bloc
                context.read<EmployeesBloc>().add(
                      UpdateEmployeeRating(index, newRating),
                    );
                // Call the callback to update the rating locally
                onRatingUpdated(newRating);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
