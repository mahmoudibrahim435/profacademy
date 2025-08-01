

class ProfileModel {
  final String name;
  final String expiryDate;
  final String teacherName;
  final String grade;

  ProfileModel({required this.name, required this.expiryDate, required this.teacherName, required this.grade});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      expiryDate: json['expiry_date'],
      teacherName: json['teacher_name'],
      grade: json['grade'],
    );
  }
}