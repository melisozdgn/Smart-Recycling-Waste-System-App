import 'package:flutter/material.dart';
import 'package:srws_app/core/layout/main_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
    _navigateToHome();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const MainLayout(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1B5E20);
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFA5D6A7),
              Color(0xFFE8F5E9),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -80,
              right: -80,
              child: Icon(Icons.recycling_rounded, size: 350, color: primaryColor.withOpacity(0.03)),
            ),
            Positioned(
              bottom: -100,
              left: -80,
              child: Icon(Icons.eco_rounded, size: 400, color: primaryColor.withOpacity(0.03)),
            ),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x1A000000),
                            blurRadius: 30,
                            offset: Offset(0, 15),
                          )
                        ],
                      ),
                      child: const Icon(
                        Icons.recycling_rounded,
                        size: 90,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'SRWS',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: primaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Smart Recycling Waste System',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 80),
                    const SizedBox(
                      width: 36,
                      height: 36,
                      child: CircularProgressIndicator(
                        color: primaryColor,
                        strokeWidth: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}