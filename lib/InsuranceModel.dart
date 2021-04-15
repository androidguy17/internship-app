
class InsuranceModel {
  String company;
  KeyValues keyValues;
  Template template;

  InsuranceModel({this.company, this.keyValues, this.template});

  InsuranceModel.fromJson(Map<String, dynamic> json) {
    company = json['company'];
    keyValues = json['keyValues'] != null
        ? new KeyValues.fromJson(json['keyValues'])
        : null;
    template = json['template'] != null
        ? new Template.fromJson(json['template'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company'] = this.company;
    if (this.keyValues != null) {
      data['keyValues'] = this.keyValues.toJson();
    }
    if (this.template != null) {
      data['template'] = this.template.toJson();
    }
    return data;
  }
}

class KeyValues {
  String relation;
  String validFror;
  String polHldr;
  String name;
  String mAID;
  String empNo;
  String polNo;

  KeyValues(
      {this.relation,
      this.validFror,
      this.polHldr,
      this.name,
      this.mAID,
      this.empNo,
      this.polNo});

  KeyValues.fromJson(Map<String, dynamic> json) {
    relation = json['Relation'];
    validFror = json['Valid Fror'];
    polHldr = json['Pol Hldr'];
    name = json['Name'];
    mAID = json['MA-ID'];
    empNo = json['Emp. No.'];
    polNo = json['Pol. No.'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Relation'] = this.relation;
    data['Valid Fror'] = this.validFror;
    data['Pol Hldr'] = this.polHldr;
    data['Name'] = this.name;
    data['MA-ID'] = this.mAID;
    data['Emp. No.'] = this.empNo;
    data['Pol. No.'] = this.polNo;
    return data;
  }
}

class Template {
  String name;
  String policy;
  String validFrom;

  Template({this.name, this.policy, this.validFrom});

  Template.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    policy = json['policy'];
    validFrom = json['valid_from'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['policy'] = this.policy;
    data['valid_from'] = this.validFrom;
    return data;
  }
}
