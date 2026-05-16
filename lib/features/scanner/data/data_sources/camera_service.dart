import 'package:camera/camera.dart';

class CameraService {
  CameraController? controller;

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) throw Exception('Kamera bulunamadı.');

    controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await controller!.initialize();
  }

  Future<XFile?> takePicture() async {
    if (controller == null || !controller!.value.isInitialized) {
      throw Exception('Kamera hazır değil.');
    }
    return await controller!.takePicture();
  }

  void dispose() {
    controller?.dispose();
  }
}
