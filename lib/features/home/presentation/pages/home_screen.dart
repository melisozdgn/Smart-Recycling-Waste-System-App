import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:srws_app/core/dependency_injection/injection_container.dart';
import 'package:srws_app/core/l10n/app_localizations.dart'; 
import 'package:srws_app/features/scanner/presentation/pages/camera_screen .dart';
import 'package:srws_app/features/scanner/presentation/cubit/scanner_cubit.dart';
import 'package:srws_app/features/scanner/presentation/cubit/scanner_state.dart';
import 'package:srws_app/features/scanner/presentation/pages/scan_result_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      debugPrint('Selected image path: ${image.path}');
      final cubit = sl<ScannerCubit>();
      await cubit.analyzeFromFile(File(image.path));
      if (!mounted) return;
      final state = cubit.state;
      if (state is ScannerAnalysisSuccess) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => ScanResultSheet(result: state.result),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF2E7D32);
    const Color accentGreen = Color(0xFF81C784);
    const Color textDark = Color(0xFF1B5E20);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE8F5E9),
            Color(0xFFC8E6C9),
            Color(0xFFFFFFFF),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 120,
          title: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryGreen.withAlpha(25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  l10n.modernWasteSorting, 
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w700,
                    color: primaryGreen.withAlpha(178),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.sortingWastes, 
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 32,
                  color: textDark,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            Positioned(
              top: -50,
              right: -50,
              child: _buildBackgroundBlob(300, accentGreen.withAlpha(51)),
            ),
            Positioned(
              bottom: 150,
              left: -80,
              child: _buildBackgroundBlob(400, primaryGreen.withAlpha(25)),
            ),
            Positioned(
              bottom: -60,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: 0.04,
                child: Transform.rotate(
                  angle: -0.1,
                  child: Icon(
                    Icons.recycling_rounded,
                    size: MediaQuery.of(context).size.width * 0.95,
                    color: primaryGreen,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildActionCard(
                            context: context,
                            icon: Icons.center_focus_strong_rounded,
                            label: l10n.takePhoto, 
                            themeColor: primaryGreen,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => sl<ScannerCubit>(),
                                    child: const CameraScreen(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildActionCard(
                            context: context,
                            icon: Icons.add_photo_alternate_rounded,
                            label: l10n.selectImage,
                            themeColor: primaryGreen,
                            onTap: _pickImageFromGallery,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundBlob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withAlpha(0)],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color themeColor,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(230),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 30,
            spreadRadius: 2,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: themeColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 36, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF2C3E50),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}