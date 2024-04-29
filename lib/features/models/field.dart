import 'dart:convert';

import 'package:flutter/foundation.dart';

class FieldModel {
  List<WorkflowField>? fieldslist;

  FieldModel({this.fieldslist});

  FieldModel.fromJson(Map<String, dynamic> json) {
    if (json['fields'] != null) {
      fieldslist = <WorkflowField>[];
      json['fields'].forEach((v) {
        fieldslist!.add(WorkflowField.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fieldslist != null) {
      data['fields'] = fieldslist!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}

class WorkflowField {
  String? id;
  bool? isGlobal;
  String? orgId;
  String? name;
  String? description;
  String? type;

  WorkflowField(
      {this.id,
      this.isGlobal,
      this.orgId,
      this.name,
      this.description,
      this.type});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isGlobal': isGlobal,
      'orgId': orgId,
      'name': name,
      'description': description,
      'type': type,
    };
  }

  factory WorkflowField.fromMap(Map<String, dynamic> map) {
    return WorkflowField(
      id: map['id'],
      isGlobal: map['isGlobal'],
      orgId: map['orgId'],
      name: map['name'],
      description: map['description'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkflowField.fromJson(String source) =>
      WorkflowField.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WorkflowField && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
