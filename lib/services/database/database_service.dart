import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudemployeeapp/models/employee.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addEmployee(Employee employeeData) async{
    await _db.collection("Employees").add(employeeData.toMap());
  }

  updateEmployee(Employee employeeData)async{
    await _db.collection("Employees").doc(employeeData.id).update(employeeData.toMap());
  }

  Future<void> removeEmployee(Employee employeeData)async{
    await _db.collection("Employees").doc(employeeData.id).delete();
  }
  //get all employees
  Future<List<Employee>> retrieveEmployees() async{
    QuerySnapshot<Map<String,dynamic>> snapshot = await _db.collection("Employees").get();
    //WTF????
    return snapshot.docs
        .map((docSnapshot) => Employee.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}