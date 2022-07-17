class DiagnosisModel {
  String patientName;
  String patientId;
  String patientImage;
  String doctorId;
  String doctorName;
  String doctorImage;
  String diseaseName;
  String diagnosis;
  String Date;
  String treatment;

  DiagnosisModel({
    required this.patientName,
    required this.patientId,
    required this.patientImage,
    required this.doctorId,
    required this.doctorName,
    required this.doctorImage,
    required this.diseaseName,
    required this.diagnosis,
    required this.Date,
    required this.treatment,
  });

  Map<String, dynamic> toMap(DiagnosisModel diagnosisModel) {
    Map<String, dynamic> edMap = Map();

      edMap['patientName']= diagnosisModel.patientName;
      edMap['patientId']= diagnosisModel.patientId;
      edMap['patientImage']= diagnosisModel.patientImage;
      edMap['doctorId']= diagnosisModel.doctorId;
      edMap['doctorName']= diagnosisModel.doctorName;
      edMap['doctorImage']= diagnosisModel.doctorImage;
      edMap['diseaseName']= diagnosisModel.diseaseName;
      edMap['diagnosis']= diagnosisModel.diagnosis;
      edMap['Date']= diagnosisModel.Date;
      edMap['treatment']= diagnosisModel.treatment;
   return edMap;
  }

  factory DiagnosisModel.fromMap(  map) {
    return DiagnosisModel(
      patientName: map['patientName'] as String,
      patientId: map['patientId'] as String,
      patientImage: map['patientImage'] as String,
      doctorId: map['doctorId'] as String,
      doctorName: map['doctorName'] as String,
      doctorImage: map['doctorImage'] as String,
      diseaseName: map['diseaseName'] as String,
      diagnosis: map['diagnosis'] as String,
      Date: map['Date'] as String,
      treatment: map['treatment'] as String,
    );
  }
}
