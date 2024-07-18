import 'package:crudemployeeapp/screens/dash_board_screen.dart';
import 'package:crudemployeeapp/screens/login_or_register_screen.dart';
import 'package:crudemployeeapp/services/authentification/auth_service.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().authStateChanges,
      builder: (context,snapshot){
        if(snapshot.hasData){return const DashBoardScreen(title: 'Dashboard');}
        else{return const LoginOrRegisterScreen();}
      }
    );
  }
}