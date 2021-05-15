class ModelInsurances {
  String code;
  String message;
  List<Insurances> insurances;

  ModelInsurances({this.code, this.message, this.insurances});

  ModelInsurances.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['insurances'] != null) {
      insurances = new List<Insurances>();
      json['insurances'].forEach((v) {
        insurances.add(new Insurances.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.insurances != null) {
      data['insurances'] = this.insurances.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Insurances {
  String endDate;
  String planType;
  String payerAddressLine1;
  String validFrom;
  String employerName;
  String payerZipCode;
  String payerPhone;
  InsuredPersonDetails insuredPersonDetails;
  String patientInsuranceId;
  String type;
  String coinsurance;
  String payerCity;
  String dateOfSignature;
  String payerFax;
  String policyNumber;
  String validTo;
  String payerState;
  String copay;
  String additionalPrDetails;
  String relationship;
  String startDate;
  String insuranceId;
  String releaseMedicalInfo;
  bool isActive;
  String comments;
  String eligibilityPayerId;
  String policyGroupNumber;
  int insuranceAddedBy;
  String planName;
  String insurancePlanName;
  String insuranceType;
  String insuranceCategory;
  String insuranceAddedThrough;
  String insurancePlanId;
  String deductible;
  String payerCountry;
  String payerId;
  String assignMedicalBenefits;
  String isPatientUniqueMid;
  List<PriorAuthorizationDetails> priorAuthorizationDetails;
  String payerName;
  String insuranceAddedDate;

  Insurances(
      {this.endDate,
      this.planType,
      this.payerAddressLine1,
      this.validFrom,
      this.employerName,
      this.payerZipCode,
      this.payerPhone,
      this.insuredPersonDetails,
      this.patientInsuranceId,
      this.type,
      this.coinsurance,
      this.payerCity,
      this.dateOfSignature,
      this.payerFax,
      this.policyNumber,
      this.validTo,
      this.payerState,
      this.copay,
      this.additionalPrDetails,
      this.relationship,
      this.startDate,
      this.insuranceId,
      this.releaseMedicalInfo,
      this.isActive,
      this.comments,
      this.eligibilityPayerId,
      this.policyGroupNumber,
      this.insuranceAddedBy,
      this.planName,
      this.insurancePlanName,
      this.insuranceType,
      this.insuranceCategory,
      this.insuranceAddedThrough,
      this.insurancePlanId,
      this.deductible,
      this.payerCountry,
      this.payerId,
      this.assignMedicalBenefits,
      this.isPatientUniqueMid,
      this.priorAuthorizationDetails,
      this.payerName,
      this.insuranceAddedDate});

  Insurances.fromJson(Map<String, dynamic> json) {
    endDate = json['end_date'];
    planType = json['plan_type'];
    payerAddressLine1 = json['payer_address_line_1'];
    validFrom = json['valid_from'];
    employerName = json['employer_name'];
    payerZipCode = json['payer_zip_code'];
    payerPhone = json['payer_phone'];
    insuredPersonDetails = json['insured_person_details'] != null
        ? new InsuredPersonDetails.fromJson(json['insured_person_details'])
        : null;
    patientInsuranceId = json['patient_insurance_id'];
    type = json['type'];
    coinsurance = json['coinsurance'];
    payerCity = json['payer_city'];
    dateOfSignature = json['date_of_signature'];
    payerFax = json['payer_fax'];
    policyNumber = json['policy_number'];
    validTo = json['valid_to'];
    payerState = json['payer_state'];
    copay = json['copay'];
    additionalPrDetails = json['additional_pr_details'];
    relationship = json['relationship'];
    startDate = json['start_date'];
    insuranceId = json['insurance_id'];
    releaseMedicalInfo = json['release_medical_info'];
    isActive = json['is_active'];
    comments = json['comments'];
    eligibilityPayerId = json['eligibility_payer_id'];
    policyGroupNumber = json['policy_group_number'];
    insuranceAddedBy = json['insurance_added_by'];
    planName = json['plan_name'];
    insurancePlanName = json['insurance_plan_name'];
    insuranceType = json['insurance_type'];
    insuranceCategory = json['insurance_category'];
    insuranceAddedThrough = json['insurance_added_through'];
    insurancePlanId = json['insurance_plan_id'];
    deductible = json['deductible'];
    payerCountry = json['payer_country'];
    payerId = json['payer_id'];
    assignMedicalBenefits = json['assign_medical_benefits'];
    isPatientUniqueMid = json['is_patient_unique_mid'];
    if (json['prior_authorization_details'] != null) {
      priorAuthorizationDetails = new List<PriorAuthorizationDetails>();
      json['prior_authorization_details'].forEach((v) {
        priorAuthorizationDetails
            .add(new PriorAuthorizationDetails.fromJson(v));
      });
    }
    payerName = json['payer_name'];
    insuranceAddedDate = json['insurance_added_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['end_date'] = this.endDate;
    data['plan_type'] = this.planType;
    data['payer_address_line_1'] = this.payerAddressLine1;
    data['valid_from'] = this.validFrom;
    data['employer_name'] = this.employerName;
    data['payer_zip_code'] = this.payerZipCode;
    data['payer_phone'] = this.payerPhone;
    if (this.insuredPersonDetails != null) {
      data['insured_person_details'] = this.insuredPersonDetails.toJson();
    }
    data['patient_insurance_id'] = this.patientInsuranceId;
    data['type'] = this.type;
    data['coinsurance'] = this.coinsurance;
    data['payer_city'] = this.payerCity;
    data['date_of_signature'] = this.dateOfSignature;
    data['payer_fax'] = this.payerFax;
    data['policy_number'] = this.policyNumber;
    data['valid_to'] = this.validTo;
    data['payer_state'] = this.payerState;
    data['copay'] = this.copay;
    data['additional_pr_details'] = this.additionalPrDetails;
    data['relationship'] = this.relationship;
    data['start_date'] = this.startDate;
    data['insurance_id'] = this.insuranceId;
    data['release_medical_info'] = this.releaseMedicalInfo;
    data['is_active'] = this.isActive;
    data['comments'] = this.comments;
    data['eligibility_payer_id'] = this.eligibilityPayerId;
    data['policy_group_number'] = this.policyGroupNumber;
    data['insurance_added_by'] = this.insuranceAddedBy;
    data['plan_name'] = this.planName;
    data['insurance_plan_name'] = this.insurancePlanName;
    data['insurance_type'] = this.insuranceType;
    data['insurance_category'] = this.insuranceCategory;
    data['insurance_added_through'] = this.insuranceAddedThrough;
    data['insurance_plan_id'] = this.insurancePlanId;
    data['deductible'] = this.deductible;
    data['payer_country'] = this.payerCountry;
    data['payer_id'] = this.payerId;
    data['assign_medical_benefits'] = this.assignMedicalBenefits;
    data['is_patient_unique_mid'] = this.isPatientUniqueMid;
    if (this.priorAuthorizationDetails != null) {
      data['prior_authorization_details'] =
          this.priorAuthorizationDetails.map((v) => v.toJson()).toList();
    }
    data['payer_name'] = this.payerName;
    data['insurance_added_date'] = this.insuranceAddedDate;
    return data;
  }
}

class InsuredPersonDetails {
  String insuredPersonRelationship;
  String insuredPersonGender;
  String insuredPersonFirstName;
  String insuredPersonMobilePhone;
  String insuredPersonSsn;
  String insuredPersonAddressLine1;
  String insuredPersonAddressLine2;
  String insuredPersonDob;
  String insuredPersonHomePhone;
  String insuredPersonMiddleName;
  String insuredPersonCity;
  String insuredPersonLastName;
  String insuredPersonState;
  String insuredPersonCountry;
  String insuredPersonZipcode;

  InsuredPersonDetails(
      {this.insuredPersonRelationship,
      this.insuredPersonGender,
      this.insuredPersonFirstName,
      this.insuredPersonMobilePhone,
      this.insuredPersonSsn,
      this.insuredPersonAddressLine1,
      this.insuredPersonAddressLine2,
      this.insuredPersonDob,
      this.insuredPersonHomePhone,
      this.insuredPersonMiddleName,
      this.insuredPersonCity,
      this.insuredPersonLastName,
      this.insuredPersonState,
      this.insuredPersonCountry,
      this.insuredPersonZipcode});

  InsuredPersonDetails.fromJson(Map<String, dynamic> json) {
    insuredPersonRelationship = json['insured_person_relationship'];
    insuredPersonGender = json['insured_person_gender'];
    insuredPersonFirstName = json['insured_person_first_name'];
    insuredPersonMobilePhone = json['insured_person_mobile_phone'];
    insuredPersonSsn = json['insured_person_ssn'];
    insuredPersonAddressLine1 = json['insured_person_address_line_1'];
    insuredPersonAddressLine2 = json['insured_person_address_line_2'];
    insuredPersonDob = json['insured_person_dob'];
    insuredPersonHomePhone = json['insured_person_home_phone'];
    insuredPersonMiddleName = json['insured_person_middle_name'];
    insuredPersonCity = json['insured_person_city'];
    insuredPersonLastName = json['insured_person_last_name'];
    insuredPersonState = json['insured_person_state'];
    insuredPersonCountry = json['insured_person_country'];
    insuredPersonZipcode = json['insured_person_zipcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['insured_person_relationship'] = this.insuredPersonRelationship;
    data['insured_person_gender'] = this.insuredPersonGender;
    data['insured_person_first_name'] = this.insuredPersonFirstName;
    data['insured_person_mobile_phone'] = this.insuredPersonMobilePhone;
    data['insured_person_ssn'] = this.insuredPersonSsn;
    data['insured_person_address_line_1'] = this.insuredPersonAddressLine1;
    data['insured_person_address_line_2'] = this.insuredPersonAddressLine2;
    data['insured_person_dob'] = this.insuredPersonDob;
    data['insured_person_home_phone'] = this.insuredPersonHomePhone;
    data['insured_person_middle_name'] = this.insuredPersonMiddleName;
    data['insured_person_city'] = this.insuredPersonCity;
    data['insured_person_last_name'] = this.insuredPersonLastName;
    data['insured_person_state'] = this.insuredPersonState;
    data['insured_person_country'] = this.insuredPersonCountry;
    data['insured_person_zipcode'] = this.insuredPersonZipcode;
    return data;
  }
}

class PriorAuthorizationDetails {
  String priorAuthorizationValidFrom;
  String additionalInformation;
  String priorAuthorizationNumber;
  String priorAuthorizationType;
  String priorAuthorizationValidUntil;

  PriorAuthorizationDetails(
      {this.priorAuthorizationValidFrom,
      this.additionalInformation,
      this.priorAuthorizationNumber,
      this.priorAuthorizationType,
      this.priorAuthorizationValidUntil});

  PriorAuthorizationDetails.fromJson(Map<String, dynamic> json) {
    priorAuthorizationValidFrom = json['prior_authorization_valid_from'];
    additionalInformation = json['additional_information'];
    priorAuthorizationNumber = json['prior_authorization_number'];
    priorAuthorizationType = json['prior_authorization_type'];
    priorAuthorizationValidUntil = json['prior_authorization_valid_until'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prior_authorization_valid_from'] = this.priorAuthorizationValidFrom;
    data['additional_information'] = this.additionalInformation;
    data['prior_authorization_number'] = this.priorAuthorizationNumber;
    data['prior_authorization_type'] = this.priorAuthorizationType;
    data['prior_authorization_valid_until'] = this.priorAuthorizationValidUntil;
    return data;
  }
}
