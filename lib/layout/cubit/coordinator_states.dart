abstract class Coordinator_States {}

class Coordinator_Intial_State extends Coordinator_States {}

// Login States
class Coordinator_Login_Loding_State extends Coordinator_States {}

class Coordinator_Login_Success_State extends Coordinator_States {}

class Coordinator_Login_Error_State extends Coordinator_States {
  final String error;
  Coordinator_Login_Error_State(this.error);
}

// Logout States
class Coordinator_Logout_Loding_State extends Coordinator_States {}

class Coordinator_Logout_Success_State extends Coordinator_States {}

class Coordinator_Logout_Error_State extends Coordinator_States {
  final String error;
  Coordinator_Logout_Error_State(this.error);
}

// Register States
class Coordinator_Register_Loding_State extends Coordinator_States {}

class Coordinator_Register_Success_State extends Coordinator_States {
  int statusCode;
  Coordinator_Register_Success_State(this.statusCode);
}

class Coordinator_Register_Error_State extends Coordinator_States {
  final String error;
  Coordinator_Register_Error_State(this.error);
}

// Add Internship States
class Coordinator_Add_Internship_Loding_State extends Coordinator_States {}

class Coordinator_Add_Internship_Success_State extends Coordinator_States {}

class Coordinator_Add_Internship_Error_State extends Coordinator_States {
  final String error;
  Coordinator_Add_Internship_Error_State(this.error);
}

// // Get Internships States
// class Coordinator_GetInternships_Loding_State extends Coordinator_States {}

// class Coordinator_GetInternships_Success_State extends Coordinator_States {}

// class Coordinator_GetInternships_Error_State extends Coordinator_States {
//   final String error;
//   Coordinator_GetInternships_Error_State(this.error);
// }

// // Get Me States
// class Coordinator_GetMe_Loding_State extends Coordinator_States {}

// class Coordinator_GetMe_Success_State extends Coordinator_States {}

// class Coordinator_GetMe_Error_State extends Coordinator_States {
//   final String error;
//   Coordinator_GetMe_Error_State(this.error);
// }

// Get All Data of the Coordinator States
class Coordinator_Get_Coordinator_All_Data_Loding_State
    extends Coordinator_States {}

class Coordinator_Get_Coordinator_All_Data_Success_State
    extends Coordinator_States {}

class Coordinator_Get_Coordinator_All_Data_Error_State
    extends Coordinator_States {
  final String error;
  Coordinator_Get_Coordinator_All_Data_Error_State(this.error);
}

// Download Files States
class Coordinator_Download_File_Loding_State extends Coordinator_States {}

class Coordinator_Download_File_Success_State extends Coordinator_States {}

class Coordinator_Download_File_Error_State extends Coordinator_States {
  final String error;
  Coordinator_Download_File_Error_State(this.error);
}

// Approve student request States
class Coordinator_Approve_Student_Request_Loding_State
    extends Coordinator_States {}

class Coordinator_Approve_Student_Request_Success_State
    extends Coordinator_States {}

class Coordinator_Approve_Student_Request_Error_State
    extends Coordinator_States {
  final String error;
  Coordinator_Approve_Student_Request_Error_State(this.error);
}

// Get Announcements States
class Coordinator_Get_Announcements_Loding_State extends Coordinator_States {}

class Coordinator_Get_Announcements_Success_State extends Coordinator_States {}

class Coordinator_Get_Announcements_Error_State extends Coordinator_States {
  final String error;
  Coordinator_Get_Announcements_Error_State(this.error);
}

// Add Announcement States
class Coordinator_Add_Announcement_Loding_State extends Coordinator_States {}

class Coordinator_Add_Announcement_Success_State extends Coordinator_States {}

class Coordinator_Add_Announcement_Error_State extends Coordinator_States {
  final String error;
  Coordinator_Add_Announcement_Error_State(this.error);
}

// Approve And Reject Student States
class Coordinator_Approve_Or_Reject_Student_Request_Loding_State
    extends Coordinator_States {}

class Coordinator_Approve_Or_Reject_Student_Request_Success_State
    extends Coordinator_States {
  bool isApprove;
  Coordinator_Approve_Or_Reject_Student_Request_Success_State(this.isApprove);
}

class Coordinator_Approve_Or_Reject_Student_Request_Error_State
    extends Coordinator_States {
  final String error;
  Coordinator_Approve_Or_Reject_Student_Request_Error_State(this.error);
}

class Coordinator_Choose_Department_State extends Coordinator_States {}

class Coordinator_Choose_Year_State extends Coordinator_States {}

// Get File States

class Coordinator_Get_File_Loading_State extends Coordinator_States {}

class Coordinator_Get_File_Success_State extends Coordinator_States {}

class Coordinator_Get_File_Error_State extends Coordinator_States {}

// Approve Offical Letter Requests States
class Coordinator_Approve_Official_Letter_Request_Loding_State
    extends Coordinator_States {}

class Coordinator_Approve_Official_Letter_Request_Success_State
    extends Coordinator_States {
  bool isApprove;
  Coordinator_Approve_Official_Letter_Request_Success_State(this.isApprove);
}

class Coordinator_Approve_Official_Letter_Request_Error_State
    extends Coordinator_States {
  final String error;
  Coordinator_Approve_Official_Letter_Request_Error_State(this.error);
}

// Get Official Letter States
class Coordinator_Get_Official_Letter_Loding_State extends Coordinator_States {}

class Coordinator_Get_Official_Letter_Success_State
    extends Coordinator_States {}

class Coordinator_Get_Official_Letter_Error_State extends Coordinator_States {
  final String error;
  Coordinator_Get_Official_Letter_Error_State(this.error);
}

// Post a new message States
class Coordinator_Post_Message_Loding_State extends Coordinator_States {}

class Coordinator_Post_Message_Success_State extends Coordinator_States {}

class Coordinator_Post_Message_Error_State extends Coordinator_States {
  final String error;
  Coordinator_Post_Message_Error_State(this.error);
}

// Delete official letter request States
class Coordinator_Delete_Official_Reqs_Loding_State
    extends Coordinator_States {}

class Coordinator_Delete_Official_Reqs_Success_State
    extends Coordinator_States {}

class Coordinator_Delete_Official_Reqs_Error_State extends Coordinator_States {
  final String error;
  Coordinator_Delete_Official_Reqs_Error_State(this.error);
}

class Random_State extends Coordinator_States {}
