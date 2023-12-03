class Coordinator_All_Data_Model {
  int? user;
  List<Chats>? chats;
  dynamic name;
  dynamic profilePic;
  dynamic email;
  List<Practises>? practises;

  Coordinator_All_Data_Model(
      {this.user,
      this.chats,
      this.name,
      this.profilePic,
      this.email,
      this.practises});

  Coordinator_All_Data_Model.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    if (json['chats'] != null) {
      chats = <Chats>[];
      json['chats'].forEach((v) {
        chats!.add(new Chats.fromJson(v));
      });
    }
    name = json['name'];
    profilePic = json['profile_pic'];
    email = json['email'];
    if (json['practises'] != null) {
      practises = <Practises>[];
      json['practises'].forEach((v) {
        practises!.add(new Practises.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    if (this.chats != null) {
      data['chats'] = this.chats!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['profile_pic'] = this.profilePic;
    data['email'] = this.email;
    if (this.practises != null) {
      data['practises'] = this.practises!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chats {
  int? id;
  FirstParticipant? firstParticipant;
  SecondParticipant? secondParticipant;
  List<Messages>? messages;

  Chats(
      {this.id, this.firstParticipant, this.secondParticipant, this.messages});

  Chats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstParticipant = json['first_participant'] != null
        ? new FirstParticipant.fromJson(json['first_participant'])
        : null;
    secondParticipant = json['second_participant'] != null
        ? new SecondParticipant.fromJson(json['second_participant'])
        : null;
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.firstParticipant != null) {
      data['first_participant'] = this.firstParticipant!.toJson();
    }
    if (this.secondParticipant != null) {
      data['second_participant'] = this.secondParticipant!.toJson();
    }
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FirstParticipant {
  int? id;
  dynamic username;
  dynamic firstName;
  dynamic lastName;
  dynamic profilePic;

  FirstParticipant(
      {this.id, this.username, this.firstName, this.lastName, this.profilePic});

  FirstParticipant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}

class SecondParticipant {
  int? id;
  dynamic username;
  dynamic firstName;
  dynamic lastName;
  dynamic profilePic;

  SecondParticipant(
      {this.id, this.username, this.firstName, this.lastName, this.profilePic});

  SecondParticipant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}

class Messages {
  int? id;
  int? chat;
  dynamic sender;
  dynamic receiver;
  dynamic content;
  String? timestamp;
  bool? isread;

  Messages(
      {this.id,
      this.chat,
      this.sender,
      this.receiver,
      this.content,
      this.timestamp,
      this.isread});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chat = json['chat'];
    sender = json['sender'];
    receiver = json['receiver'];
    content = json['content'];
    timestamp = json['timestamp'];
    isread = json['isread'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chat'] = this.chat;
    data['sender'] = this.sender;
    data['receiver'] = this.receiver;
    data['content'] = this.content;
    data['timestamp'] = this.timestamp;
    data['isread'] = this.isread;
    return data;
  }
}

class Practises {
  int? id;
  List<PractiseSubmissions>? practiseSubmissions;
  Coordinator? coordinator;
  dynamic title;
  dynamic description;
  String? dueTime;
  List<int>? department;
  List<int>? year;

  Practises(
      {this.id,
      this.practiseSubmissions,
      this.coordinator,
      this.title,
      this.description,
      this.dueTime,
      this.department,
      this.year});

  Practises.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['PractiseSubmissions'] != null) {
      practiseSubmissions = <PractiseSubmissions>[];
      json['PractiseSubmissions'].forEach((v) {
        practiseSubmissions!.add(new PractiseSubmissions.fromJson(v));
      });
    }
    coordinator = json['coordinator'] != null
        ? new Coordinator.fromJson(json['coordinator'])
        : null;
    title = json['title'];
    description = json['description'];
    dueTime = json['due_Time'];
    department = json['department'].cast<int>();
    year = json['year'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.practiseSubmissions != null) {
      data['PractiseSubmissions'] =
          this.practiseSubmissions!.map((v) => v.toJson()).toList();
    }
    if (this.coordinator != null) {
      data['coordinator'] = this.coordinator!.toJson();
    }
    data['title'] = this.title;
    data['description'] = this.description;
    data['due_Time'] = this.dueTime;
    data['department'] = this.department;
    data['year'] = this.year;
    return data;
  }
}

class PractiseSubmissions {
  int? id;
  Insurance? insurance;
  dynamic studentFirstName;
  dynamic studentLastName;
  dynamic studentProfile;
  StudentDepartment? studentDepartment;
  dynamic studentEmail;
  dynamic internshipTitle;
  dynamic coordinatorName;
  String? added;
  int? status;
  dynamic uploadedForm;
  dynamic note;
  dynamic companyHistory;
  dynamic transcriptFile;
  bool? istInternational;
  int? student;
  int? practise;

  PractiseSubmissions(
      {this.id,
      this.insurance,
      this.studentFirstName,
      this.studentLastName,
      this.studentProfile,
      this.studentDepartment,
      this.studentEmail,
      this.internshipTitle,
      this.coordinatorName,
      this.added,
      this.status,
      this.uploadedForm,
      this.note,
      this.companyHistory,
      this.transcriptFile,
      this.istInternational,
      this.student,
      this.practise});

  PractiseSubmissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    insurance = json['insurance'] != null
        ? new Insurance.fromJson(json['insurance'])
        : null;
    studentFirstName = json['student_first_name'];
    studentLastName = json['student_last_name'];
    studentProfile = json['student_profile'];
    studentDepartment = json['student_department'] != null
        ? new StudentDepartment.fromJson(json['student_department'])
        : null;
    studentEmail = json['student_email'];
    internshipTitle = json['internship_title'];
    coordinatorName = json['coordinator_name'];
    added = json['added'];
    status = json['status'];
    uploadedForm = json['uploaded_form'];
    note = json['note'];
    companyHistory = json['company_history'];
    transcriptFile = json['transcript_file'];
    istInternational = json['ist_international'];
    student = json['student'];
    practise = json['practise'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.insurance != null) {
      data['insurance'] = this.insurance!.toJson();
    }
    data['student_first_name'] = this.studentFirstName;
    data['student_last_name'] = this.studentLastName;
    data['student_profile'] = this.studentProfile;
    if (this.studentDepartment != null) {
      data['student_department'] = this.studentDepartment!.toJson();
    }
    data['student_email'] = this.studentEmail;
    data['internship_title'] = this.internshipTitle;
    data['coordinator_name'] = this.coordinatorName;
    data['added'] = this.added;
    data['status'] = this.status;
    data['uploaded_form'] = this.uploadedForm;
    data['note'] = this.note;
    data['company_history'] = this.companyHistory;
    data['transcript_file'] = this.transcriptFile;
    data['ist_international'] = this.istInternational;
    data['student'] = this.student;
    data['practise'] = this.practise;
    return data;
  }
}

class Insurance {
  int? id;
  dynamic title;
  dynamic description;
  dynamic insuranceFile;
  int? practiseSubmission;

  Insurance(
      {this.id,
      this.title,
      this.description,
      this.insuranceFile,
      this.practiseSubmission});

  Insurance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    insuranceFile = json['insuranceFile'];
    practiseSubmission = json['PractiseSubmission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['insuranceFile'] = this.insuranceFile;
    data['PractiseSubmission'] = this.practiseSubmission;
    return data;
  }
}

class StudentDepartment {
  String? name;
  int? id;

  StudentDepartment({this.name, this.id});

  StudentDepartment.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class Coordinator {
  int? user;
  dynamic name;
  dynamic profilePic;
  dynamic email;
  List<Departments>? departments;
  List<Years>? years;

  Coordinator(
      {this.user,
      this.name,
      this.profilePic,
      this.email,
      this.departments,
      this.years});

  Coordinator.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    name = json['name'];
    profilePic = json['profile_pic'];
    email = json['email'];
    if (json['departments'] != null) {
      departments = <Departments>[];
      json['departments'].forEach((v) {
        departments!.add(new Departments.fromJson(v));
      });
    }
    if (json['years'] != null) {
      years = <Years>[];
      json['years'].forEach((v) {
        years!.add(new Years.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['name'] = this.name;
    data['profile_pic'] = this.profilePic;
    data['email'] = this.email;
    if (this.departments != null) {
      data['departments'] = this.departments!.map((v) => v.toJson()).toList();
    }
    if (this.years != null) {
      data['years'] = this.years!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Departments {
  String? name;
  int? id;

  Departments({this.name, this.id});

  Departments.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class Years {
  String? name;
  int? id;

  Years({this.name, this.id});

  Years.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
