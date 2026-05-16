class AppConstants {
  // Docker ile ayağa kaldırılan FastAPI backend
  // Android Emulator için: 10.0.2.2 (localhost yerine)
  // Fiziksel cihaz için: bilgisayarınızın yerel IP'si (örn: 192.168.1.x)
  static const String baseUrl = 'http://10.0.2.2:8000';

  // API Endpoints
  static const String classifyEndpoint = '/classify';

  // Timeout
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
