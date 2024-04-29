import 'dart:convert';

class Workflow {
  late String id;
  late String orgId;
  late String name;
  late String description;
  late String createdAt;
  late String updatedAt;
  late String createdBy;
  late String updatedBy;
  List<WorkflowStep> steps = [];

  Workflow(
      {required this.id,
      required this.orgId,
      required this.name,
      required this.description,
      required this.createdAt,
      required this.createdBy,
      required this.steps,
      required this.updatedAt,
      required this.updatedBy});
  Workflow.fromMap(Map<String, dynamic> json) {
    {
      id = json['id'];
      orgId = json['orgId'];
      name = json['name'];
      description = json['description'];
      createdAt = json['createdAt'];
      createdBy = json['createdBy'];
      updatedAt = json['updatedAt'];
      updatedBy = json['updatedBy'];
      if (json['steps'] != null) {
        steps = <WorkflowStep>[];
        for (var e in (json['steps'] as List)) {
          steps.add(WorkflowStep.fromMap(e));
        }
      }
    }
  }
}

class Flows {
  List<Workflow> workFlows = [];
  Flows({required this.workFlows});

  Flows.fromJson(Map<String, dynamic> json) {
    {
      if (json['workflows'] != null) {
        workFlows = <Workflow>[];
        for (var e in (json['workflows'] as List)) {
          workFlows.add(Workflow.fromMap(e));
        }
      }
    }
  }
}

class WorkflowStep {
   String id;
   int index;
   String title;
   String description;
   String createdAt;
   String updatedAt;
   String createdBy;
   String updatedBy;
   int fieldsCount;
  WorkflowStep({
    required this.id,
    required this.index,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.fieldsCount,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'index': index,
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'fieldsCount': fieldsCount,
    };
  }

  factory WorkflowStep.fromMap(Map<String, dynamic> map) {
    return WorkflowStep(
      id: map['id'] ?? '',
      index: map['index']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      createdBy: map['createdBy'] ?? '',
      updatedBy: map['updatedBy'] ?? '',
      fieldsCount: map['fieldsCount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkflowStep.fromJson(String source) => WorkflowStep.fromMap(json.decode(source));
}
