import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Secure storage wrapper for sensitive data
/// Provides encryption-ready interface for storing credentials and tokens
/// 
/// Note: For production, replace SharedPreferences with flutter_secure_storage
/// which uses Keychain on iOS and EncryptedSharedPreferences on Android
abstract class SecureStorage {
  /// Stores a secure string value
  Future<void> write({required String key, required String value});

  /// Reads a secure string value
  Future<String?> read({required String key});

  /// Deletes a secure value
  Future<void> delete({required String key});

  /// Deletes all secure values
  Future<void> deleteAll();

  /// Checks if a key exists
  Future<bool> containsKey({required String key});
}

/// Implementation using SharedPreferences (for development)
/// Replace with FlutterSecureStorage for production
class SecureStorageImpl implements SecureStorage {
  SecureStorageImpl._();

  static SecureStorageImpl? _instance;
  static SecureStorageImpl get instance => _instance ??= SecureStorageImpl._();

  SharedPreferences? _prefs;
  static const String _prefix = 'secure_';

  Future<SharedPreferences> get _preferences async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  @override
  Future<void> write({required String key, required String value}) async {
    final prefs = await _preferences;
    // In production, encrypt the value before storing
    final encodedValue = _encode(value);
    await prefs.setString('$_prefix$key', encodedValue);
  }

  @override
  Future<String?> read({required String key}) async {
    final prefs = await _preferences;
    final encodedValue = prefs.getString('$_prefix$key');
    if (encodedValue == null) return null;
    // In production, decrypt the value after reading
    return _decode(encodedValue);
  }

  @override
  Future<void> delete({required String key}) async {
    final prefs = await _preferences;
    await prefs.remove('$_prefix$key');
  }

  @override
  Future<void> deleteAll() async {
    final prefs = await _preferences;
    final keys = prefs.getKeys().where((k) => k.startsWith(_prefix));
    for (final key in keys) {
      await prefs.remove(key);
    }
  }

  @override
  Future<bool> containsKey({required String key}) async {
    final prefs = await _preferences;
    return prefs.containsKey('$_prefix$key');
  }

  // Simple encoding (replace with proper encryption in production)
  String _encode(String value) {
    if (kDebugMode) {
      // In debug mode, just base64 encode for visibility
      return value;
    }
    // In release mode, this should use proper encryption
    return value;
  }

  String _decode(String value) {
    if (kDebugMode) {
      return value;
    }
    return value;
  }
}

/// Storage keys for the application
class StorageKeys {
  StorageKeys._();

  // Authentication
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String sessionId = 'session_id';

  // User preferences (non-sensitive)
  static const String themeMode = 'theme_mode';
  static const String locale = 'locale';
  static const String onboardingComplete = 'onboarding_complete';
  static const String notificationsEnabled = 'notifications_enabled';

  // Biometric
  static const String biometricEnabled = 'biometric_enabled';
  static const String biometricToken = 'biometric_token';
}

/// Session manager for handling authentication state
class SessionManager {
  SessionManager._();

  static SessionManager? _instance;
  static SessionManager get instance => _instance ??= SessionManager._();

  final SecureStorage _storage = SecureStorageImpl.instance;

  /// Checks if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await _storage.read(key: StorageKeys.accessToken);
    return token != null && token.isNotEmpty;
  }

  /// Saves authentication tokens
  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _storage.write(key: StorageKeys.accessToken, value: accessToken);
    if (refreshToken != null) {
      await _storage.write(key: StorageKeys.refreshToken, value: refreshToken);
    }
  }

  /// Gets the current access token
  Future<String?> getAccessToken() async {
    return _storage.read(key: StorageKeys.accessToken);
  }

  /// Gets the current refresh token
  Future<String?> getRefreshToken() async {
    return _storage.read(key: StorageKeys.refreshToken);
  }

  /// Clears all session data (logout)
  Future<void> clearSession() async {
    await _storage.delete(key: StorageKeys.accessToken);
    await _storage.delete(key: StorageKeys.refreshToken);
    await _storage.delete(key: StorageKeys.userId);
    await _storage.delete(key: StorageKeys.sessionId);
  }

  /// Saves user ID
  Future<void> saveUserId(String userId) async {
    await _storage.write(key: StorageKeys.userId, value: userId);
  }

  /// Gets the current user ID
  Future<String?> getUserId() async {
    return _storage.read(key: StorageKeys.userId);
  }
}
