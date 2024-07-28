class Employee {
  final String userName;
  final String jobTitleName;
  final String employeeCode;
  final List<String> techStack;
  final String emailAddress;
  final String image;

  Employee({
    required this.userName,
    required this.jobTitleName,
    required this.employeeCode,
    required this.techStack,
    required this.emailAddress,
    required this.image,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      userName: json['userName'],
      jobTitleName: json['jobTitleName'],
      employeeCode: json['employeeCode'],
      techStack: List<String>.from(json['techstack']),
      emailAddress: json['emailAddress'],
      image: json['image'],
    );
  }
}
