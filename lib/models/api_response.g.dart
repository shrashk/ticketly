// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) => ApiResponse(
      version: json['version'] as String,
      systemMessages: (json['systemMessages'] as List<dynamic>)
          .map((e) => SystemMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      locations: (json['locations'] as List<dynamic>)
          .map((e) => Location.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'version': instance.version,
      'systemMessages': instance.systemMessages.map((e) => e.toJson()).toList(),
      'locations': instance.locations.map((e) => e.toJson()).toList(),
    };

SystemMessage _$SystemMessageFromJson(Map<String, dynamic> json) =>
    SystemMessage(
      type: json['type'] as String,
      module: json['module'] as String,
      code: (json['code'] as num).toInt(),
      text: json['text'] as String,
    );

Map<String, dynamic> _$SystemMessageToJson(SystemMessage instance) =>
    <String, dynamic>{
      'type': instance.type,
      'module': instance.module,
      'code': instance.code,
      'text': instance.text,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      id: json['id'] as String,
      name: json['name'] as String,
      coord: (json['coord'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      type: json['type'] as String,
      matchQuality: (json['matchQuality'] as num).toInt(),
      isBest: json['isBest'] as bool,
      parent: Parent.fromJson(json['parent'] as Map<String, dynamic>),
      properties: json['properties'] == null
          ? null
          : AdditionalProp.fromJson(json['properties'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coord': instance.coord,
      'type': instance.type,
      'matchQuality': instance.matchQuality,
      'isBest': instance.isBest,
      'parent': instance.parent.toJson(),
      'properties': instance.properties?.toJson(),
    };

Parent _$ParentFromJson(Map<String, dynamic> json) => Parent(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$ParentToJson(Parent instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
    };

AdditionalProp _$AdditionalPropFromJson(Map<String, dynamic> json) =>
    AdditionalProp(
      stopId: json['stopId'] as String,
      mainLocality: json['mainLocality'] as String,
    );

Map<String, dynamic> _$AdditionalPropToJson(AdditionalProp instance) =>
    <String, dynamic>{
      'stopId': instance.stopId,
      'mainLocality': instance.mainLocality,
    };
