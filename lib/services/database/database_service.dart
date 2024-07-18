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
    /*
    _db.collection("Employees").get() is an asynchronous call to Firestore to fetch all documents from the "Employees" collection.
    The result of this call is stored in the snapshot variable, which is of type QuerySnapshot<Map<String, dynamic>>. 
    This type indicates that the snapshot contains a collection of documents, each represented as a map with string keys and dynamic values.
    */
    QuerySnapshot<Map<String,dynamic>> snapshot = await _db.collection("Employees").get();
    //transforming each document snapshot into an employee using .map
    return snapshot.docs
        .map((docSnapshot) => Employee.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}