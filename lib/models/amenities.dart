
import 'dart:convert';

Amenities amenitiesFromJson(String str) => Amenities.fromJson(json.decode(str));

String amenitiesToJson(Amenities data) => json.encode(data.toJson());

class Amenities {
  Amenities({
    this.amenityId,
    this.amenityName,
    this.amenityTypeId,
    this.amenitytypeName,
  });

  int amenityId;
  String amenityName;
  int amenityTypeId;
  String amenitytypeName;

  factory Amenities.fromJson(Map<String, dynamic> json) => Amenities(
    amenityId: json["amenity_id"],
    amenityName: json["amenity_name"],
    amenityTypeId: json["amenity_type_id"],
    amenitytypeName: json["amenitytype_name"],
  );

  Map<String, dynamic> toJson() => {
    "amenity_id": amenityId,
    "amenity_name": amenityName,
    "amenity_type_id": amenityTypeId,
    "amenitytype_name": amenitytypeName,
  };
}
