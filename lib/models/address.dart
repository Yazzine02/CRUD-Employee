class Address {
  final String streetName;
  final String buildingName;
  final String cityName;

  Address({this.streetName="not specified", this.buildingName="not specified", this.cityName="not specified"});

  // Method to validate the address format
  //The reason for making the validation method static in the Address class is to allow it to be called without needing an instance of the Address class.
  static String? validateAddress(String value) {
    if (value.isEmpty) {
      return "Please enter your address";
    } else if (!RegExp(r'^([a-zA-Z\s]+),\s*([a-zA-Z0-9\s#]+),\s*([a-zA-Z\s]+)$').hasMatch(value)) {
      return "Please enter a valid address (e.g.: Street name, Building Name, City Name)";
    } 
    return null;
  }

  //The Address class will be an instance variable in the Employee class thus achieving composition. 
  //So, since the Address class will be inside the Employee class, therefore it will get added as a map
  // inside Cloud Firestore.
  //When a class is inside another class you have to define a toMap and fromMap method for it when dealing with databases
  Map<String, dynamic> toMap(){
    return {
      'streetName': streetName,
      'buildingName': buildingName,
      'cityName': cityName,
    };
  }

  Address.fromMap(Map<String, dynamic> addressMap):streetName = addressMap["streetName"],
        buildingName = addressMap["buildingName"],
        cityName = addressMap["cityName"];
}