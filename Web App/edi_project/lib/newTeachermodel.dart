class TeacherModel{
  String grno;
  String name;
  String email;
  String phone;
  String imgUrl;

  TeacherModel({this.grno, this.name, this.email, this.phone, this.imgUrl});

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'GRno' : grno,
      'Name' : name,
      'Email' : email,
      'Phone' : phone,
      'Photo' : imgUrl
    };

    return map;
  }
} 