class Field {
  List<FieldsList>? fieldslist;

  Field({this.fieldslist});

  Field.fromJson(Map<String, dynamic> json) {
    if (json['fields'] != null) {
      fieldslist = <FieldsList>[];
      json['fields'].forEach((v) {
        fieldslist!.add( FieldsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (fieldslist != null) {
      data['fields'] = fieldslist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FieldsList {
  String? id;
  bool? isGlobal;
  String? orgId;
  String? name;
  String? description;
  String? type;

  FieldsList(
      {this.id,
      this.isGlobal,
      this.orgId,
      this.name,
      this.description,
      this.type});

  FieldsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isGlobal = json['isGlobal'];
    orgId = json['orgId'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isGlobal'] = this.isGlobal;
    data['orgId'] = this.orgId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    return data;
  }
}