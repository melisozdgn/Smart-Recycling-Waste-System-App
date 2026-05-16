import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    const Color appThemeColor = Color(0xFF2E7D32);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(
        title: const Text("Settings", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          _buildProfileHeader(appThemeColor),
          const SizedBox(height: 30),
          _buildSectionTitle("General Preferences"),
          _buildSwitchItem(
            Icons.notifications_active_rounded,
            "Reminders",
            "Daily sorting reminders",
            _notificationsEnabled,
            (val) => setState(() => _notificationsEnabled = val),
          ),
          _buildClickableItem(
            Icons.translate_rounded,
            "Language",
            trailingText: _selectedLanguage,
            onTap: () => _showLanguagePicker(context),
          ),
          const SizedBox(height: 25),
          _buildSectionTitle("Project Info"),
          _buildClickableItem(
            Icons.info_rounded,
            "About SRWS",
            subtitle: "Version 1.0.0",
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutSRWSScreen())),
          ),
          _buildClickableItem(
            Icons.auto_awesome_rounded,
            "Sustainability Goals",
            subtitle: "SDG 11, 12, 13",
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SustainabilityGoalsScreen())),
          ),
          const SizedBox(height: 25),
          _buildSectionTitle("Support"),
          _buildClickableItem(
            Icons.help_center_rounded,
            "How to Use App",
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HowToUseScreen())),
          ),
          _buildClickableItem(
            Icons.gpp_good_rounded, 
            "Privacy Policy",
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen())),
          ),
          const SizedBox(height: 40),
          Center(
            child: Column(
              children: [
                const Icon(Icons.recycling_rounded, color: Colors.grey, size: 24),
                const SizedBox(height: 8),
                Text(
                  "SRWS • Made for Future",
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(Color themeColor) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: themeColor.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundColor: themeColor.withOpacity(0.1),
            child: Icon(Icons.eco_rounded, size: 45, color: themeColor),
          ),
          const SizedBox(height: 16),
          const Text("Eco Guest", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          Text("Data stored locally", style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.green, letterSpacing: 0.5)),
    );
  }

  Widget _buildSwitchItem(IconData icon, String title, String subtitle, bool value, Function(bool) onChanged) {
    return _buildBaseContainer(
      child: SwitchListTile(
        secondary: _buildIcon(icon),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        value: value,
        activeColor: Colors.green,
        onChanged: onChanged,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }

  Widget _buildClickableItem(IconData icon, String title, {String? subtitle, String? trailingText, VoidCallback? onTap}) {
    return _buildBaseContainer(
      child: ListTile(
        leading: _buildIcon(icon),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        subtitle: subtitle != null ? Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)) : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailingText != null) Text(trailingText, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            const Icon(Icons.chevron_right_rounded, color: Colors.grey),
          ],
        ),
        onTap: onTap ?? () {},
      ),
    );
  }

  Widget _buildBaseContainer({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: child,
    );
  }

  Widget _buildIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.green.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
      child: Icon(icon, color: Colors.green.shade800, size: 22),
    );
  }

  void _showLanguagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Select Language", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _langTile("English"),
            _langTile("Turkish"),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _langTile(String lang) {
    return ListTile(
      title: Text(lang, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: _selectedLanguage == lang ? const Icon(Icons.check_circle, color: Colors.green) : null,
      onTap: () {
        setState(() => _selectedLanguage = lang);
        Navigator.pop(context);
      },
    );
  }
}

class AboutSRWSScreen extends StatelessWidget {
  const AboutSRWSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF2E7D32);
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(title: const Text("About SRWS"), backgroundColor: Colors.transparent, foregroundColor: Colors.black, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)]),
                child: const Icon(Icons.recycling_rounded, size: 80, color: primaryGreen),
              ),
            ),
            const SizedBox(height: 24),
            const Text("Smart Recycling Waste System", textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF1B5E20))),
            const SizedBox(height: 12),
            const Text("Version 1.0.0", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            _buildInfoCard("Mission", "To reduce environmental impact by empowering individuals with AI-driven waste sorting technology."),
            _buildInfoCard("Technology", "Powered by Flutter and Advanced Computer Vision models to identify recyclables in real-time."),
            _buildInfoCard("Our Vision", "Creating a world where zero waste is not just a goal, but a daily habit."),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade100)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
          const SizedBox(height: 8),
          Text(content, style: TextStyle(fontSize: 14, color: Colors.grey.shade700, height: 1.5)),
        ],
      ),
    );
  }
}

class SustainabilityGoalsScreen extends StatelessWidget {
  const SustainabilityGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(title: const Text("Sustainability Goals"), backgroundColor: Colors.transparent, foregroundColor: Colors.black, elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text("United Nations SDGs", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green, letterSpacing: 1.2)),
          const SizedBox(height: 8),
          const Text("Our Commitment", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
          const SizedBox(height: 24),
          _buildGoalCard("11", "Sustainable Cities", "Making cities and human settlements inclusive, safe, resilient and sustainable.", const Color(0xFFF99D26)),
          _buildGoalCard("12", "Responsible Consumption", "Ensuring sustainable consumption and production patterns.", const Color(0xFFCF8D2A)),
          _buildGoalCard("13", "Climate Action", "Taking urgent action to combat climate change and its impacts.", const Color(0xFF48773E)),
        ],
      ),
    );
  }

  Widget _buildGoalCard(String number, String title, String desc, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6))]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(number, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white24)),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),
                Text(desc, style: const TextStyle(fontSize: 13, color: Colors.white, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HowToUseScreen extends StatelessWidget {
  const HowToUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(title: const Text("How to Use"), backgroundColor: Colors.transparent, foregroundColor: Colors.black, elevation: 0),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildStep(1, "Scan Your Waste", "Tap the camera icon and point it at the object you want to sort.", Icons.camera_alt_rounded),
                _buildStep(2, "Wait for Analysis", "Our AI will instantly recognize the material type (Plastic, Paper, Metal, etc.).", Icons.auto_fix_high_rounded),
                _buildStep(3, "Correct Bin", "Follow the instructions to place the item in the most suitable recycling bin.", Icons.delete_outline_rounded),
                _buildStep(4, "Track History", "Check your profile to see your total environmental impact contribution.", Icons.history_rounded),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              child: const Text("Got it!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(int step, String title, String desc, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
            child: Center(child: Text(step.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 20, color: Colors.green),
                    const SizedBox(width: 8),
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(desc, style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPolicySection(
              "Introduction",
              "Welcome to SRWS. We are committed to protecting your personal information and your right to privacy. This privacy policy applies to all information collected through our application.",
            ),
            const SizedBox(height: 24),
            _buildPolicySection(
              "Information We Collect",
              "Since SRWS operates locally on your device to classify waste using AI, we do not transmit your camera feed or images to remote servers. All image processing happens directly on your device, ensuring maximum privacy.",
            ),
            const SizedBox(height: 24),
            _buildPolicySection(
              "How We Use Your Data",
              "The localized data is strictly used to facilitate the core features of the App: identifying and categorizing recyclable materials. We do not use your data for targeted advertising or third-party profiling.",
            ),
            const SizedBox(height: 24),
            _buildPolicySection(
              "Data Security",
              "We implement industry-standard technical and organizational security measures to protect any localized data. Since the application avoids unnecessary cloud uploads, your risk of data breaches is significantly minimized.",
            ),
            const SizedBox(height: 24),
            _buildPolicySection(
              "Your Privacy Rights",
              "You have the right to delete all your application data directly from your device's system settings. Doing so will permanently erase your scanning history and customized preferences.",
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                "Last Updated: April 2026",
                style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicySection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.green),
        ),
        const SizedBox(height: 10),
        Text(
          content,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade700, height: 1.6, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}