class Update_Student_Status_Model {
  dynamic uploadedForm;
  dynamic note;
  dynamic companyHistory;
  dynamic transcriptFile;
  bool? istInternational;
  int? practise;

  Update_Student_Status_Model(
      {required this.uploadedForm,
      required this.note,
      required this.companyHistory,
      required this.transcriptFile,
      required this.istInternational,
      required this.practise});

  Update_Student_Status_Model.fromJson(Map<String, dynamic> json) {
    uploadedForm = json['uploaded_form'];
    note = json['note'];
    companyHistory = json['company_history'];
    transcriptFile = json['transcript_file'];
    istInternational = json['ist_international'];
    practise = json['practise'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploaded_form'] = this.uploadedForm;
    data['note'] = this.note;
    data['company_history'] = this.companyHistory;
    data['transcript_file'] = this.transcriptFile;
    data['ist_international'] = this.istInternational;
    data['practise'] = this.practise;
    return data;
  }
}
