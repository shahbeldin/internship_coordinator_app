// EP == EndPoint

String baseUrl = 'https://openclues.pythonanywhere.com/';

String EP_login = 'token/login/';
String EP_register = 'api/register';

String baseUrl_For_Images = 'https://openclues.pythonanywhere.com/media/';

String baseUrl_For_Files = 'https://openclues.pythonanywhere.com';

String EP_AddInternship = 'coordinator/api/intership';

String EP_Get_Coordintor_All_Data = 'coordinator/api/alldata';

String EP_Update_User_Status(String id) =>
    'coordinator/api/intershipsubmittions/$id';

String EP_Get_Announcements = 'announcements/api/';

String EP_Post_Announcements = 'announcement/api/';

String EP_Get_Official_Letter = 'coordinator/api/officialrequests';

String EP_Update_Official_Letter_Req_Status(String id) =>
    'coordinator/api/officialrequests/$id';

String EP_Post_messages = "chats/";

String EP_Delete_Official_Letter_Reqs(String id) =>
    'coordinator/api/officialrequests/$id';
