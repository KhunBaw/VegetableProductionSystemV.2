import 'dart:convert';

Employee employeeFromJson(String str) => Employee.fromJson(json.decode(str));

class Employee {
  Employee({
    required this.empId,
    required this.username,
    required this.empName,
    required this.empPhnum,
    required this.empAddress,
    required this.empPhoto,
    required this.empPosition,
    required this.role,
  });

  int? empId;
  String? username;
  String? empName;
  String? empPhnum;
  String? empAddress;
  String? empPhoto;
  String? empPosition;
  String? role;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        empId: json["emp_id"] == null ? null : json["emp_id"],
        username: json["username"] == null ? null : json["username"],
        empName: json["emp_name"] == null ? null : json["emp_name"],
        empPhnum: json["emp_phnum"] == null ? null : json["emp_phnum"],
        empAddress: json["emp_address"] == null ? null : json["emp_address"],
        empPhoto: json["emp_photo"] == null ? null : json["emp_photo"],
        empPosition: json["emp_position"] == null ? null : json["emp_position"],
        role: json["role"] == null ? null : json["role"],
      );
}
