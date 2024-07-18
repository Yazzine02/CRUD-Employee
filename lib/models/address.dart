class Address {
  final String streetName;
  final String buildingName;
  final String cityName;

  Address({this.streetName="not specified", this.buildingName="not specified", this.cityName="not specified"});

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