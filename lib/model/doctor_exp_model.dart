class DoctorExperienceModel{
  DoctorExperienceModel({
    required this.doctorId,
    required this.experience,
    required this.industry,
    required this.startDate,
    required this.endDate,
  });

  String doctorId;
  String experience;
  String industry;
  String startDate;
  String endDate;

  factory DoctorExperienceModel.fromJson(json) => DoctorExperienceModel(
    doctorId: json["doctor_id"],
    experience: json["experience"],
    industry: json["industry"],
    startDate: json["start_date"],
    endDate: json["end_date"],
  );

  Map<String, dynamic> toJson(DoctorExperienceModel doctorExperienceModel) {
    Map<String, dynamic> edMap = Map();

    edMap["doctor_id"] = doctorExperienceModel.doctorId;
    edMap["experience"] = doctorExperienceModel.experience;
    edMap["industry"] = doctorExperienceModel.industry;
    edMap["start_date"] = doctorExperienceModel.startDate;
    edMap["end_date"] = doctorExperienceModel.endDate;
    return edMap;
  }
}