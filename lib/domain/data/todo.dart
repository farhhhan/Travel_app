class Todo {
  final String name;
  final String age;
  final String gender;
  final String passportNumber;
  final String expiry;
  final String issueingCountry;
  final String panNumber;
  final String pasImage;

  Todo({
    this.name = '',
    this.age = '',
    this.gender = '',
    this.passportNumber = 'N\A',
    this.expiry = 'N\A',
    this.issueingCountry = 'N\A',
    this.panNumber = 'N\A',
    this.pasImage='N\A'
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      expiry: json['expiry'],
      issueingCountry: json['issueingCountry'],
      panNumber: json['panNumber'],
      passportNumber: json['passportNumber'],
      pasImage: json['pasImage'],
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'passportNumber': passportNumber,
      'expiry': expiry,
      'issueingCountry': issueingCountry,
      'panNumber': panNumber,
      'pasImage':pasImage
    };
  }

  @override
  String toString() {
    return '''Todo: {
      name: $name\n
      age: $age\n
      gender:$gender\n
      passportNumber:$passportNumber\n
    }''';
  }
}
