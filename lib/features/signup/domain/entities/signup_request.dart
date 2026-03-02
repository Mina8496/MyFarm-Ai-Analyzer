class SignupRequest {
  final String name;
  final String email;
  final String password;
  final String phone;

  const SignupRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });
}
