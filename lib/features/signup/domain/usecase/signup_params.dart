class SignupParams {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String location;

  const SignupParams({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.location,
  });
}
