import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:final_year/features/models/field.dart';
import 'package:final_year/features/models/workflow.dart';

class Document {
  String id;
  Workflow workflow;
  DateTime createdAt;
  DateTime? completedAt;
  int stepsCompleted;
  Document({
    required this.id,
    required this.workflow,
    required this.createdAt,
    this.completedAt,
    required this.stepsCompleted,
  });

  factory Document.fromMap(Map<String, dynamic> map) {
    return Document(
      id: map['id'] ?? '',
      workflow: Workflow.fromMap(map['workflow']),
      createdAt: DateTime.parse(map['createdAt']),
      completedAt:
          map['completedAt'] != null ? DateTime.parse(map['createdAt']) : null,
      stepsCompleted: int.tryParse(map['stepsCompleted']) ?? 0,
    );
  }

  factory Document.fromJson(String source) =>
      Document.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Document(id: $id, workflow: $workflow, createdAt: $createdAt, completedAt: $completedAt, stepsCompleted: $stepsCompleted)';
  }
}

class DocumentStep {
  String id;
  WorkflowStep step;
  DateTime? completedAt;
  bool isUserTurn;
  List<DocumentField> fields;
  List<DocumentEvent> events;

  DocumentStep({
    required this.id,
    required this.step,
    this.completedAt,
    required this.isUserTurn,
    required this.fields,
    required this.events,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'step': step.toMap(),
      'completedAt': completedAt?.toIso8601String(),
      'isUserTurn': isUserTurn,
      'fields': fields.map((x) => x.toMap()).toList(),
      'events': events.map((x) => x.toMap()).toList(),
    };
  }

  factory DocumentStep.fromMap(Map<String, dynamic> map) {
    return DocumentStep(
      id: map['id'] ?? '',
      step: WorkflowStep.fromMap(map['step']),
      completedAt: map['completedAt'] != null
          ? DateTime.parse(map['completedAt'])
          : null,
      isUserTurn: map['isUserTurn'] ?? false,
      fields: List<DocumentField>.from(
          map['fields']?.map((x) => DocumentField.fromMap(x))),
      events: List<DocumentEvent>.from(
          map['events']?.map((x) => DocumentEvent.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentStep.fromJson(String source) =>
      DocumentStep.fromMap(json.decode(source));
}

class DocumentEvent {
  String actor;
  String type;
  String? message;
  DateTime createdAt;
  DocumentEvent({
    required this.actor,
    required this.type,
    this.message,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'actor': actor,
      'type': type,
      'message': message,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory DocumentEvent.fromMap(Map<String, dynamic> map) {
    return DocumentEvent(
      actor: map['actor'] ?? '',
      type: map['type'] ?? '',
      message: map['message'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentEvent.fromJson(String source) =>
      DocumentEvent.fromMap(json.decode(source));
}

class DocumentField {
  WorkflowField field;
  FieldData data;
  DocumentField({
    required this.field,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'field': field.toMap(),
      'data': data.toMap(),
    };
  }

  factory DocumentField.fromMap(Map<String, dynamic> map) {
    return DocumentField(
      field: WorkflowField.fromMap(map['field']),
      data: FieldData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentField.fromJson(String source) =>
      DocumentField.fromMap(json.decode(source));
}

class FieldData {
  bool? boolean;
  String? text;
  DateTime? time;
  FieldFile? file;
  FieldData({
    this.boolean,
    this.text,
    this.time,
    this.file,
  });

  Map<String, dynamic> toMap() {
    return {
      'boolean': boolean,
      'text': text,
      'time': time?.millisecondsSinceEpoch,
      'file': file?.toMap(),
    };
  }

  factory FieldData.fromMap(Map<String, dynamic> map) {
    return FieldData(
      boolean: map['boolean'],
      text: map['text'],
      time: map['time'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['time'])
          : null,
      file: map['file'] != null ? FieldFile.fromMap(map['file']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FieldData.fromJson(String source) =>
      FieldData.fromMap(json.decode(source));
}

class FieldFile {
  String name;
  Uint8List data;

  FieldFile({required this.name, required this.data});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'data': base64Encode(data),
    };
  }

  factory FieldFile.fromMap(Map<String, dynamic> map) {
    return FieldFile(
      name: map['name'] ?? '',
      data: base64Decode(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FieldFile.fromJson(String source) =>
      FieldFile.fromMap(json.decode(source));
}
