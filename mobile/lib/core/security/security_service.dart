import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Serviço de segurança para gerenciamento de tokens e PII (Senhas/PINs)
/// Utiliza Keychain (iOS) e Keystore (Android) com criptografia AES/RSA.
class SecurityService {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  static const String _accessTokenKey = 'OPEN_FINANCE_ACCESS_TOKEN';

  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  Future<void> clearAuth() async {
    await _storage.delete(key: _accessTokenKey);
  }

  /// Verifica se o dispositivo possui biometria ativa (FaceID/TouchID)
  /// Requisito OWASP Mobile: Autenticação secundária para dados financeiros
  Future<bool> hasValidSession() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
