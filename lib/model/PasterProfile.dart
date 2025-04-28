
class UserProfile {
  final String name;
  final String? job;
  final String phone;
  final String imagePath;
  final String? dateTime;


  UserProfile( {
    required this.name,
    this.job,
    required this.phone,
    required this.imagePath,
    this.dateTime,
  });
}