import 'package:flutter/material.dart';
import '../../../auth/data/repositories/auth_repository.dart';

class AuthController extends ChangeNotifier {
  final AuthRepository _repo = AuthRepository();

  bool loading = false;
  String? error;

  Future<bool> login(String email, String password) async {
    try {
      loading = true;
      error = null;
      notifyListeners();

      await _repo.login(email, password);
      return true;
    } catch (e) {
      error = 'Falha ao fazer login.';
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> register(String email, String password) async {
    try {
      loading = true;
      error = null;
      notifyListeners();

      await _repo.register(email, password);
      return true;
    } catch (e) {
      error = 'Falha ao criar conta.';
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
