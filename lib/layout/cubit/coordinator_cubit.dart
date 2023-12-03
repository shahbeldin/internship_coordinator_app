import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:coordinator_app/models/Announcement_Model.dart';
import 'package:coordinator_app/models/Coordinator_All_Data_Model.dart';
import 'package:coordinator_app/models/Login_Model.dart';
import 'package:coordinator_app/models/Official_Letter_Model.dart';
import 'package:coordinator_app/models/Update_Student_States_Model.dart';
import 'package:coordinator_app/modules/Coordinator_App/Login_Screen.dart';
import 'package:coordinator_app/modules/Coordinator_App/Practice_Requests_Screens/Practice_Requestes.dart';
import 'package:coordinator_app/shared/components/constants.dart';
import 'package:coordinator_app/shared/remote/local/cacheHelper.dart';
import 'package:coordinator_app/shared/remote/network/DioHelper.dart';
import 'package:coordinator_app/shared/remote/network/end_points.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../../shared/components/components.dart';
import 'coordinator_states.dart';

class Coordinator_Cubit extends Cubit<Coordinator_States> {
  Coordinator_Cubit() : super(Coordinator_Intial_State());
  static Coordinator_Cubit get(context) => BlocProvider.of(context);

  bool rememberMe = true;
  void Change_rememberMe(bool value) {
    rememberMe = !rememberMe;
    emit(Random_State());
  }

  bool isSecure = true;
  void Change_isSecure() {
    isSecure = !isSecure;
    emit(Random_State());
  }

  getAllData() {
    if (TOKEN != null) {
      Get_Coordinator_All_Data();
      Get_Announcements();
      Get_Official_Letter_Req();
    }
  }

// Login
  Login_Model? login_model;
  void login({
    required String userName,
    required String password,
  }) {
    isLoading = true;
    emit(Coordinator_Login_Loding_State());
    DioHelper.postData_For_Login(
      url: EP_login,
      data: {"password": password, "username": userName},
    ).then((value) {
      login_model = Login_Model.fromJson(value.data);
      if (login_model!.type == "Coordinator") {
        TOKEN = login_model!.authToken;
        Get_Coordinator_All_Data();
        Get_Announcements();
        Get_Official_Letter_Req();
        print(login_model!.authToken);
        emit(Coordinator_Login_Success_State());
      } else {
        emit(Coordinator_Login_Error_State('You are not coordinator'));
      }
    }).catchError((error) {
      print(error.toString());
      emit(Coordinator_Login_Error_State(error.toString()));
    });
  }

// Register
  void register({
    required String email,
  }) {
    isLoading = true;
    emit(Coordinator_Register_Loding_State());
    DioHelper.postData_For_Login(
      url: EP_register,
      data: {'email': email},
    ).then((value) {
      print(value.statusMessage);
      emit(Coordinator_Register_Success_State(value.statusCode!));
    }).catchError((error) {
      print(error.toString());
      emit(Coordinator_Register_Error_State(error.toString()));
    });
  }

// Logout
  void logout(context) {
    CacheHelper.clearAll();
    TOKEN = null;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login_Screen()),
      (route) => false,
    );
    rememberMe = true;
    cubit(context).coordinator_all_data_model = null;
    cubit(context).announcement_model = null;
    cubit(context).official_letter_model = null;
    My_Toast_Message(msg: 'Logout Successfully');
  }

  late int count = 0;

  bool isLoading = false;
  void isLoading_() {
    isLoading = false;
    emit(Coordinator_Choose_Department_State());
  }

// Add a new internship
  void Add_Internship({
    required String title,
    required String description,
  }) {
    isLoading = true;
    emit(Coordinator_Add_Internship_Loding_State());
    DioHelper.postData(
      url: EP_AddInternship,
      data: {
        "title": title,
        "description": description,
        "due_Time": DateTime.now().toString(),
        "department": Selected_departments,
        "year": Selected_Years
      },
      token: TOKEN,
    ).then((value) {
      Get_Coordinator_All_Data();
      emit(Coordinator_Add_Internship_Success_State());
    }).catchError((error) {
      print(error.toString());
      emit(Coordinator_Add_Internship_Error_State(error.toString()));
    });
  }

// Get All Data of The Coordinator
  Coordinator_All_Data_Model? coordinator_all_data_model;

  List<Practises> practises = [];
  List<dynamic> Under_Review_Reqs = [];
  List<Departments> d = [];
  List<Years> y = [];
  List<MultiSelectItem> departments = [];
  List<MultiSelectItem> years = [];
  List<Chats> chats = [];

  Future Get_Coordinator_All_Data() async {
    emit(Coordinator_Get_Coordinator_All_Data_Loding_State());
    await DioHelper.getData(
      url: EP_Get_Coordintor_All_Data,
      token: TOKEN,
    ).then((value) {
      practises.clear();
      d.clear();
      y.clear();
      departments.clear();
      years.clear();
      chats.clear();

      // The model
      coordinator_all_data_model =
          Coordinator_All_Data_Model.fromJson(value.data);

      // Geting Chats
      coordinator_all_data_model!.chats!.forEach((element) {
        chats.add(element);
      });
      coordinator_all_data_model!.practises!.forEach((element) {
        practises.add(element);
      });
      practises[0].coordinator!.departments!.forEach((e) {
        d.add(e);
      });
      practises[0].coordinator!.years!.forEach((e) {
        y.add(e);
      });
      d.forEach((e) {
        departments.add(MultiSelectItem(e.id, e.name!));
      });
      y.forEach((e) {
        years.add(MultiSelectItem(e.id, e.name!));
      });
      emit(Coordinator_Get_Coordinator_All_Data_Success_State());
    }).catchError((error) {
      print(error.toString());
      emit(Coordinator_Get_Coordinator_All_Data_Error_State(error.toString()));
    });
  }

  void Get_Under_Review_Reqs({
    required BuildContext context,
    required Requests_List,
  }) {
    Under_Review_Reqs = [];
    Requests_List.forEach((element) {
      if (element.status == 0) {
        Under_Review_Reqs.add(element);
      }
    });
    emit(Random_State());
  }

  // Download File
  DownloadFile({
    required String url,
  }) async {
    isLoading = true;
    emit(Coordinator_Download_File_Loding_State());
    try {
      String fileName = url.split('/').last;
      final appStorage = await getApplicationDocumentsDirectory();
      final file = File('${appStorage.path}/${fileName}');
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: const Duration(
            minutes: 1,
          ),
        ),
      );
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      OpenFile.open(file.path);
      final temp = await getTemporaryDirectory();
      final path = '${temp.path}/${fileName}';
      emit(Coordinator_Download_File_Success_State());
    } catch (error) {
      print(error.toString());
      emit(Coordinator_Download_File_Error_State(error.toString()));
    }
  }

// Get Media URL
  String Media_URL({
    required String url,
    bool isFile = false,
  }) {
    String link =
        isFile ? '${baseUrl_For_Files}${url}' : '${baseUrl_For_Images}${url}';

    return link;
  }

// Get Announcement
  Announcement_Model? announcement_model;
  List<Announcement_Model> Announcements = [];
  Future Get_Announcements() async {
    emit(Coordinator_Get_Announcements_Loding_State());
    await DioHelper.getData(
      url: EP_Get_Announcements,
      token: TOKEN,
    ).then((value) {
      Announcements.clear();
      value.data.forEach((announcement) {
        announcement_model = Announcement_Model.fromJson(announcement);
        Announcements.add(announcement_model!);
      });
      emit(Coordinator_Get_Announcements_Success_State());
    }).catchError((error) {
      print(error.toString());
      emit(Coordinator_Get_Announcements_Error_State(error.toString()));
    });
  }

// Add a new announcement
  void Add_Announcement({
    required String title,
    required String description,
  }) {
    isLoading = true;
    emit(Coordinator_Add_Announcement_Loding_State());
    DioHelper.postData(
      url: EP_Post_Announcements,
      data: {
        "title": title,
        "content": description,
        "departments": Selected_departments,
        "years": Selected_Years,
      },
      token: TOKEN,
    ).then((value) {
      Get_Announcements();
      emit(Coordinator_Add_Announcement_Success_State());
    }).catchError((error) {
      emit(Coordinator_Add_Announcement_Error_State(error.toString()));
    });
  }

// Approve And Reject Student
  void Approve_Or_Reject_Student({
    required int UserId,
    required bool isApprove,
    String Rejected_Message = "",
  }) {
    emit(Coordinator_Approve_Or_Reject_Student_Request_Loding_State());
    DioHelper.patchData(
      url: EP_Update_User_Status(UserId.toString()),
      data: {
        "status": isApprove ? 1 : 2,
        "note": Rejected_Message,
      },
      token: TOKEN,
    ).then((value) {
      Get_Coordinator_All_Data();
      emit(Coordinator_Approve_Or_Reject_Student_Request_Success_State(
        isApprove,
      ));
    }).catchError((error) {
      Coordinator_Approve_Or_Reject_Student_Request_Error_State(
          error.toString());
    });
  }

  List<dynamic> Selected_departments = [];
  List<dynamic> Selected_Years = [];
  void Choose_department(values) {
    Selected_departments = values;
    emit(Coordinator_Choose_Department_State());
  }

  void Choose_year(values) {
    Selected_Years = values;
    emit(Coordinator_Choose_Department_State());
  }

// Get File From device.

  FilePickerResult? result;
  PlatformFile? Picked_File;

  void GetFile() async {
    emit(Coordinator_Get_File_Loading_State());
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      Picked_File = result.files.first;
      emit(Coordinator_Get_File_Success_State());
    } else {
      emit(Coordinator_Get_File_Error_State());
    }
  }

// Get Official Letter Requests
  List<Official_Letter_Model> Offical_Letter_Reqs = [];
  Official_Letter_Model? official_letter_model;
  void Get_Official_Letter_Req() {
    emit(Coordinator_Get_Official_Letter_Loding_State());
    DioHelper.getData(
      url: EP_Get_Official_Letter,
      token: TOKEN,
    ).then((value) {
      Offical_Letter_Reqs.clear();
      value.data.forEach((e) {
        official_letter_model = Official_Letter_Model.fromJson(e);
        Offical_Letter_Reqs.add(official_letter_model!);
      });
      emit(Coordinator_Get_Official_Letter_Success_State());
    }).catchError((error) {
      emit(Coordinator_Get_Official_Letter_Error_State(error.toString()));
    });
  }

// Approve/Sign Official Letter
  void Approve_Rej_Official_Letter({
    required bool isApprove,
    required int Req_Id,
  }) {
    isLoading = true;
    emit(Coordinator_Approve_Official_Letter_Request_Loding_State());
    DioHelper.patchData(
      url: EP_Update_Official_Letter_Req_Status(Req_Id.toString()),
      data: {"status": isApprove ? 1 : 2},
      token: TOKEN,
    ).then((value) {
      if (isApprove) {
        updateOfficialLetter(Req_Id: Req_Id);
      }
      Get_Official_Letter_Req();
      emit(Coordinator_Approve_Official_Letter_Request_Success_State(
        isApprove,
      ));
    }).catchError((error) {
      emit(Coordinator_Approve_Official_Letter_Request_Error_State(
          error.toString()));
    });
  }

  Future<String> updateOfficialLetter({
    required int Req_Id,
  }) async {
    String? token = TOKEN;

    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Authorization": "Token $token"
    };

    File file = File(Picked_File!.path.toString());
    final url = Uri.parse(
        "$baseUrl${EP_Update_Official_Letter_Req_Status(Req_Id.toString())}");
    final request = http.MultipartRequest('PATCH', url);

    final multiPartFile = http.MultipartFile(
      'official_letter',
      file.readAsBytes().asStream(),
      file.lengthSync(),
      filename: file.path.split('/').last,
    );

    request.headers.addAll(headers);

    request.files.add(multiPartFile);

    var response = await request.send();
    final responseBody =
        await response.stream.bytesToString(); // get response body

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(responseBody);
      print("<<<<<<<<<<<<<<<<<<<< OKKKK ");
      return decodedResponse['official_letter'];
    } else {
      print(responseBody);
      throw const HttpException('Unable to upload file');
    }
  }

// Post a new messsage.
  void postMessage({
    required int reciever_id,
    required String message_content,
  }) {
    emit(Coordinator_Post_Message_Loding_State());
    DioHelper.postData(
      url: EP_Post_messages,
      data: {'reciever_id': reciever_id, 'message_content': message_content},
      token: TOKEN,
    ).then((value) {
      Get_Coordinator_All_Data();
      emit(Coordinator_Post_Message_Success_State());
    }).catchError((error) {
      print(error.toString());
      emit(Coordinator_Post_Message_Error_State(error.toString()));
    });
  }

// // Delete official letter request
//   void Delete_official_Reqs({
//     required int Req_Id,
//   }) {
//     emit(Coordinator_Delete_Official_Reqs_Loding_State());
//     DioHelper.deleteData(
//       url: EP_Delete_Official_Letter_Reqs(Req_Id.toString()),
//       token: TOKEN,
//     ).then((value) {
//       emit(Coordinator_Delete_Official_Reqs_Success_State());
//     }).catchError((erorr) {
//       emit(Coordinator_Delete_Official_Reqs_Error_State(erorr.toString()));
//     });
//   }
}
