class User {
  String username;
  String password;

  User(this.username, this.password);

  // Método para convertir una cadena en una instancia de User
  factory User.fromString(String userString) {
    List<String> parts = userString.split(',');
    return User(parts[0], parts[1]);
  }

  // Método para convertir la instancia de User en una cadena
  String toString() {
    return '$username,$password';
  }
}