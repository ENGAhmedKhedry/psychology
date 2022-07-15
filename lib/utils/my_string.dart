import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';

String validationEmail =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

String validationName = r'^[a-z A-Z]+$';
String validationPhone = r'(^(?:[+0]9)?[0-9]{10,12}$)';


const String patientsCollectionKey = "patients";
const String doctorsCollectionKey = "doctors";
const String blogsCollectionKey = "blogs";
const String chatRoomsCollectionKey = "chatRooms";
const String appointmentsCollectionKey = "appointments";
const String educationCollectionKey = "education";
const String diagnosisCollectionKey = "diagnosis";
const String experienceCollectionKey = "experience";
const theSource = AudioSource.microphone;
const String fcmBaseUrl = "https://fcm.googleapis.com/fcm/send";
const String cloudMessagingKey =
    "AAAAFenPfPw:APA91bH_K1eI4bQO_Anr0kEnE28Et5Jbv1M9Lt2f89FjQ1L9eHcsUS2xipacheWxPRiYdcMT6odgjt9WZI94v7RbVcHvO9fWtZJZhcKGljRqbtQ4TpxQsPCp_IILg3rf-4TlId04bw39";
const String APP_ID = "6819746e0af644c597f2899840c1773a";

const String KUid = "uid";
const String callsCollectionKey = "calls";

const String KName = "userNAme";
const String KImageUrl = "UserImageUrl";
const String KEmail = "email";
const String KPhoneNumber = "phoneNum";
const String KGender = "gender";
const String KIsDoctor = "isDoctor";
