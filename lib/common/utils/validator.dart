class Validator {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Informe o e-mail.';
    if (!value.contains('@')) return 'E-mail inválido.';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Informe a senha.';
    if (value.length < 6) return 'Mínimo de 6 caracteres.';
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return 'Confirme a senha.';
    if (value != original) return 'As senhas não coincidem.';
    return null;
  }
}
