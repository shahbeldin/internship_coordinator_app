class Announcement_Model {
  int? id;
  dynamic title;
  dynamic content;
  dynamic datePublished;
  List<int>? departments;
  List<int>? years;

  Announcement_Model(
      {this.id,
      this.title,
      this.content,
      this.datePublished,
      this.departments,
      this.years});

  Announcement_Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    datePublished = json['date_published'];
    departments = json['departments'].cast<int>();
    years = json['years'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['date_published'] = this.datePublished;
    data['departments'] = this.departments;
    data['years'] = this.years;
    return data;
  }
}
