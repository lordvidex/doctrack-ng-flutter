import 'dart:convert';

class WorkFlows{
  late String id;
  late String orgId;
  late String name;
  late String description;
  late String createdAt;
  late String updatedAt;
  late String createdBy;
  late String updatedBy;
   List<WorkFlowSteps> steps = [];

   WorkFlows({
    required this.id,
    required this.orgId,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.createdBy,
    required this.steps,
    required this.updatedAt,
    required this.updatedBy
   });
 WorkFlows.fromJson(Map<String, dynamic> json){
  {
    id = json['id'];
    orgId = json['orgId'];
    name = json['name'];
    description = json['description'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    if(json['steps']!=null){
      steps = <WorkFlowSteps>[];
     (json['steps'] as List).forEach((e) {
      steps.add(WorkFlowSteps.fromJson(e));
      });
    }
  }
 }
  
}
class Flows{
  List<WorkFlows> workFlows = [];
  Flows({required this.workFlows});

  Flows.fromJson(Map<String, dynamic> json){
    {
      if(json['workflows']!=null){
        workFlows = <WorkFlows>[];
        (json['workflows'] as List).forEach((e) {
          workFlows.add(WorkFlows.fromJson(e));
         });
      }
    }
  }
}

class WorkFlowSteps{
  late String id;
  late int index;
  late String title;
  late String description;
  late String createdAt;
  late String updatedAt;
  late String createdBy;
  late String updatedBy;
  late int fieldsCount;


  WorkFlowSteps.fromJson(Map<String, dynamic> json){
  {
    id = json['id'];
    index = json['index'];
    title = json['title'];
    description = json['description'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    fieldsCount = json['fieldsCount'];
    
  }
 }
  
}
