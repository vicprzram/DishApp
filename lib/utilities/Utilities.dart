class Usuario{
  String email;
  String username;
  String password;

  Usuario(this.email, this.username, this.password);
}

class TheException implements Exception {
  String cause;
  TheException(this.cause);
}