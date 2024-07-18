import 'package:crudemployeeapp/models/address.dart';
import 'package:crudemployeeapp/models/employee.dart';
import 'package:crudemployeeapp/services/database/database_service.dart';
import 'package:crudemployeeapp/styles/input_decoration.dart';
import 'package:crudemployeeapp/styles/text_style.dart';
import 'package:flutter/material.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController traitsController = TextEditingController();

  //why do we use _formKey ? what is it ? when do we use it ?
  //we use it when we have a form
  //do we really need a form ?
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  //global variable for widgets
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Employee"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //name
                const Text("Name",style: textStyle,),
                const SizedBox(height: 8.0,),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  //.copyWith() to add another field
                  decoration: inputDecoration.copyWith(hintText: 'Enter your name'),
                  validator: (value){
                    if(value==null || value.isEmpty) {
                      return "Please enter your name";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 8.0,),
                //age
                Text("Age",style: textStyle,),
                const SizedBox(height: 8.0,),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  //.copyWith() to add another field
                  decoration: inputDecoration.copyWith(hintText: 'Enter your age'),
                  validator: (value){
                    if(value==null || value.isEmpty) {
                      return "Please enter your age";
                    } else {
                      return null;
                    }
                  },
                ),
                //salary
                const SizedBox(height: 8.0,),
                Text("Salary",style: textStyle,),
                const SizedBox(height: 8.0,),
                TextFormField(
                  controller: salaryController,
                  keyboardType: TextInputType.number,
                  //.copyWith() to add another field
                  decoration: inputDecoration.copyWith(hintText: 'Enter your salary'),
                  validator: (value){
                    if(value==null || value.isEmpty) {
                      return "Please enter your salary";
                    } else {
                      return null;
                    }
                  },
                ),
                //Address
                const SizedBox(height: 8.0,),
                Text("Adress",style: textStyle,),
                const SizedBox(height: 8.0,),
                TextFormField(
                  controller: addressController,
                  keyboardType: TextInputType.text,
                  //.copyWith() to add another field
                  decoration: inputDecoration.copyWith(hintText: 'Enter your address'),
                  validator: (value){
                    if(value==null || value.isEmpty) {
                      return "Please enter your adress";
                    }
                    else if(!RegExp(r'^([a-zA-Z\s]+),\s*([a-zA-Z0-9\s#]+),\s*([a-zA-Z\s]+)$').hasMatch(value)){
                      return "Please enter a valid address (e.g.: Street name, Building Name, City Name)";
                    } 
                    else {
                      return null;
                    }
                  },
                ),
                //Traits
                const SizedBox(height: 8.0,),
                Text("Traits",style: textStyle,),
                const SizedBox(height: 8.0,),
                TextFormField(
                  controller: traitsController,
                  keyboardType: TextInputType.text,
                  //.copyWith() to add another field
                  decoration: inputDecoration.copyWith(hintText: 'Enter your traits'),
                  validator: (value){
                    if(value==null || value.isEmpty) {
                      return "Please enter your traits";
                    } else {
                      return null;
                    }
                  },
                ),
                //submit button
                const SizedBox(height: 10,),
                isLoading?
                //if loading make button unavailable, instead circular loading indicator
                const Center(
                  child: CircularProgressIndicator()
                )
                :
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      minimumSize:WidgetStateProperty.all(const Size(200,50)),
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 83, 80, 80))),
                    onPressed: (()async{
                      if(_formKey.currentState!.validate()){
                        //custom class that acts as a data access object
                        DatabaseService service = DatabaseService();
                        //manipulating traits with a list
                        List<String> employeeTraits = traitsController.text.split(",");
                        //manipulating address with custom address class
                        late Address address;
                        if(addressController.text.contains(",")){
                          //split it into a list where index 0 is streetname, 1 is building name and 2 is city name
                          List<String> fullAddress = addressController.text.split(",");
                          address = Address(
                            streetName : fullAddress[0],
                            buildingName : fullAddress[1],
                            cityName : fullAddress[2],
                          );
                        }else if(addressController.text.contains(' ')){
                          List<String> fullAddress = addressController.text.split(" ");
                          address = Address(
                            streetName : fullAddress[0],
                            buildingName : fullAddress[1],
                            cityName : fullAddress[2],
                          );
                        }
                        //creating an employee instance with all attributes
                        Employee employee = Employee(
                          name: nameController.text,
                          age: int.parse(ageController.text),
                          salary: int.parse(salaryController.text),
                          address: address,
                          employeeTraits: employeeTraits,
                        );
                        //make submit button unavailable
                        setState(() {
                          isLoading = true;
                        });
                        //add the employee using the data access instance
                        await service.addEmployee(employee);
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.pushReplacementNamed(context, '/dash');
                      }
                    }),
                    child: const Text("Submit", style: TextStyle(fontSize: 20),),
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
