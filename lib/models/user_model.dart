
class User {
  final int id;
  final String name;
  final int age;
  final String username;
  final String email;
  Map address;
  final String phone;
  final String website;
  final String occupation;
  List hobbies;
 
  User({
    required this.id,
    required this.name,
    required this.age,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.occupation,
    required this.hobbies,
  });
}