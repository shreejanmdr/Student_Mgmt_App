class LoginUserDto {
  final String success;
  final String token;

  LoginUserDto({
    required this.success,
    required this.token,
  });

  factory LoginUserDto.fromJson(Map<String, dynamic> json) {
    return LoginUserDto(
      success: json['success'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'token': token,
    };
  }
}
