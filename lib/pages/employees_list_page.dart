import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_json_data/blocs/employees_bloc.dart';
import 'package:read_json_data/blocs/employees_event.dart';
import 'package:read_json_data/blocs/employees_state.dart';
import 'package:read_json_data/models/employee.dart';

class EmployeesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees'),
        backgroundColor: Color.fromARGB(255, 2, 70, 70),
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<EmployeesBloc, EmployeesState>(
        builder: (context, state) {
          if (state is EmployeesLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.lightBlue),
            );
          } else if (state is EmployeesLoaded) {
            return ListView.builder(
              itemCount: state.employees.length,
              itemBuilder: (context, index) {
                final employee = state.employees[index];
                return _buildEmployeeItem(context, index, employee);
              },
            );
          } else if (state is EmployeesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(
              child: Text('Unknown state'),
            );
          }
        },
      ),
    );
  }

  Widget _buildEmployeeItem(
      BuildContext context, int index, Employee employee) {
    return ListTile(
      title: Text(
        employee.userName,
        style: TextStyle(color: Color.fromARGB(255, 70, 4, 152)),
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
            style: TextStyle(color: Colors.brown),
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
      onTap: () {
        // Handle onTap action
      },
    );
  }

  void _showRatingDialog(
      BuildContext context, int index, double currentRating) {
    double newRating = currentRating;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rate Employee'),
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
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Rate'),
              onPressed: () {
                // Update the rating using Bloc
                context.read<EmployeesBloc>().add(
                      UpdateEmployeeRating(index, newRating),
                    );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
