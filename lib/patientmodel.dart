class PatientModel {
  String code;
  String message;
  List<Patients> patients;
  PageContext pageContext;

  PatientModel({this.code, this.message, this.patients, this.pageContext});

  PatientModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['patients'] != null) {
      patients = new List<Patients>();
      json['patients'].forEach((v) {
        patients.add(new Patients.fromJson(v));
      });
    }
    pageContext = json['page_context'] != null
        ? new PageContext.fromJson(json['page_context'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.patients != null) {
      data['patients'] = this.patients.map((v) => v.toJson()).toList();
    }
    if (this.pageContext != null) {
      data['page_context'] = this.pageContext.toJson();
    }
    return data;
  }
}

class Patients {
  String patientId;
  String firstName;
  String lastName;
  String fullName;
  String dob;
  String dobFormat;
  String isAutoCalculatedDob;
  String recordId;
  String language;
  String createdTime;
  String createdDate;
  String nextVisitDate;
  String appointmentId;
  String active;
  String gender;
  String genderIdentity;
  String email;
  String mobile;
  String homePhone;
  String workPhone;
  String workPhoneExtn;
  String preferredCommunication;
  String primaryPhone;
  String isSilhouette;
  String phrLoginId;
  String accountType;
  String bloodGroup;
  String externalId;
  int lastModifiedTime;
  String addressLine1;
  String addressLine2;
  String city;
  String state;
  String country;
  String postalCode;
  String county;
  String district;
  String maritalStatus;
  String source;
  String category;
  String customFieldValue;

  Patients(
      {this.patientId,
      this.firstName,
      this.lastName,
      this.fullName,
      this.dob,
      this.dobFormat,
      this.isAutoCalculatedDob,
      this.recordId,
      this.language,
      this.createdTime,
      this.createdDate,
      this.nextVisitDate,
      this.appointmentId,
      this.active,
      this.gender,
      this.genderIdentity,
      this.email,
      this.mobile,
      this.homePhone,
      this.workPhone,
      this.workPhoneExtn,
      this.preferredCommunication,
      this.primaryPhone,
      this.isSilhouette,
      this.phrLoginId,
      this.accountType,
      this.bloodGroup,
      this.externalId,
      this.lastModifiedTime,
      this.addressLine1,
      this.addressLine2,
      this.city,
      this.state,
      this.country,
      this.postalCode,
      this.county,
      this.district,
      this.maritalStatus,
      this.source,
      this.category,
      this.customFieldValue});

  Patients.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = json['full_name'];
    dob = json['dob'];
    dobFormat = json['dob_format'];
    isAutoCalculatedDob = json['is_auto_calculated_dob'];
    recordId = json['record_id'];
    language = json['language'];
    createdTime = json['created_time'];
    createdDate = json['created_date'];
    nextVisitDate = json['next_visit_date'];
    appointmentId = json['appointment_id'];
    active = json['active'];
    gender = json['gender'];
    genderIdentity = json['gender_identity'];
    email = json['email'];
    mobile = json['mobile'];
    homePhone = json['home_phone'];
    workPhone = json['work_phone'];
    workPhoneExtn = json['work_phone_extn'];
    preferredCommunication = json['preferred_communication'];
    primaryPhone = json['primary_phone'];
    isSilhouette = json['is_silhouette'];
    phrLoginId = json['phr_login_id'];
    accountType = json['account_type'];
    bloodGroup = json['blood_group'];
    externalId = json['external_id'];
    lastModifiedTime = json['last_modified_time'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    postalCode = json['postal_code'];
    county = json['county'];
    district = json['district'];
    maritalStatus = json['marital_status'];
    source = json['source'];
    category = json['category'];
    customFieldValue = json['custom_field_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['full_name'] = this.fullName;
    data['dob'] = this.dob;
    data['dob_format'] = this.dobFormat;
    data['is_auto_calculated_dob'] = this.isAutoCalculatedDob;
    data['record_id'] = this.recordId;
    data['language'] = this.language;
    data['created_time'] = this.createdTime;
    data['created_date'] = this.createdDate;
    data['next_visit_date'] = this.nextVisitDate;
    data['appointment_id'] = this.appointmentId;
    data['active'] = this.active;
    data['gender'] = this.gender;
    data['gender_identity'] = this.genderIdentity;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['home_phone'] = this.homePhone;
    data['work_phone'] = this.workPhone;
    data['work_phone_extn'] = this.workPhoneExtn;
    data['preferred_communication'] = this.preferredCommunication;
    data['primary_phone'] = this.primaryPhone;
    data['is_silhouette'] = this.isSilhouette;
    data['phr_login_id'] = this.phrLoginId;
    data['account_type'] = this.accountType;
    data['blood_group'] = this.bloodGroup;
    data['external_id'] = this.externalId;
    data['last_modified_time'] = this.lastModifiedTime;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['postal_code'] = this.postalCode;
    data['county'] = this.county;
    data['district'] = this.district;
    data['marital_status'] = this.maritalStatus;
    data['source'] = this.source;
    data['category'] = this.category;
    data['custom_field_value'] = this.customFieldValue;
    return data;
  }
}

class PageContext {
  String page;
  String perPage;
  String hasMorePage;
  String appliedFilter;
  String sortColumn;
  String sortOrder;

  PageContext(
      {this.page,
      this.perPage,
      this.hasMorePage,
      this.appliedFilter,
      this.sortColumn,
      this.sortOrder});

  PageContext.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    hasMorePage = json['has_more_page'];
    appliedFilter = json['applied_filter'];
    sortColumn = json['sort_column'];
    sortOrder = json['sort_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    data['has_more_page'] = this.hasMorePage;
    data['applied_filter'] = this.appliedFilter;
    data['sort_column'] = this.sortColumn;
    data['sort_order'] = this.sortOrder;
    return data;
  }
}
