import 'package:crudemployeeapp/models/employee.dart';
import 'package:crudemployeeapp/services/database/database_service.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  final String title;
  const DashBoardScreen({super.key,required this.title});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DatabaseService dbService = DatabaseService();
  Future<List<Employee>>? employeeList;
  //do i need to define a List<Employee>? to store employeeList ?
  //yes because we need to manipulate the retrieved employees as a list
  List<Employee>? retrievedEmployeeList;
  
  Future<void> _refresh() async{
    await _initRetrieval();
    setState((){
    });
  }
  void _dismiss(index) {
    setState(() {
      retrievedEmployeeList!.removeAt(index);
    });
  }

  Future<void> _initRetrieval()async{
    employeeList = dbService.retrieveEmployees();
    retrievedEmployeeList = await dbService.retrieveEmployees();
  }

  @override
  void initState(){
    super.initState();
    _initRetrieval();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: RefreshIndicator(
    onRefresh: _refresh,
    child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
        future: employeeList,
        builder:
            (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.separated(
                itemCount: retrievedEmployeeList!.length,
                separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                    ),
                itemBuilder: (context, index) {
                    return Dismissible(
                      onDismissed: ((direction) async{
                              await dbService.removeEmployee(
                              retrievedEmployeeList![index]);
                              _dismiss(index);
                        }),
                      background: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(16.0)),
                          padding: const EdgeInsets.only(right: 28.0),
                          alignment: AlignmentDirectional.centerEnd,
                          child: const Text(
                            "DELETE",
                            style: TextStyle(color: Colors.white),
                          ),
                      ),
                      direction: DismissDirection.startToEnd,
                      resizeDuration: const Duration(milliseconds: 200),
                      key: UniqueKey(),
                      child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 83, 80, 80),
                              borderRadius: BorderRadius.circular(16.0)),
                          child: ListTile(
                          onTap:() {
                            Navigator.pushNamed(context, '/view',arguments:retrievedEmployeeList![index]);
                            //Navigator.pushNamed(context, "/edit", arguments: retrievedEmployeeList![index]);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                          ),
                          title: Text(retrievedEmployeeList![index].name),
                          subtitle: Text(
                              "${retrievedEmployeeList![index].address.cityName.toString()}, ${retrievedEmployeeList![index].address.streetName.toString()}"),
                          trailing: const Icon(Icons.arrow_right_sharp),
                          ),
                    ),
                    );
                });
            } else if (snapshot.connectionState == ConnectionState.done &&
                retrievedEmployeeList!.isEmpty) {
            return Center(
                child: ListView(
                children: const <Widget>[
                    Align(alignment: AlignmentDirectional.center,
                        child: Text('No data available')),
                ],
                ),
            );
            } else {
            return const Center(child: CircularProgressIndicator());
            }
        },
        ),
    ),
    ),
    floatingActionButton: FloatingActionButton(
    onPressed: (() {
        Navigator.pushNamed(context, '/add');
    }),
    tooltip: 'add',
    child: const Icon(Icons.add),
    ),
    );
  }
  
  

  
}