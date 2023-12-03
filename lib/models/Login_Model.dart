class Login_Model {
  String? authToken;
  int? userId;
  String? type;

  Login_Model({this.authToken, this.userId, this.type});

  Login_Model.fromJson(Map<String, dynamic> json) {
    authToken = json['auth_token'];
    userId = json['user_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auth_token'] = this.authToken;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    return data;
  }
}
