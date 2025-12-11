import 'dart:convert';
import 'dart:math';

/// API Security utilities for secure network communication
/// Implements OWASP security best practices
class ApiSecurity {
  ApiSecurity._();

  /// Generates a secure random string for CSRF tokens, nonces, etc.
  static String generateSecureToken({int length = 32}) {
    final random = Random.secure();
    final values = List<int>.generate(length, (_) => random.nextInt(256));
    return base64Url.encode(values).substring(0, length);
  }

  /// Generates a UUID v4
  static String generateUuid() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    
    // Set version (4) and variant bits
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
        '${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
  }

  /// Sanitizes user input to prevent injection attacks
  static String sanitizeInput(String input) {
    return input
        .replaceAll(RegExp(r'<[^>]*>'), '') // Remove HTML tags
        .replaceAll(RegExp(r'[<>]'), '') // Remove angle brackets
        .replaceAll('"', '') // Remove double quotes
        .replaceAll("'", '') // Remove single quotes
        .trim();
  }

  /// Sanitizes URL parameters
  static String sanitizeUrlParam(String param) {
    return Uri.encodeComponent(param);
  }

  /// Validates and sanitizes a URL
  static String? sanitizeUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;
    
    // Only allow http and https schemes
    if (!['http', 'https'].contains(uri.scheme.toLowerCase())) {
      return null;
    }
    
    return uri.toString();
  }

  /// Creates secure headers for API requests
  static Map<String, String> createSecureHeaders({
    String? accessToken,
    String? csrfToken,
    String? requestId,
  }) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-Request-ID': requestId ?? generateUuid(),
      'X-Client-Version': '1.0.0',
    };

    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    if (csrfToken != null) {
      headers['X-CSRF-Token'] = csrfToken;
    }

    return headers;
  }

  /// Masks sensitive data for logging
  static String maskSensitiveData(String data, {int visibleChars = 4}) {
    if (data.length <= visibleChars * 2) {
      return '*' * data.length;
    }
    final start = data.substring(0, visibleChars);
    final end = data.substring(data.length - visibleChars);
    final masked = '*' * (data.length - visibleChars * 2);
    return '$start$masked$end';
  }

  /// Validates JWT token format (does not verify signature)
  static bool isValidJwtFormat(String token) {
    final parts = token.split('.');
    if (parts.length != 3) return false;
    
    try {
      for (final part in parts.take(2)) {
        base64Url.decode(base64Url.normalize(part));
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Extracts payload from JWT (does not verify signature)
  static Map<String, dynamic>? decodeJwtPayload(String token) {
    if (!isValidJwtFormat(token)) return null;
    
    try {
      final parts = token.split('.');
      final payload = base64Url.decode(base64Url.normalize(parts[1]));
      return jsonDecode(utf8.decode(payload)) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  /// Checks if JWT token is expired
  static bool isJwtExpired(String token) {
    final payload = decodeJwtPayload(token);
    if (payload == null) return true;
    
    final exp = payload['exp'] as int?;
    if (exp == null) return true;
    
    final expiry = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    return DateTime.now().isAfter(expiry);
  }

  /// Rate limiting helper - tracks request timestamps
  static final Map<String, List<DateTime>> _requestTimestamps = {};

  /// Checks if request should be rate limited
  static bool shouldRateLimit(
    String endpoint, {
    int maxRequests = 10,
    Duration window = const Duration(minutes: 1),
  }) {
    final now = DateTime.now();
    final timestamps = _requestTimestamps[endpoint] ?? [];
    
    // Remove old timestamps
    timestamps.removeWhere((t) => now.difference(t) > window);
    
    if (timestamps.length >= maxRequests) {
      return true;
    }
    
    timestamps.add(now);
    _requestTimestamps[endpoint] = timestamps;
    return false;
  }

  /// Clears rate limit tracking for an endpoint
  static void clearRateLimit(String endpoint) {
    _requestTimestamps.remove(endpoint);
  }
}

/// Security configuration for API calls
class ApiSecurityConfig {
  const ApiSecurityConfig({
    this.enableCsrf = true,
    this.enableRateLimiting = true,
    this.maxRequestsPerMinute = 60,
    this.requestTimeout = const Duration(seconds: 30),
    this.enableCertificatePinning = false,
    this.pinnedCertificates = const [],
  });

  final bool enableCsrf;
  final bool enableRateLimiting;
  final int maxRequestsPerMinute;
  final Duration requestTimeout;
  final bool enableCertificatePinning;
  final List<String> pinnedCertificates;

  /// Default configuration for development
  static const ApiSecurityConfig development = ApiSecurityConfig(
    enableCsrf: false,
    enableRateLimiting: false,
    enableCertificatePinning: false,
  );

  /// Default configuration for production
  static const ApiSecurityConfig production = ApiSecurityConfig(
    enableCsrf: true,
    enableRateLimiting: true,
    maxRequestsPerMinute: 60,
    enableCertificatePinning: true,
  );
}

/// Sensitive data types for proper handling
enum SensitiveDataType {
  password,
  token,
  creditCard,
  ssn,
  afm,
  email,
  phone,
}

/// Extension for handling sensitive data
extension SensitiveDataHandling on String {
  /// Masks the string based on data type
  String mask(SensitiveDataType type) {
    switch (type) {
      case SensitiveDataType.password:
        return '********';
      case SensitiveDataType.token:
        return ApiSecurity.maskSensitiveData(this, visibleChars: 4);
      case SensitiveDataType.creditCard:
        if (length >= 4) {
          return '**** **** **** ${substring(length - 4)}';
        }
        return '****';
      case SensitiveDataType.ssn:
      case SensitiveDataType.afm:
        if (length >= 4) {
          return '*****${substring(length - 4)}';
        }
        return '*****';
      case SensitiveDataType.email:
        final parts = split('@');
        if (parts.length == 2) {
          final name = parts[0];
          final domain = parts[1];
          if (name.length > 2) {
            return '${name[0]}***${name[name.length - 1]}@$domain';
          }
        }
        return '***@***';
      case SensitiveDataType.phone:
        if (length >= 4) {
          return '******${substring(length - 4)}';
        }
        return '******';
    }
  }
}
