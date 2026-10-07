enum UserRole { customer, admin }

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final String passwordHash;
  final UserRole role;
  final String address;
  final String flatApartment;
  final String landmark;
  final String city;
  final String state;
  final String pincode;
  final String avatarUrl;
  final bool isVerified;
  final String securityScore;
  final String createdAt;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    this.passwordHash = '',
    this.role = UserRole.customer,
    this.address = '',
    this.flatApartment = '',
    this.landmark = '',
    this.city = 'Changa',
    this.state = 'Gujarat',
    this.pincode = '388421',
    this.avatarUrl = '',
    this.isVerified = true,
    this.securityScore = 'Excellent',
    String? createdAt,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String();

  String get fullName => '$firstName $lastName'.trim();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      mobile: json['mobile'] as String? ?? '',
      passwordHash: json['password_hash'] as String? ?? '',
      role: (json['role'] == 'admin') ? UserRole.admin : UserRole.customer,
      address: json['address'] as String? ?? '',
      flatApartment: json['flat_apartment'] as String? ?? '',
      landmark: json['landmark'] as String? ?? '',
      city: json['city'] as String? ?? 'Changa',
      state: json['state'] as String? ?? 'Gujarat',
      pincode: json['pincode'] as String? ?? '388421',
      avatarUrl: json['avatar_url'] as String? ?? '',
      isVerified: json['is_verified'] as bool? ?? true,
      securityScore: json['security_score'] as String? ?? 'Excellent',
      createdAt: json['created_at'] as String? ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'mobile': mobile,
      'password_hash': passwordHash,
      'role': role == UserRole.admin ? 'admin' : 'customer',
      'address': address,
      'flat_apartment': flatApartment,
      'landmark': landmark,
      'city': city,
      'state': state,
      'pincode': pincode,
      'avatar_url': avatarUrl,
      'is_verified': isVerified,
      'security_score': securityScore,
      'created_at': createdAt,
    };
  }

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? mobile,
    String? passwordHash,
    UserRole? role,
    String? address,
    String? flatApartment,
    String? landmark,
    String? city,
    String? state,
    String? pincode,
    String? avatarUrl,
    bool? isVerified,
    String? securityScore,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      passwordHash: passwordHash ?? this.passwordHash,
      role: role ?? this.role,
      address: address ?? this.address,
      flatApartment: flatApartment ?? this.flatApartment,
      landmark: landmark ?? this.landmark,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isVerified: isVerified ?? this.isVerified,
      securityScore: securityScore ?? this.securityScore,
      createdAt: createdAt,
    );
  }
}
