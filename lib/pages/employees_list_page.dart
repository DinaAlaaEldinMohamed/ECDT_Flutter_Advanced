import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:read_json_data/models/employee.dart';

class EmployeesListPage extends StatefulWidget {
  const EmployeesListPage({super.key});

  @override
  State<EmployeesListPage> createState() => _EmployeesListPageState();
}

class _EmployeesListPageState extends State<EmployeesListPage> {
  bool isLoading = false;
  List<Employee> employees = [];
  final averageRating = 3.5;

  @override
  void initState() {
    readEmployeesData();
    super.initState();
  }

  void readEmployeesData() async {
    isLoading = true;
    try {
      var result = await rootBundle.loadString('assets/employees.json');
      var response = jsonDecode(result);
      if (response['success']) {
        employees = List<Employee>.from(
            response['data'].map((e) => Employee.fromJson(e)).toList());
      } else {
        print("Failed to parse employees data");
        return;
      }
      isLoading = false;
      setState(() {});
    } catch (e) {
      print("Failed to load employees file .$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Employees'),
          backgroundColor: Color.fromARGB(255, 2, 70, 70),
          foregroundColor: Colors.white,
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.lightBlue,
              ))
            : Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView(
                    children: employees.map((e) {
                      final ratingNotifier =
                          ValueNotifier<double>(averageRating);

                      return ListTile(
                        title: Text(
                          e.userName,
                          style:
                              TextStyle(color: Color.fromARGB(255, 70, 4, 152)),
                        ),
                        leading: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: NetworkImage(e.image),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.emailAddress,
                              style: TextStyle(color: Colors.brown),
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Tech:',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: e.techStack
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
                            ValueListenableBuilder<double>(
                              valueListenable: ratingNotifier,
                              builder: (context, rating, _) {
                                return Row(
                                  children: List.generate(
                                    5,
                                    (index) => GestureDetector(
                                      onTap: () {
                                        ratingNotifier.value = index + 1.0;
                                      },
                                      child: Icon(
                                        index < rating.floor()
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          // Handle the onTap action (e.g., navigate to a details screen)
                        },
                      );
                    }).toList(),
                  ),
                ),
              ));
  }
}
