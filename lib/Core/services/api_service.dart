
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiService {
  
  static const String _dotnetBaseUrl  = 'http://10.0.2.2:5000';
  static const String _fastApiBaseUrl = 'http://10.0.2.2:8000';

  //  FastAPI: görüntüyü sınıflandır 
  static Future<Map<String, dynamic>> classifyWaste(File imageFile) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$_fastApiBaseUrl/api/ai/classify'),
      );
      final ext = imageFile.path.split('.').last.toLowerCase();
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
        contentType: MediaType.parse(ext == 'png' ? 'image/png' : 'image/jpeg'),
      ));
      final streamed = await request.send()
          .timeout(const Duration(seconds: 30));
      final response = await http.Response.fromStream(streamed);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) return {'success': true, 'data': data};
      return {'success': false, 'message': data['detail'] ?? 'Failed'};
    } on SocketException {
      return {'success': false, 'message': 'No internet connection'};
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  //  .NET API: taramayı arka planda kaydet 
  static Future<void> saveScanHistory({
    required String  categoryName,
    required double  confidenceScore,
    String?          aiDescription,
    String?          deviceId,
  }) async {
    try {
      await http
          .post(
            Uri.parse('$_dotnetBaseUrl/api/scan/history'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'categoryName':    categoryName,
              'confidenceScore': confidenceScore,
              'aiDescription':   aiDescription,
              'deviceId':        deviceId,
            }),
          )
          .timeout(const Duration(seconds: 10));
    } catch (_) {
      
    }
  }
}
