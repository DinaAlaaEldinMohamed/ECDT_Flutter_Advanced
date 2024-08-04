import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String userName;
  final String jobTitleName;
  final String employeeCode;
  final List<String> techStack;
  final String emailAddress;
  String image;
  double rating; // Add a rating field to Employee class

  Employee({
    required this.userName,
    required this.jobTitleName,
    required this.employeeCode,
    required this.techStack,
    required this.emailAddress,
    required this.image,
    this.rating = 0.0,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      userName: json['userName'],
      jobTitleName: json['jobTitleName'],
      employeeCode: json['employeeCode'],
      techStack: List<String>.from(json['techstack']),
      emailAddress: json['emailAddress'],
      image: json['image'],
      rating: json['rating'] ?? 0.0,
    );
  }

  @override
  List<Object?> get props => [
        userName,
        jobTitleName,
        employeeCode,
        techStack,
        emailAddress,
        image,
        rating,
      ];
}
