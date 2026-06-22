import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_preview/device_preview.dart'; 
import 'package:srws_app/core/dependency_injection/injection_container.dart';
import 'package:srws_app/core/l10n/app_localizations.dart'; 
import 'package:srws_app/features/scanner/presentation/pages/camera_screen .dart';
import 'package:srws_app/features/scanner/presentation/cubit/scanner_cubit.dart';
import 'package:srws_app/features/scanner/presentation/cubit/scanner_state.dart';
import 'package:srws_app/features/scanner/presentation/pages/scan_result_sheet.dart';
import 'package:srws_app/main.dart'; 

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    const Color appThemeColor = Color(0xFF2E7D32);
    final l10n = AppLocalizations.of(context)!; 

    final String currentLangLabel = Localizations.localeOf(context).languageCode == 'tr' ? 'Turkish' : 'English';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(
        title: Text(l10n.settings, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 24)), 
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          _buildProfileHeader(appThemeColor, l10n),
          const SizedBox(height: 30),
          _buildSectionTitle(l10n.generalPreferences),
          _buildSwitchItem(
            Icons.notifications_active_rounded,
            l10n.reminders, 
            l10n.dailySortingReminders, 
            _notificationsEnabled,
            (val) => setState(() => _notificationsEnabled = val),
          ),
          _buildClickableItem(
            Icons.translate_rounded,
            l10n.language, 
            trailingText: currentLangLabel,
            onTap: () => _showLanguagePicker(context, l10n),
          ),
          const SizedBox(height: 25),
          _buildSectionTitle(l10n.projectInfo), 
          _buildClickableItem(
            Icons.info_rounded,
            l10n.aboutSrws, 
            subtitle: l10n.version, 
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutSRWSScreen())),
          ),
          _buildClickableItem(
            Icons.auto_awesome_rounded,
            l10n.sustainabilityGoals, 
            subtitle: "SDG 11, 12, 13",
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SustainabilityGoalsScreen())),
          ),
          const SizedBox(height: 25),
          _buildSectionTitle(l10n.support),
          _buildClickableItem(
            Icons.help_center_rounded,
            l10n.howToUseApp, 
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HowToUseScreen())),
          ),
          _buildClickableItem(
            Icons.gpp_good_rounded, 
            l10n.privacyPolicy, 
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

  Widget _buildProfileHeader(Color themeColor, AppLocalizations l10n) {
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
          Text(l10n.ecoGuest, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)), 
          const SizedBox(height: 4),
          Text(l10n.dataStoredLocally, style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontWeight: FontWeight.w500)), 
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

  void _showLanguagePicker(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (bottomSheetContext) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.selectLanguage, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), 
              const SizedBox(height: 20),
              ListTile(
                title: const Text(
                  "English",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: Localizations.localeOf(context).languageCode == 'en'
                    ? const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                )
                 : null,
                onTap: () {
                  changeLocale(const Locale('en'));
                  Navigator.pop(bottomSheetContext);
                },
              ),

              ListTile(
                title: const Text(
                  "Turkish",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                 trailing: Localizations.localeOf(context).languageCode == 'tr'
                    ? const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                    : null,
                  onTap: () {
                    changeLocale(const Locale('tr'));
                    Navigator.pop(bottomSheetContext);
                  },
                ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
} // 🎯 SETTINGS SINIFI BURADA KUSURSUZ KAPANDI!

// --- ALT SAYFALAR (En dışta, bağımsız sınıflar olarak yer alıyorlar) ---

class AboutSRWSScreen extends StatelessWidget {
  const AboutSRWSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF2E7D32);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(title: Text(l10n.aboutSrws), backgroundColor: Colors.transparent, foregroundColor: Colors.black, elevation: 0),
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
            Text(l10n.version, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            _buildInfoCard(
              Localizations.localeOf(context).languageCode == 'tr' ? "Misyon" : "Mission", 
              Localizations.localeOf(context).languageCode == 'tr' 
                ? "Yapay zeka destekli atık ayrıştırma teknolojisiyle bireyleri güçlendirerek çevre üzerindeki etkiyi azaltmak." 
                : "To reduce environmental impact by empowering individuals with AI-driven waste sorting technology."
            ),
            _buildInfoCard(
              Localizations.localeOf(context).languageCode == 'tr' ? "Teknoloji" : "Technology", 
              Localizations.localeOf(context).languageCode == 'tr' 
                ? "Geri dönüştürülebilir malzemeleri gerçek zamanlı olarak tanımlamak için Flutter ve Gelişmiş Bilgisayarlı Görü modelleri ile güçlendirilmiştir." 
                : "Powered by Flutter and Advanced Computer Vision models to identify recyclables in real-time."
            ),
            _buildInfoCard(
              Localizations.localeOf(context).languageCode == 'tr' ? "Vizyonumuz" : "Our Vision", 
              Localizations.localeOf(context).languageCode == 'tr' 
                ? "Sıfır atığın sadece bir hedef değil, günlük bir alışkanlık olduğu bir dünya yaratmak." 
                : "Creating a world where zero waste is not just a goal, but a daily habit."
            ),
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
    final isTr = Localizations.localeOf(context).languageCode == 'tr';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(
        title: Text(isTr ? "Sürdürülebilirlik Hedefleri" : "Sustainability Goals"), 
        backgroundColor: Colors.transparent, 
        foregroundColor: Colors.black, 
        elevation: 0
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(isTr ? "Birleşmiş Milletler Sürdürülebilir Kalkınma Amaçları" : "United Nations SDGs", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green, letterSpacing: 1.2)),
          const SizedBox(height: 8),
          Text(isTr ? "Taahhüdümüz" : "Our Commitment", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
          const SizedBox(height: 24),
          _buildGoalCard(
            "11", 
            isTr ? "Sürdürülebilir Şehirler" : "Sustainable Cities", 
            isTr ? "Şehirleri ve insan yerleşimlerini kapsayıcı, güvenli, dayanıklı ve sürdürülebilir kılmak." : "Making cities and human settlements inclusive, safe, resilient and sustainable.", 
            const Color(0xFFF99D26)
          ),
          _buildGoalCard(
            "12", 
            isTr ? "Sorumlu Tüketim" : "Responsible Consumption", 
            isTr ? "Sürdürülebilir tüketim ve üretim kalıplarını sağlamak." : "Ensuring sustainable consumption and production patterns.", 
            const Color(0xFFCF8D2A)
          ),
          _buildGoalCard(
            "13", 
            isTr ? "İklim Eylemi" : "Climate Action", 
            isTr ? "İklim değişikliği ve etkileriyle mücadele için acil eyleme geçmek." : "Taking urgent action to combat change and its impacts.", 
            const Color(0xFF48773E)
          ),
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
    final isTr = Localizations.localeOf(context).languageCode == 'tr';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(
        title: Text(isTr ? "Nasıl Kullanılır" : "How to Use"), 
        backgroundColor: Colors.transparent, 
        foregroundColor: Colors.black, 
        elevation: 0
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildStep(
                  1, 
                  isTr ? "Atığınızı Taratın" : "Scan Your Waste", 
                  isTr ? "Kamera simgesine dokunun ve ayrıştırmak istediğiniz nesneye doğrultun." : "Tap the camera icon and point it at the object you want to sort.", 
                  Icons.camera_alt_rounded
                ),
                _buildStep(
                  2, 
                  isTr ? "Analiz Bekleyin" : "Wait for Analysis", 
                  isTr ? "Yapay zekamız malzeme türünü (Plastik, Kağıt, Metal vb.) anında tanıyacaktır." : "Our AI will instantly recognize the material type (Plastic, Paper, Metal, etc.).", 
                  Icons.auto_fix_high_rounded
                ),
                _buildStep(
                  3, 
                  isTr ? "Doğru Kutu" : "Correct Bin", 
                  isTr ? "Öğeyi en uygun geri dönüşüm kutusuna yerleştirmek için talimatları izleyin." : "Follow the instructions to place the item in the most suitable recycling bin.", 
                  Icons.delete_outline_rounded
                ),
                _buildStep(
                  4, 
                  isTr ? "Geçmişi Takip Et" : "Track History", 
                  isTr ? "Toplam çevresel etki katkınızı görmek için geçmişinizi kontrol edin." : "Check your profile to see your total environmental impact contribution.", 
                  Icons.history_rounded
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              child: Text(isTr ? "Anladım!" : "Got it!", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
    final l10n = AppLocalizations.of(context)!;
    final isTr = Localizations.localeOf(context).languageCode == 'tr';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(
        title: Text(l10n.privacyPolicy),
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
              isTr ? "Giriş" : "Introduction",
              isTr 
                ? "SRWS'ye hoş geldiniz. Kişisel bilgilerinizi ve gizlilik hakkınızı korumaya kararlıyız. Bu gizlilik politikası, uygulamamız aracılığıyla toplanan tüm bilgiler için geçerlidir."
                : "Welcome to SRWS. We are committed to protecting your personal information and your right to privacy. This privacy policy applies to all information collected through our application.",
            ),
            const SizedBox(height: 24),
            _buildPolicySection(
              isTr ? "Topladığımız Bilgiler" : "Information We Collect",
              isTr
                ? "SRWS, yapay zeka kullanarak atıkları sınıflandırmak için doğrudan cihazınızda yerel olarak çalıştığından, kamera akışınızı veya görsellerinizi uzak sunuculara iletmeyiz. Tüm görüntü işleme doğrudan cihazınızda gerçekleşir und maksimum gizlilik sağlanır."
                : "Since SRWS operates locally on your device to classify waste using AI, we do not transmit your camera feed or images to remote servers. All image processing happens directly on your device, ensuring maximum privacy.",
            ),
            const SizedBox(height: 24),
            _buildPolicySection(
              isTr ? "Verilerinizi Nasıl Kullanıyoruz" : "How We Use Your Data",
              isTr
                ? "Yerelleştirilmiş veriler, kesinlikle Uygulamanın temel özelliklerini kolaylaştırmak için kullanılır: geri dönüştürülebilir malzemeleri tanımlamak ve kategorize etmek. Verilerinizi hedefli reklamcılık veya üçüncü taraf profillemesi için kullanmayız."
                : "The localized data is strictly used to facilitate the core features of the App: identifying and categorizing recyclable materials. We do not use your data for targeted advertising or third-party profiling.",
            ),
            const SizedBox(height: 24),
            _buildPolicySection(
              isTr ? "Veri Güvenliği" : "Data Security",
              isTr
                ? "Yerelleştirilmiş verileri korumak için endüstri standardı teknik ve organizasyonel güvenlik önlemleri uyguluyoruz. Uygulama gereksiz bulut yüklemelerinden kaçındığından, veri ihlali riskiniz önemli ölçüde en aza indirilir."
                : "We implement industry-standard technical and organizational security measures to protect any localized data. Since the application avoids unnecessary cloud uploads, your risk of data breaches is significantly minimized.",
            ),
            const SizedBox(height: 24),
            _buildPolicySection(
              isTr ? "Gizlilik Haklarınız" : "Your Privacy Rights",
              isTr
                ? "Tüm application verilerinizi doğrudan cihazınızın sistem ayarlarından silme hakkına sahipsiniz. Bunu yapmak, tarama geçmişinizi ve özelleştirilmiş tercihlerinizi kalıcı olarak silecektir."
                : "You have the right to delete all your application data directly from your device's system settings. Doing so will permanently erase your scanning history and customized preferences.",
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                isTr ? "Son Güncelleme: Nisan 2026" : "Last Updated: April 2026",
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