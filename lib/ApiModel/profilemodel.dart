class UserProfile {
  final int? id;
  final String? username;
  final String? mail;
  final String? mobile;
  final String? address;

  UserProfile({
    required this.id,
    required this.username,
    required this.mail,
    required this.mobile,
    required this.address,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      username: json['username'],
      mail: json['mail'],
      mobile: json['mobile'],
      address: json['address'],
    );
  }
}
