import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_json_data/blocs/employees_bloc.dart';
import 'package:read_json_data/blocs/employees_event.dart';
import 'package:read_json_data/models/employee.dart';

class EmployeeListItem extends StatefulWidget {
  final Employee employee;

  const EmployeeListItem({
    super.key,
    required this.employee,
  });

  @override
  _EmployeeListItemState createState() => _EmployeeListItemState();
}

class _EmployeeListItemState extends State<EmployeeListItem> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.employee.rating;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.employee.userName,
        style: const TextStyle(color: Color.fromARGB(255, 70, 4, 152)),
      ),
      leading: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: NetworkImage(widget.employee.image),
            fit: BoxFit.fill,
          ),
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.employee.emailAddress,
            style: const TextStyle(color: Colors.brown),
          ),
          Row(
            children: [
              const Text(
                'Tech:',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  widget.employee.techStack.join(', '),
                  style: const TextStyle(color: Colors.lightBlue),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Rating: '),
              GestureDetector(
                onTap: () {
                  _showRatingDialog(context);
                },
                child: Row(
                  children: List.generate(
                    5,
                    (i) => Icon(
                      Icons.star,
                      color: i < _currentRating.floor()
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

  void _showRatingDialog(BuildContext context) {
    double newRating = _currentRating;

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
                _updateEmployeeRating(newRating);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateEmployeeRating(double newRating) {
    setState(() {
      _currentRating = newRating;
    });
    // Get the EmployeesBloc instance using BlocProvider
    final employeesBloc = BlocProvider.of<EmployeesBloc>(context);
    employeesBloc.add(UpdateEmployeeRating(widget.employee.id, newRating));
  }
}
