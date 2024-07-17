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
      title: "CRUD Firebase tutorial",
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/':(context)=>const DashBoardScreen(title: 'Dashboard'),
        '/add':(context)=>const EmployeeScreen(),
        '/edit':(context)=>const EditEmployeeScreen();
      },
    );
  }
}
