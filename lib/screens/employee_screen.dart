import 'package:crudemployeeapp/models/employee.dart';
import 'package:crudemployeeapp/styles/text_style.dart';
import 'package:flutter/material.dart';

class EmployeeScreen extends StatefulWidget {
  final Employee employee;

  const EmployeeScreen({super.key, required this.employee});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Employee Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile icon
              CircleAvatar(
                radius: 60,
                child: Text(
                  widget.employee.name[0], // Initial of the employee's name
                  style: TextStyle(fontSize: 60),
                ),
              ),
              const SizedBox(height: 16.0),
              // Name
              const Text("Name:", style: textStyle),
              const SizedBox(height: 8.0),
              Text(widget.employee.name, style: textStyle),
              const SizedBox(height: 16.0),
              // Age
              const Text("Age:", style: textStyle),
              const SizedBox(height: 8.0),
              Text(widget.employee.age.toString(), style: textStyle),
              const SizedBox(height: 16.0),
              // Salary
              const Text("Salary:", style: textStyle),
              const SizedBox(height: 8.0),
              Text(widget.employee.salary.toString(), style: textStyle),
              const SizedBox(height: 16.0),
              // Address
              const Text("Address:", style: textStyle),
              const SizedBox(height: 8.0),
              Text(
                "${widget.employee.address.streetName}, ${widget.employee.address.cityName}",
                style: textStyle,
              ),
              const SizedBox(height: 16.0),
              // Edit button and Delete button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //edit
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to edit screen
                    },
                    child: const Row(
                      children: [
                        Text("Edit"),
                        SizedBox(width:3),
                        Icon(Icons.edit)
                      ],
                    ),
                  ),
                  const SizedBox(width: 15,),
                  // Delete button
                  ElevatedButton(
                    onPressed: () {
                      // Perform delete operation
                    },
                    child: const Row(
                      children: [
                        Text("Delete"),
                        SizedBox(width:3),
                        Icon(Icons.delete)
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
