import 'package:crudemployeeapp/models/employee.dart';
import 'package:crudemployeeapp/screens/dash_board_screen.dart';
import 'package:crudemployeeapp/screens/add_employee_screen.dart';
import 'package:crudemployeeapp/screens/edit_employee_screen.dart';
import 'package:crudemployeeapp/screens/employee_screen.dart';
import 'package:crudemployeeapp/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Employee Management",
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/':(context)=>const WidgetTree(),
        '/dash':(context)=>const DashBoardScreen(title: 'Dashboard'),
        '/add':(context)=>const AddEmployeeScreen(),
        //'/view':(context)=>const EmployeeScreen(),
        //'/edit':(context)=>const EditEmployeeScreen(),
      },
      onGenerateRoute: (settings) {
        if(settings.name=='/view'){
          final args = settings.arguments as Employee;
          return MaterialPageRoute(builder: (context){
            return EmployeeScreen(employee: args);
          });
        }
        else if(settings.name=='/edit'){
          final args = settings.arguments as String;
          return MaterialPageRoute(builder: (context){
            return EditEmployeeScreen(employeeId: args);
          });
        }
        return null;
      },
    );
  }
}
