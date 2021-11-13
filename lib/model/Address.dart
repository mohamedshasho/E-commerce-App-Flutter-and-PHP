class Address {
  var lat;
  var lng;
  Address({this.lat, this.lng});
  factory Address.fromJson(Map<String, dynamic> con) {
    return Address(lat: con['lat'], lng: con['lng']);
  }
}
