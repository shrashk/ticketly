// models/api_response.dart
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiResponse {
  final String version;
  final List<SystemMessage> systemMessages;
  final List<Location> locations;

  ApiResponse({
    required this.version,
    required this.systemMessages,
    required this.locations,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}

@JsonSerializable()
class SystemMessage {
  final String type;
  final String module;
  final int code;
  final String text;

  SystemMessage({
    required this.type,
    required this.module,
    required this.code,
    required this.text,
  });

  factory SystemMessage.fromJson(Map<String, dynamic> json) => _$SystemMessageFromJson(json);
  Map<String, dynamic> toJson() => _$SystemMessageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Location {
  final String id;
  final String name;
  final List<double> coord;
  final String type;
  final int matchQuality;
  final bool isBest;
  final Parent parent;
  final AdditionalProp? properties;

  Location({
    required this.id,
    required this.name,
    required this.coord,
    required this.type,
    required this.matchQuality,
    required this.isBest,
    required this.parent,
    this.properties
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Parent {
  final String id;
  final String name;
  final String type;

  Parent({
    required this.id,
    required this.name,
    required this.type,
  });

  factory Parent.fromJson(Map<String, dynamic> json) => _$ParentFromJson(json);
  Map<String, dynamic> toJson() => _$ParentToJson(this);
}
@JsonSerializable()
class AdditionalProp {
  final String stopId;
  final String mainLocality;

  AdditionalProp({
    required this.stopId,
    required this.mainLocality
  });

  factory AdditionalProp.fromJson(Map<String, dynamic> json) => _$AdditionalPropFromJson(json);
  Map<String, dynamic> toJson() => _$AdditionalPropToJson(this);
}
