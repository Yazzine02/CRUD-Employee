import 'package:crudemployeeapp/models/employee.dart';
import 'package:crudemployeeapp/services/database/database_service.dart';
import 'package:crudemployeeapp/styles/text_style.dart';
import 'package:flutter/material.dart';

class EmployeeScreen extends StatefulWidget {
  final Employee employee;

  const EmployeeScreen({super.key, required this.employee});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  DatabaseService dbService = DatabaseService();

  Future<void> _delete()async{
    await dbService.removeEmployee(widget.employee);
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile icon
              Center(
                child: CircleAvatar(
                  radius: 60,
                  child: Text(
                    widget.employee.name[0], // Initial of the employee's name
                    style: const TextStyle(fontSize: 60),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              //How do i make this to generate dynamically ? with a listview.separated ?
              // Name
              Text("Name:", style: textStyle.copyWith(decoration: TextDecoration.underline, fontSize: 30)),
              Text(widget.employee.name, style: textStyle),
              const SizedBox(height: 16.0),
              // Age
              Text("Age:", style: textStyle.copyWith(decoration: TextDecoration.underline, fontSize: 30)),
              Text(widget.employee.age.toString(), style: textStyle),
              const SizedBox(height: 16.0),
              // Salary
              Text("Salary:", style: textStyle.copyWith(decoration: TextDecoration.underline, fontSize: 30)),
              Text(widget.employee.salary.toString(), style: textStyle),
              const SizedBox(height: 16.0),
              // Address
              Text("Address:", style: textStyle.copyWith(decoration: TextDecoration.underline, fontSize: 30)),
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
                      Navigator.pushNamed(context, '/edit', arguments: widget.employee.id); 
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
                      _delete();
                      //Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.pushReplacementNamed(context, '/dash');                    },
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
