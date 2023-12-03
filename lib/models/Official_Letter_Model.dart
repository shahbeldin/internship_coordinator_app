class Official_Letter_Model {
  int? id;
  dynamic internshipName;
  dynamic transcriptFile;
  dynamic companyName;
  int? status;
  dynamic officialLetter;
  int? internship;
  int? student;

  Official_Letter_Model(
      {this.id,
      this.internshipName,
      this.transcriptFile,
      this.companyName,
      this.status,
      this.officialLetter,
      this.internship,
      this.student});

  Official_Letter_Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    internshipName = json['internship_name'];
    transcriptFile = json['transcript_file'];
    companyName = json['company_name'];
    status = json['status'];
    officialLetter = json['official_letter'];
    internship = json['internship'];
    student = json['student'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['internship_name'] = this.internshipName;
    data['transcript_file'] = this.transcriptFile;
    data['company_name'] = this.companyName;
    data['status'] = this.status;
    data['official_letter'] = this.officialLetter;
    data['internship'] = this.internship;
    data['student'] = this.student;
    return data;
  }
}
