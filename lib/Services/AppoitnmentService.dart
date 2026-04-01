import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:heart_disease_prediction/main.dart';
import 'package:heart_disease_prediction/models/doctor_profile_model.dart';
import 'package:heart_disease_prediction/models/doctors_list_model.dart';
import 'package:heart_disease_prediction/models/lab_profile_model.dart';
import 'package:heart_disease_prediction/models/labs_model.dart';
import 'package:heart_disease_prediction/models/medical_tests_model.dart';
import 'package:heart_disease_prediction/models/my_appointments_model.dart';
import 'package:heart_disease_prediction/models/notifications_model.dart';
import 'package:heart_disease_prediction/models/patients_list_model.dart';
import 'package:heart_disease_prediction/models/prediction_details.dart';
import 'package:heart_disease_prediction/models/prescription_info.dart';
import 'package:heart_disease_prediction/models/test_details_model.dart';
import 'package:heart_disease_prediction/models/view_patient_prescriptions_model.dart';

class AppoitnmentsService {
  final Dio dio;

  AppoitnmentsService(this.dio);

  Future<List<AppoitnmentsModel>> getDoctors() async {
    Response response = await dio.get(
        'http://heartdiseasepredictionapi.runasp.net/api/Doctor'); // call the API

    List<AppoitnmentsModel> getAllDoctorsmodel = AppoitnmentsModel.fromJson(response
        .data); // get the data from the json of the API and pass it to the model constructor and build the object

    return getAllDoctorsmodel;
  }

  Future<DoctorProfileModel> getDoctorsProfiles(int id) async {
    Response response = await dio.get(
        'http://heartdiseasepredictionapi.runasp.net/api/Doctor/GetDoctorById?id=$id'); // call the API

    DoctorProfileModel getDoctorProfile = DoctorProfileModel.fromJson(
        response.data); //parsing json to objects of the class

    return getDoctorProfile;
  }

  Future<Response> PostDoctorAppoitnment(
    int id,
    String date,
    String time,
    String phone,
    String name,
  ) async {
    Map data = {
      "Date": date,
      "Time": time,
      "PatientPhone": phone,
      "PateintName": name
    };

    dio.options.headers['Authorization'] = 'Bearer $globalToken';

    Response response = await dio.post(
        'http://heartdiseasepredictionapi.runasp.net/api/Appointment/BookAppointment?id=$id',
        data: data);

    return response;
  }

  Future<List<PatientsListForDoctorModel>>
      getReservedPatientsForDoctor() async {
    dio.options.headers['Authorization'] = 'Bearer $globalToken';
    Response response = await dio.get(
        'http://heartdiseasepredictionapi.runasp.net/api/Appointment/GetAppointmentByEmail'); // call the API

    List<PatientsListForDoctorModel> getPatientListModel =
        PatientsListForDoctorModel.fromJson(response
            .data); // get the data from the json of the API and pass it to the model constructor and build the object

    return getPatientListModel;
  }

  Future<Response> AcceptAppoitnment(int id) async {
    dio.options.headers['Authorization'] = 'Bearer $globalToken';

    Response response = await dio.post(
        'http://heartdiseasepredictionapi.runasp.net/api/Appointment/Accept?id=$id');

    return response;
  }

  Future<Response> CancelAppoitnment(int id) async {
    dio.options.headers['Authorization'] = 'Bearer $globalToken';

    Response response = await dio.post(
        'http://heartdiseasepredictionapi.runasp.net/api/Appointment/CancelByDoctor?id=$id');

    return response;
  }

  Future<List<ViewPatientPrescriptionsModel>> getPatientPrescriptions(
      int id) async {
    dio.options.headers['Authorization'] = 'Bearer $globalToken';
    Response response = await dio.get(
        'http://heartdiseasepredictionapi.runasp.net/api/Prescription/GetPatientPrescriptions?id=$id'); // call the API

    List<ViewPatientPrescriptionsModel> getPatientPrescriptionsModel =
        ViewPatientPrescriptionsModel.fromJson(response
            .data); // get the data from the json of the API and pass it to the model constructor and build the object

    return getPatientPrescriptionsModel;
  }

  Future<List<MedicalTestsModel>> getPatientMedicalTestsLab(int id) async {
    dio.options.headers['Authorization'] = 'Bearer $globalToken';
    Response response = await dio.get(
        'http://heartdiseasepredictionapi.runasp.net/api/MedicalTest/GetPatientMedicalTest?id=$id'); // call the API

    List<MedicalTestsModel> getPatientMedicalTestssModel =
        MedicalTestsModel.fromJson(response
            .data); // get the data from the json of the API and pass it to the model constructor and build the object

    return getPatientMedicalTestssModel;
  }

  Future<List<MedicalTestsModelDoc>> getPatientMedicalTestsDoc(int id) async {
    dio.options.headers['Authorization'] = 'Bearer $globalToken';
    Response response = await dio.get(
        'http://heartdiseasepredictionapi.runasp.net/api/MedicalTest/GetPatientMedicalTestByDoctor?id=$id'); // call the API

    List<MedicalTestsModelDoc> getPatientTestssModel =
        MedicalTestsModelDoc.fromJson(response
            .data); // get the data from the json of the API and pass it to the model constructor and build the object

    return getPatientTestssModel;
  }

  Future<PrescriptionInfoModel> getPrescriptionInfo(int id) async {
    Response response = await dio.get(
        'http://heartdiseasepredictionapi.runasp.net/api/Prescription/GetPrescriptionById?id=$id'); // call the API

    PrescriptionInfoModel getPrescriptionInfo = PrescriptionInfoModel.fromJson(
        response.data); //parsing json to objects of the class

    return getPrescriptionInfo;
  }

  Future<Response> PostPrescription(int id, String medicines) async {
    Map data = {
      "MedicineName": medicines,
    };

    dio.options.headers['Authorization'] = 'Bearer $globalToken';

    Response response = await dio.post(
        'http://heartdiseasepredictionapi.runasp.net/api/Prescription/CreatePrescription?id=$id',
        data: data);

    return response;
  }

  Future<List<ViewAllDoctorPrescriptionsModel>> getAllPrescriptions() async {
    //get all prescriptions for doctor
    dio.options.headers['Authorization'] = 'Bearer $globalToken';
    Response response = await dio.get(
        'http://heartdiseasepredictionapi.runasp.net/api/Prescription'); // call the API

    List<ViewAllDoctorPrescriptionsModel> getAllPrescriptionsModel =
        ViewAllDoctorPrescriptionsModel.fromJson(response
            .data); // get the data from the json of the API and pass it to the model constructor and build the object

    return getAllPrescriptionsModel;
  }

  Future<List<MedicalTestsModelLab>> getAllTests() async {
    dio.options.headers['Authorization'] = 'Bearer $globalToken';
    Response response = await dio.get(
        'http://heartdiseasepredictionapi.runasp.net/api/MedicalTest/GetMedicalTestsByUserId'); // call the API

    List<MedicalTestsModelLab> getAllTestsModel = MedicalTestsModelLab.fromJson(
        response
            .data); // get the data from the json of the API and pass it to the model constructor and build the object

    return getAllTestsModel;
  }

  Future<List<ViewAllPatientPrescriptionsModel>>
      getAllPatientPrescriptions() async {
    //get all prescriptions for doctor
    dio.options.headers['Authorization'] = 'Bearer $globalToken';
    Response response = await dio.get(
        'http://heartdiseasepredictionapi.runasp.net/api/Prescription/GetAllPrescriptionsByEmail'); // call the API

    List<ViewAllPatientPrescriptionsModel> getAllPrescriptionsModel =
        ViewAllPatientPrescriptionsModel.fromJson(response
            .data); // get the data from the json of the API and pass it to the model constructor and build the object

    return getAllPrescriptionsModel;
  }

  Future<Response> AddNewPrescription(
      String medicines, String email, int ssn, int docId) async {
    Map data = {
      "MedicineName": medicines,
      "date": DateTime.now(),
      "PatientEmail": email,
      "PatientSSN": ssn,
      "DoctorId": docId
    };

    dio.options.headers['Authorization'] = 'Bearer $globalToken';

    Response response = await dio.post(
        'http://heartdiseasepredictionapi.runasp.net/api/Prescription/Create',
        data: data);

    return response;
  }

  Future<List<NotificationsModel>> getNotifications() async {
    dio.options.headers['Authorization'] = 'Bearer $globalToken';
    Response response = await dio.get(
        'http://heartdiseasepredictionapi.runasp.net/api/Appointment/GetMessagetByEmail'); // call the API

    List<NotificationsModel> getNotificationsModel =
        NotificationsModel.fromJson(response
            .data); // get the data from the json of the API and pass it to the model constructor and build the object

    return getNotificationsModel;
  }

  Future<List<MyUpcomingAppointmentsModel>> getMyAppointments() async {
    dio.options.headers['Authorization'] = 'Bearer $globalToken';
    Response response = await dio.get(
        'http://heartdiseasepredictionapi.runasp.net/api/Appointment'); // call the API

    List<MyUpcomingAppointmentsModel> getMyAppointmentsmodel =
        MyUpcomingAppointmentsModel.fromJson(response
            .data); // get the data from the json of the API and pass it to the model constructor and build the object

    return getMyAppointmentsmodel;
  }

  Future<List<MyCanceledAppointmentsModel>> getMyCanceledAppointments() async {
    dio.options.headers['Authorization'] = 'Bearer $globalToken';
    Response response = await dio.get(
        'http://heartdiseasepredictionapi.runasp.net/api/Appointment/GetAcceptAndCancelAppointments'); // call the API

    List<MyCanceledAppointmentsModel> getMyCanceledAppointmentsmodel =
        MyCanceledAppointmentsModel.fromJson(response
            .data); // get the data from the json of the API and pass it to the model constructor and build the object

    return getMyCanceledAppointmentsmodel;
  }

  Future<List<MyCompletedAppointmentsModel>>
      getMyCompletedAppointments() async {
    dio.options.headers['Authorization'] = 'Bearer $globalToken';
    Response response = await dio.get(
        'http://heartdiseasepredictionapi.runasp.net/api/Appointment/GetAcceptAndCancelAppointments'); // call the API

    List<MyCompletedAppointmentsModel> getMyCompletedAppointmentsmodel =
        MyCompletedAppointmentsModel.fromJson(response
            .data); // get the data from the json of the API and pass it to the model constructor and build the object

    return getMyCompletedAppointmentsmodel;
  }

  Future<void> CancelAppointment(int id) async {
    dio.options.headers['Authorization'] = 'Bearer $globalToken';

    Response response = await dio.post(
        'http://heartdiseasepredictionapi.runasp.net/api/Appointment/CancelByPatient?id=$id');
  }

  Future<List<MedicalTestsModel>> getMedicalTests() async {
    dio.options.headers['Authorization'] = 'Bearer $globalToken';
    Response response = await dio.get(
        'http://heartdiseasepredictionapi.runasp.net/api/MedicalTest/GetMedicalTestsByEmail');

    List<MedicalTestsModel> getMedicalTestModel =
        MedicalTestsModel.fromJson(response.data);

    return getMedicalTestModel;
  }

  Future<List<getLabsModel>> getLabs() async {
    Response response =
        await dio.get('http://heartdiseasepredictionapi.runasp.net/api/Lab');

    List<getLabsModel> getLabsmodel = getLabsModel.fromJson(response.data);

    return getLabsmodel;
  }

  Future<LabProfileModel> getLabProfile(int id) async {
    Response response = await dio.get(
        'http://heartdiseasepredictionapi.runasp.net/api/Lab/GetLabDetails?id=$id');

    LabProfileModel getLabProfile = LabProfileModel.fromJson(response.data);

    return getLabProfile;
  }

  Future<Response> PostLabAppoitnment(
    int id,
    String date,
    String time,
    String phone,
    String name,
  ) async {
    Map data = {
      "Date": date,
      "Time": time,
      "PatientPhone": phone,
      "PateintName": name
    };

    dio.options.headers['Authorization'] = 'Bearer $globalToken';

    Response response = await dio.post(
        'http://heartdiseasepredictionapi.runasp.net/api/LabAppointment/BookLabAppointment?id=$id',
        data: data);

    return response;
  }

  Future<TestDetailsModel> getTestDetails(int id) async {
    dio.options.headers['Authorization'] = 'Bearer $globalToken';

    Response response = await dio.get(
        'http://heartdiseasepredictionapi.runasp.net/api/MedicalTest/GetMedicalDetails?id=$id');

    TestDetailsModel getTestDetails = TestDetailsModel.fromJson(response.data);

    return getTestDetails;
  }

  Future<List<PatientsListForLabModel>> getReservedPatientsForLab() async {
    dio.options.headers['Authorization'] = 'Bearer $globalToken';
    Response response = await dio.get(
        'http://heartdiseasepredictionapi.runasp.net/api/LabAppointment/GetLabAppointmentByEmail');

    List<PatientsListForLabModel> getPatientListModel =
        PatientsListForLabModel.fromJson(response.data);

    return getPatientListModel;
  }

  Future<Response> AcceptLabAppoitnment(int id) async {
    dio.options.headers['Authorization'] = 'Bearer $globalToken';

    Response response = await dio.post(
        'http://heartdiseasepredictionapi.runasp.net/api/LabAppointment/Accept?id=$id');

    return response;
  }

  Future<Response> CancelLabAppoitnment(int id) async {
    dio.options.headers['Authorization'] = 'Bearer $globalToken';

    Response response = await dio.post(
        'http://heartdiseasepredictionapi.runasp.net/api/LabAppointment/CancelByMedicalAnalyst?id=$id');

    return response;
  }

  Future<Response> AddMedcialTest(
      {required dynamic id,
      required dynamic age,
      required dynamic gender,
      required dynamic smoking,
      required dynamic numberOfCigarettes,
      required dynamic bloodPressureMedicine,
      required dynamic prevalentStroke,
      required dynamic prevalentHyperTension,
      required dynamic diabetes,
      required dynamic cholesterolLevel,
      required dynamic systolicBloodPressure,
      required dynamic diastolicBloodPressure,
      required dynamic bMI,
      required dynamic heartRate,
      required dynamic glucoseLevel,
      required String superVisorName,
      required String date}) async {
    Map data = {
      "Age": age,
      "Gender": gender,
      "Smoking": smoking,
      "NumberOfCigarettes": numberOfCigarettes,
      "BloodPressureMedicine": bloodPressureMedicine,
      "PrevalentStroke": prevalentStroke,
      "Prevalenthypertension": prevalentHyperTension,
      "Diabetes": diabetes,
      "CholesterolLevel": cholesterolLevel,
      "SystolicBloodPressure": systolicBloodPressure,
      "DiastolicBloodPressure": diastolicBloodPressure,
      "BMI": bMI,
      "HeartRate": heartRate,
      "GlucoseLevel": glucoseLevel,
      "MedicalAnalystName": superVisorName,
      "Date": date
    };

    dio.options.headers['Authorization'] = 'Bearer $globalToken';

    Response response = await dio.post(
        'http://heartdiseasepredictionapi.runasp.net/api/MedicalTest/CreateMedicalTest?id=$id',
        data: data);

    return response;
  }

  Future<PredictionResultModel> MakePrediction(
      {required dynamic gender,
      required dynamic age,
      required dynamic smoking,
      required dynamic numberOfCigarettes,
      required dynamic bloodPressureMedicine,
      required dynamic prevalentStroke,
      required dynamic prevalentHyperTension,
      required dynamic diabetes,
      required dynamic cholesterolLevel,
      required dynamic systolicBloodPressure,
      required dynamic diastolicBloodPressure,
      required dynamic bMI,
      required dynamic heartRate,
      required dynamic glucoseLevel}) async {
    Map data = {
      "sex": gender,
      "age": age,
      "Smoker": smoking,
      "CigsPerDay": numberOfCigarettes,
      "BPMeds": bloodPressureMedicine,
      "PrevalentStroke": prevalentStroke,
      "PrevalentHyp": prevalentHyperTension,
      "Diabetes": diabetes,
      "Cholesterol": cholesterolLevel,
      "sysBP": systolicBloodPressure,
      "diaBP": diastolicBloodPressure,
      "BMI": bMI,
      "HeartRate": heartRate,
      "Glucose": glucoseLevel
    };

    Response response = await dio
        .post('https://heart-project-2-4.onrender.com/predict', data: data);

    PredictionResultModel getPredictionDetails =
        PredictionResultModel.fromJson(response.data);

    return getPredictionDetails;
  }

  Future<Response> SavePredictionResult(
      {required int id,
      required dynamic gender,
      required dynamic age,
      required dynamic smoking,
      required dynamic numberOfCigarettes,
      required dynamic bloodPressureMedicine,
      required dynamic prevalentStroke,
      required dynamic prevalentHyperTension,
      required dynamic diabetes,
      required dynamic cholesterolLevel,
      required dynamic systolicBloodPressure,
      required dynamic diastolicBloodPressure,
      required dynamic bMI,
      required dynamic heartRate,
      required dynamic glucoseLevel,
      required dynamic predictionResult,
      required dynamic probability}) async {
    Map data = {
      "Sex": gender,
      "Age": age,
      "Smoker": smoking,
      "CigsPerDay": numberOfCigarettes,
      "BPMeds": bloodPressureMedicine,
      "PrevalentStroke": prevalentStroke,
      "PrevalentHyp": prevalentHyperTension,
      "Diabetes": diabetes,
      "Cholesterol": cholesterolLevel,
      "SysBP": systolicBloodPressure,
      "DiaBP": diastolicBloodPressure,
      "BMI": bMI,
      "HeartRate": heartRate,
      "Glucose": glucoseLevel,
      "prediction": predictionResult,
      "Probability": probability
    };

    dio.options.headers['Authorization'] = 'Bearer $globalToken';

    Response response = await dio.put(
        'http://heartdiseasepredictionapi.runasp.net/api/MedicalTest/MakePrediction?id=$id',
        data: data);

    return response;
  }
}
