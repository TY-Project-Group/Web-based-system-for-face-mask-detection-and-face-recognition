class StudentModel{
  String grno;
  String name;
  String email;
  String phone;
  String year;
  String imgUrl;

  StudentModel({this.grno, this.name, this.email, this.phone, this.year, this.imgUrl});

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'GRno' : grno,
      'Name' : name,
      'Email' : email,
      'Phone' : phone,
      'Year' : year,
      'Photo' : imgUrl
    };

    return map;
  }
} 