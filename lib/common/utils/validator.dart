class Validator {
  // ---------- AUTENTICAÇÃO ----------
  static String? email(String? v) {
    if (v == null || v.isEmpty) return 'Informe o e-mail.';
    if (!v.contains('@')) return 'E-mail inválido.';
    return null;
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Informe a senha.';
    if (v.length < 6) return 'Mínimo de 6 caracteres.';
    return null;
  }

  static String? confirmPassword(String? v, String original) {
    if (v == null || v.isEmpty) return 'Confirme a senha.';
    if (v != original) return 'As senhas não coincidem.';
    return null;
  }

  // ---------- VEÍCULOS ----------
  static String? requiredText(String? v, String label) {
    if (v == null || v.trim().isEmpty) return 'Informe $label.';
    return null;
  }

  static String? placa(String? v) {
    if (v == null || v.isEmpty) return 'Informe a placa.';
    if (!RegExp(r'^[A-Z]{3}[0-9][A-Z0-9][0-9]{2}$').hasMatch(v.toUpperCase())) {
      return 'Placa inválida.';
    }
    return null;
  }

  static String? ano(String? v) {
    if (v == null || v.isEmpty) return 'Informe o ano.';
    final n = int.tryParse(v);
    if (n == null || n < 1900 || n > DateTime.now().year + 1) {
      return 'Ano inválido.';
    }
    return null;
  }
}
