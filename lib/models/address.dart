class Address {
  final String streetName;
  final String buildingName;
  final String cityName;

  Address({required this.streetName, required this.buildingName, required this.cityName});

  //The Address class will be an instance variable in the Employee class thus achieving composition. 
  //So, since the Address class will be inside the Employee class, therefore it will get added as a map
  // inside Cloud Firestore.
  //WHY?????
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