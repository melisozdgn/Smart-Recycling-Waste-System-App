import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminders;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @generalPreferences.
  ///
  /// In en, this message translates to:
  /// **'General Preferences'**
  String get generalPreferences;

  /// No description provided for @dailySortingReminders.
  ///
  /// In en, this message translates to:
  /// **'Daily sorting reminders'**
  String get dailySortingReminders;

  /// No description provided for @projectInfo.
  ///
  /// In en, this message translates to:
  /// **'Project Info'**
  String get projectInfo;

  /// No description provided for @aboutSrws.
  ///
  /// In en, this message translates to:
  /// **'About SRWS'**
  String get aboutSrws;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get version;

  /// No description provided for @sustainabilityGoals.
  ///
  /// In en, this message translates to:
  /// **'Sustainability Goals'**
  String get sustainabilityGoals;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @howToUseApp.
  ///
  /// In en, this message translates to:
  /// **'How to Use App'**
  String get howToUseApp;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @sortingWastes.
  ///
  /// In en, this message translates to:
  /// **'Sorting Wastes'**
  String get sortingWastes;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @selectImage.
  ///
  /// In en, this message translates to:
  /// **'Select Image'**
  String get selectImage;

  /// No description provided for @navHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// No description provided for @navSorting.
  ///
  /// In en, this message translates to:
  /// **'Sorting'**
  String get navSorting;

  /// No description provided for @navGuide.
  ///
  /// In en, this message translates to:
  /// **'Guide'**
  String get navGuide;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @recyclingGuide.
  ///
  /// In en, this message translates to:
  /// **'Recycling Guide'**
  String get recyclingGuide;

  /// No description provided for @learnAndProtect.
  ///
  /// In en, this message translates to:
  /// **'LEARN & PROTECT'**
  String get learnAndProtect;

  /// No description provided for @responsibleConsumption.
  ///
  /// In en, this message translates to:
  /// **'SDG 11 & 12: Responsible Consumption'**
  String get responsibleConsumption;

  /// No description provided for @plasticTitle.
  ///
  /// In en, this message translates to:
  /// **'Plastic'**
  String get plasticTitle;

  /// No description provided for @paperTitle.
  ///
  /// In en, this message translates to:
  /// **'Paper & Cardboard'**
  String get paperTitle;

  /// No description provided for @glassTitle.
  ///
  /// In en, this message translates to:
  /// **'Glass'**
  String get glassTitle;

  /// No description provided for @metalTitle.
  ///
  /// In en, this message translates to:
  /// **'Metal'**
  String get metalTitle;

  /// No description provided for @batteriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Batteries'**
  String get batteriesTitle;

  /// No description provided for @ecoGuest.
  ///
  /// In en, this message translates to:
  /// **'Eco Guest'**
  String get ecoGuest;

  /// No description provided for @dataStoredLocally.
  ///
  /// In en, this message translates to:
  /// **'Data stored locally'**
  String get dataStoredLocally;

  /// No description provided for @modernWasteSorting.
  ///
  /// In en, this message translates to:
  /// **'Modern Waste Sorting'**
  String get modernWasteSorting;

  /// No description provided for @howToRecycleCorrectly.
  ///
  /// In en, this message translates to:
  /// **'How to Recycle Correctly'**
  String get howToRecycleCorrectly;

  /// No description provided for @didYouKnow.
  ///
  /// In en, this message translates to:
  /// **'Did you know?'**
  String get didYouKnow;

  /// No description provided for @plasticDesc.
  ///
  /// In en, this message translates to:
  /// **'Bottles, containers, and packaging...'**
  String get plasticDesc;

  /// No description provided for @paperDesc.
  ///
  /// In en, this message translates to:
  /// **'Boxes, newspapers, and clean cardboard...'**
  String get paperDesc;

  /// No description provided for @glassDesc.
  ///
  /// In en, this message translates to:
  /// **'Jars and beverage bottles...'**
  String get glassDesc;

  /// No description provided for @metalDesc.
  ///
  /// In en, this message translates to:
  /// **'Cans, tins, and aluminum foil...'**
  String get metalDesc;

  /// No description provided for @batteriesDesc.
  ///
  /// In en, this message translates to:
  /// **'Alkaline and rechargeable batteries...'**
  String get batteriesDesc;

  /// No description provided for @eWasteTitle.
  ///
  /// In en, this message translates to:
  /// **'E-Waste'**
  String get eWasteTitle;

  /// No description provided for @eWasteDesc.
  ///
  /// In en, this message translates to:
  /// **'Electronics, phones, and cables...'**
  String get eWasteDesc;

  /// No description provided for @organicWasteTitle.
  ///
  /// In en, this message translates to:
  /// **'Organic Waste'**
  String get organicWasteTitle;

  /// No description provided for @organicWasteDesc.
  ///
  /// In en, this message translates to:
  /// **'Food scraps and garden waste...'**
  String get organicWasteDesc;

  /// No description provided for @plasticFact.
  ///
  /// In en, this message translates to:
  /// **'Recycling 1 ton of plastic saves 5,774 kWh of energy.'**
  String get plasticFact;

  /// No description provided for @plasticInst1.
  ///
  /// In en, this message translates to:
  /// **'Rinse out any food or liquid residue.'**
  String get plasticInst1;

  /// No description provided for @plasticInst2.
  ///
  /// In en, this message translates to:
  /// **'Check the resin code (1-7) on the bottom.'**
  String get plasticInst2;

  /// No description provided for @plasticInst3.
  ///
  /// In en, this message translates to:
  /// **'Remove plastic caps.'**
  String get plasticInst3;

  /// No description provided for @plasticInst4.
  ///
  /// In en, this message translates to:
  /// **'Do not recycle plastic bags here.'**
  String get plasticInst4;

  /// No description provided for @paperFact.
  ///
  /// In en, this message translates to:
  /// **'Recycling paper saves 70% less energy than making it from raw wood.'**
  String get paperFact;

  /// No description provided for @paperInst1.
  ///
  /// In en, this message translates to:
  /// **'Flatten cardboard boxes.'**
  String get paperInst1;

  /// No description provided for @paperInst2.
  ///
  /// In en, this message translates to:
  /// **'Remove plastic tape or staples.'**
  String get paperInst2;

  /// No description provided for @paperInst3.
  ///
  /// In en, this message translates to:
  /// **'Do not recycle greasy pizza boxes.'**
  String get paperInst3;

  /// No description provided for @paperInst4.
  ///
  /// In en, this message translates to:
  /// **'Keep paper dry.'**
  String get paperInst4;

  /// No description provided for @glassFact.
  ///
  /// In en, this message translates to:
  /// **'Glass is 100% recyclable and can be recycled endlessly.'**
  String get glassFact;

  /// No description provided for @glassInst1.
  ///
  /// In en, this message translates to:
  /// **'Wash thoroughly.'**
  String get glassInst1;

  /// No description provided for @glassInst2.
  ///
  /// In en, this message translates to:
  /// **'Separate by color if required.'**
  String get glassInst2;

  /// No description provided for @glassInst3.
  ///
  /// In en, this message translates to:
  /// **'Do not include mirrors or window glass.'**
  String get glassInst3;

  /// No description provided for @glassInst4.
  ///
  /// In en, this message translates to:
  /// **'Remove metal lids.'**
  String get glassInst4;

  /// No description provided for @metalFact.
  ///
  /// In en, this message translates to:
  /// **'Aluminum cans can be recycled and back on shelf in 60 days.'**
  String get metalFact;

  /// No description provided for @metalInst1.
  ///
  /// In en, this message translates to:
  /// **'Empty and rinse all food cans.'**
  String get metalInst1;

  /// No description provided for @metalInst2.
  ///
  /// In en, this message translates to:
  /// **'Crush aluminum cans.'**
  String get metalInst2;

  /// No description provided for @metalInst3.
  ///
  /// In en, this message translates to:
  /// **'Separate aluminum from steel.'**
  String get metalInst3;

  /// No description provided for @metalInst4.
  ///
  /// In en, this message translates to:
  /// **'Clean foil from food waste.'**
  String get metalInst4;

  /// No description provided for @batteriesFact.
  ///
  /// In en, this message translates to:
  /// **'One battery can contaminate 600,000 liters of water.'**
  String get batteriesFact;

  /// No description provided for @batteriesInst1.
  ///
  /// In en, this message translates to:
  /// **'Use dedicated e-waste collection points.'**
  String get batteriesInst1;

  /// No description provided for @batteriesInst2.
  ///
  /// In en, this message translates to:
  /// **'Cover terminals with tape.'**
  String get batteriesInst2;

  /// No description provided for @batteriesInst3.
  ///
  /// In en, this message translates to:
  /// **'Never throw in regular trash bins.'**
  String get batteriesInst3;

  /// No description provided for @batteriesInst4.
  ///
  /// In en, this message translates to:
  /// **'Handle leaking batteries with care.'**
  String get batteriesInst4;

  /// No description provided for @eWasteFact.
  ///
  /// In en, this message translates to:
  /// **'Only 20% of global e-waste is formally recycled each year.'**
  String get eWasteFact;

  /// No description provided for @eWasteInst1.
  ///
  /// In en, this message translates to:
  /// **'Take to certified e-waste collection centers.'**
  String get eWasteInst1;

  /// No description provided for @eWasteInst2.
  ///
  /// In en, this message translates to:
  /// **'Remove personal data before disposal.'**
  String get eWasteInst2;

  /// No description provided for @eWasteInst3.
  ///
  /// In en, this message translates to:
  /// **'Do not throw in regular trash.'**
  String get eWasteInst3;

  /// No description provided for @eWasteInst4.
  ///
  /// In en, this message translates to:
  /// **'Separate cables and accessories.'**
  String get eWasteInst4;

  /// No description provided for @organicWasteFact.
  ///
  /// In en, this message translates to:
  /// **'Composting can reduce household waste by up to 30%.'**
  String get organicWasteFact;

  /// No description provided for @organicWasteInst1.
  ///
  /// In en, this message translates to:
  /// **'Use a compost bin at home.'**
  String get organicWasteInst1;

  /// No description provided for @organicWasteInst2.
  ///
  /// In en, this message translates to:
  /// **'Keep meat and dairy out of home compost.'**
  String get organicWasteInst2;

  /// No description provided for @organicWasteInst3.
  ///
  /// In en, this message translates to:
  /// **'Avoid plastic-lined containers.'**
  String get organicWasteInst3;

  /// No description provided for @organicWasteInst4.
  ///
  /// In en, this message translates to:
  /// **'Mix greens and browns for best results.'**
  String get organicWasteInst4;

  /// No description provided for @yourDeviceLog.
  ///
  /// In en, this message translates to:
  /// **'Your Device Log'**
  String get yourDeviceLog;

  /// No description provided for @localImpact.
  ///
  /// In en, this message translates to:
  /// **'Local Impact'**
  String get localImpact;

  /// No description provided for @totalScans.
  ///
  /// In en, this message translates to:
  /// **'Total Scans'**
  String get totalScans;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @rankBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get rankBeginner;

  /// No description provided for @yourRank.
  ///
  /// In en, this message translates to:
  /// **'Your Rank'**
  String get yourRank;

  /// No description provided for @recentScans.
  ///
  /// In en, this message translates to:
  /// **'Recent Scans'**
  String get recentScans;

  /// No description provided for @noScansYet.
  ///
  /// In en, this message translates to:
  /// **'No scans yet'**
  String get noScansYet;

  /// No description provided for @takePhotoToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Take a photo to get started!'**
  String get takePhotoToGetStarted;

  /// No description provided for @rankRecycler.
  ///
  /// In en, this message translates to:
  /// **'Recycler'**
  String get rankRecycler;

  /// No description provided for @rankEcoHero.
  ///
  /// In en, this message translates to:
  /// **'Eco-Hero'**
  String get rankEcoHero;

  /// No description provided for @rankPlanetSavior.
  ///
  /// In en, this message translates to:
  /// **'Planet Savior'**
  String get rankPlanetSavior;

  /// No description provided for @clearHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear History'**
  String get clearHistory;

  /// No description provided for @clearHistoryConfirm.
  ///
  /// In en, this message translates to:
  /// **'All scan history will be permanently deleted from this device.'**
  String get clearHistoryConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @noHistoryFound.
  ///
  /// In en, this message translates to:
  /// **'No history found on this device'**
  String get noHistoryFound;

  /// No description provided for @scanningAndAnalyzing.
  ///
  /// In en, this message translates to:
  /// **'Scanning & Analyzing...'**
  String get scanningAndAnalyzing;

  /// No description provided for @positionItemInsideFrame.
  ///
  /// In en, this message translates to:
  /// **'Position item inside the frame'**
  String get positionItemInsideFrame;

  /// No description provided for @startingCamera.
  ///
  /// In en, this message translates to:
  /// **'Starting camera...'**
  String get startingCamera;

  /// No description provided for @cameraAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'Camera access denied. Please enable camera permission in settings.'**
  String get cameraAccessDenied;

  /// No description provided for @cameraUnknownError.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred while starting the camera.'**
  String get cameraUnknownError;

  /// No description provided for @confidenceText.
  ///
  /// In en, this message translates to:
  /// **'Confidence'**
  String get confidenceText;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @binPlastic.
  ///
  /// In en, this message translates to:
  /// **'Plastic Bin'**
  String get binPlastic;

  /// No description provided for @binPaper.
  ///
  /// In en, this message translates to:
  /// **'Paper Bin'**
  String get binPaper;

  /// No description provided for @binGlass.
  ///
  /// In en, this message translates to:
  /// **'Glass Bin'**
  String get binGlass;

  /// No description provided for @binMetal.
  ///
  /// In en, this message translates to:
  /// **'Metal Bin'**
  String get binMetal;

  /// No description provided for @binBatteries.
  ///
  /// In en, this message translates to:
  /// **'Batteries Bin'**
  String get binBatteries;

  /// No description provided for @binEWaste.
  ///
  /// In en, this message translates to:
  /// **'E-Waste Bin'**
  String get binEWaste;

  /// No description provided for @binOrganic.
  ///
  /// In en, this message translates to:
  /// **'Organic Bin'**
  String get binOrganic;

  /// No description provided for @binGeneral.
  ///
  /// In en, this message translates to:
  /// **'General Waste Bin'**
  String get binGeneral;

  /// No description provided for @placeIn.
  ///
  /// In en, this message translates to:
  /// **'Place in: {binName}'**
  String placeIn(String binName);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
