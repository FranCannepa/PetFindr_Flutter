import 'dart:convert';

ReportMongoModel reportMongoModelFromJson(String str) => ReportMongoModel.fromJson(json.decode(str));

String reportMongoModelToJson(ReportMongoModel data) => json.encode(data.toJson());

class ReportMongoModel {
    String id;
    String type;
    String race;
    String color;
    String size;
    String petType;
    Location location;
    String date;
    String reportingUser;

    ReportMongoModel({
        required this.id,
        required this.type,
        required this.race,
        required this.color,
        required this.size,
        required this.petType,
        required this.location,
        required this.date,
        required this.reportingUser,
    });

    factory ReportMongoModel.fromJson(Map<String, dynamic> json) => ReportMongoModel(
        id: json["_id"],
        type: json["type"],
        race: json["race"],
        color: json["color"],
        size: json["size"],
        petType: json["petType"],
        location: Location.fromJson(json["location"]),
        date: json["date"],
        reportingUser: json["reportingUser"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "race": race,
        "color": color,
        "size": size,
        "petType": petType,
        "location": location.toJson(),
        "date": date,
        "reportingUser": reportingUser,
    };
}

class Location {
    String type;
    List<String> coordinates;

    Location({
        required this.type,
        required this.coordinates,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: List<String>.from(json["coordinates"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    };
}