class User {
  final String id;
  final String name;
  final String username;
  final String email;
  final Map<String, dynamic> address;
  final String phone;
  final String website;
  final Map<String, dynamic> company;

  User(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.address,
      required this.phone,
      required this.website,
      required this.company,
      });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'].toString(),
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address: json['address'],
      phone: json['phone'],
      website: json['website'],
      company: json['company'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'username' : username,
    'email' : email,
    'address' : address,
    'phone' : phone,
    'website' : website,
    'company' : company,
  };
}
