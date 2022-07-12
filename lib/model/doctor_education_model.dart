class DoctorEducationModel {
  DoctorEducationModel({
    required this.doctorId,
    required this.education,
    required this.university,
    required this.speciality,
    required this.startDate,
    required this.endDate,
  });

  String doctorId;
  String education;
  String university;
  String speciality;
  String startDate;
  String endDate;

  factory DoctorEducationModel.fromJson(json) => DoctorEducationModel(
        doctorId: json["doctor_id"],
        education: json["education"],
        university: json["university"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        speciality: json['speciality'],
      );

  Map<String, dynamic> toJson(DoctorEducationModel doctorEducationModel) {
    Map<String, dynamic> edMap = Map();

    edMap["doctor_id"] = doctorEducationModel.doctorId;
    edMap["education"] = doctorEducationModel.education;
    edMap["speciality"] = doctorEducationModel.speciality;
    edMap["university"] = doctorEducationModel.university;
    edMap["start_date"] = doctorEducationModel.startDate;
    edMap["end_date"] = doctorEducationModel.endDate;
    return edMap;
  }
}
