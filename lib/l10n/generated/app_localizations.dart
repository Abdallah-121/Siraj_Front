import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('ar'),
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Siraj'**
  String get appName;

  /// No description provided for @welcomeTagline.
  ///
  /// In en, this message translates to:
  /// **'Noor Guides You Every Day'**
  String get welcomeTagline;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get continueAsGuest;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get changeLanguage;

  /// No description provided for @loginWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Siraj!'**
  String get loginWelcomeTitle;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @enterUsername.
  ///
  /// In en, this message translates to:
  /// **'Enter username'**
  String get enterUsername;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgotPassword;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @loginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get loginWithGoogle;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create a new account'**
  String get createNewAccount;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get registerTitle;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @enterPasswordAgain.
  ///
  /// In en, this message translates to:
  /// **'Enter password again'**
  String get enterPasswordAgain;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterNewPassword;

  /// No description provided for @confirmationCode.
  ///
  /// In en, this message translates to:
  /// **'Confirmation code'**
  String get confirmationCode;

  /// No description provided for @enterConfirmationCode.
  ///
  /// In en, this message translates to:
  /// **'6-digit code from your email'**
  String get enterConfirmationCode;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgotPasswordTitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search here'**
  String get searchPlaceholder;

  /// No description provided for @lessonTypesTitle.
  ///
  /// In en, this message translates to:
  /// **'What types of lessons are you usually interested in?'**
  String get lessonTypesTitle;

  /// No description provided for @quranCategory.
  ///
  /// In en, this message translates to:
  /// **'Holy Quran'**
  String get quranCategory;

  /// No description provided for @islamicSciencesCategory.
  ///
  /// In en, this message translates to:
  /// **'Islamic Sciences'**
  String get islamicSciencesCategory;

  /// No description provided for @viewAllNearbyMosques.
  ///
  /// In en, this message translates to:
  /// **'View all nearby mosques'**
  String get viewAllNearbyMosques;

  /// No description provided for @viewAllAcademies.
  ///
  /// In en, this message translates to:
  /// **'View all academies'**
  String get viewAllAcademies;

  /// No description provided for @sampleMosqueName.
  ///
  /// In en, this message translates to:
  /// **'Sample Mosque'**
  String get sampleMosqueName;

  /// No description provided for @sampleAcademyName.
  ///
  /// In en, this message translates to:
  /// **'Sample Academy'**
  String get sampleAcademyName;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @bookmarks.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get bookmarks;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @accountLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your location'**
  String get accountLocationTitle;

  /// No description provided for @governorate.
  ///
  /// In en, this message translates to:
  /// **'Governorate'**
  String get governorate;

  /// No description provided for @searchGovernorate.
  ///
  /// In en, this message translates to:
  /// **'Search governorate'**
  String get searchGovernorate;

  /// No description provided for @neighborhood.
  ///
  /// In en, this message translates to:
  /// **'Neighborhood'**
  String get neighborhood;

  /// No description provided for @writeNeighborhood.
  ///
  /// In en, this message translates to:
  /// **'Please enter your residential area'**
  String get writeNeighborhood;

  /// No description provided for @neighborhoodHelp.
  ///
  /// In en, this message translates to:
  /// **'If your neighborhood/village is not listed, please provide the closest suitable address'**
  String get neighborhoodHelp;

  /// No description provided for @damascus.
  ///
  /// In en, this message translates to:
  /// **'Damascus'**
  String get damascus;

  /// No description provided for @aleppo.
  ///
  /// In en, this message translates to:
  /// **'Aleppo'**
  String get aleppo;

  /// No description provided for @hama.
  ///
  /// In en, this message translates to:
  /// **'Hama'**
  String get hama;

  /// No description provided for @tartus.
  ///
  /// In en, this message translates to:
  /// **'Tartus'**
  String get tartus;

  /// No description provided for @latakia.
  ///
  /// In en, this message translates to:
  /// **'Latakia'**
  String get latakia;

  /// No description provided for @daraa.
  ///
  /// In en, this message translates to:
  /// **'Daraa'**
  String get daraa;

  /// No description provided for @suwayda.
  ///
  /// In en, this message translates to:
  /// **'As-Suwayda'**
  String get suwayda;

  /// No description provided for @homs.
  ///
  /// In en, this message translates to:
  /// **'Homs'**
  String get homs;

  /// No description provided for @deirEzzor.
  ///
  /// In en, this message translates to:
  /// **'Deir ez-Zor'**
  String get deirEzzor;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @mosques.
  ///
  /// In en, this message translates to:
  /// **'Mosques'**
  String get mosques;

  /// No description provided for @academies.
  ///
  /// In en, this message translates to:
  /// **'Academies'**
  String get academies;

  /// No description provided for @sheikhs.
  ///
  /// In en, this message translates to:
  /// **'Sheikhs'**
  String get sheikhs;

  /// No description provided for @showMosquesBy.
  ///
  /// In en, this message translates to:
  /// **'Show mosques by'**
  String get showMosquesBy;

  /// No description provided for @showAcademiesBy.
  ///
  /// In en, this message translates to:
  /// **'Show academies by'**
  String get showAcademiesBy;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get area;

  /// No description provided for @quran.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get quran;

  /// No description provided for @shariaSciences.
  ///
  /// In en, this message translates to:
  /// **'Sharia Sciences'**
  String get shariaSciences;

  /// No description provided for @sheikh.
  ///
  /// In en, this message translates to:
  /// **'Sheikh'**
  String get sheikh;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @preacherLabel.
  ///
  /// In en, this message translates to:
  /// **'Preacher'**
  String get preacherLabel;

  /// No description provided for @imamLabel.
  ///
  /// In en, this message translates to:
  /// **'Imam'**
  String get imamLabel;

  /// No description provided for @studyTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Study type'**
  String get studyTypeLabel;

  /// No description provided for @sampleName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get sampleName;

  /// No description provided for @samplePreacher.
  ///
  /// In en, this message translates to:
  /// **'Preacher'**
  String get samplePreacher;

  /// No description provided for @sampleImam.
  ///
  /// In en, this message translates to:
  /// **'Imam'**
  String get sampleImam;

  /// No description provided for @sampleStudyType.
  ///
  /// In en, this message translates to:
  /// **'Quran, sciences, or both'**
  String get sampleStudyType;

  /// No description provided for @freeAcademy.
  ///
  /// In en, this message translates to:
  /// **'Free academy'**
  String get freeAcademy;

  /// No description provided for @paidAcademy.
  ///
  /// In en, this message translates to:
  /// **'Paid academy'**
  String get paidAcademy;

  /// No description provided for @newUpdateAvailable.
  ///
  /// In en, this message translates to:
  /// **'New update available'**
  String get newUpdateAvailable;

  /// No description provided for @subjectBranchSelectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Sharia Sciences'**
  String get subjectBranchSelectionTitle;

  /// No description provided for @subjectPlacesTitle.
  ///
  /// In en, this message translates to:
  /// **'Holy Quran'**
  String get subjectPlacesTitle;

  /// No description provided for @hadith.
  ///
  /// In en, this message translates to:
  /// **'Hadith'**
  String get hadith;

  /// No description provided for @tafsir.
  ///
  /// In en, this message translates to:
  /// **'Tafsir'**
  String get tafsir;

  /// No description provided for @fiqh.
  ///
  /// In en, this message translates to:
  /// **'Fiqh'**
  String get fiqh;

  /// No description provided for @aqeedah.
  ///
  /// In en, this message translates to:
  /// **'Aqeedah'**
  String get aqeedah;

  /// No description provided for @arabicLanguage.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabicLanguage;

  /// No description provided for @tajweed.
  ///
  /// In en, this message translates to:
  /// **'Tajweed'**
  String get tajweed;

  /// No description provided for @showResultsBy.
  ///
  /// In en, this message translates to:
  /// **'Show results by'**
  String get showResultsBy;

  /// No description provided for @mosqueDetails.
  ///
  /// In en, this message translates to:
  /// **'Mosque details'**
  String get mosqueDetails;

  /// No description provided for @academyDetails.
  ///
  /// In en, this message translates to:
  /// **'Academy details'**
  String get academyDetails;

  /// No description provided for @availableLessons.
  ///
  /// In en, this message translates to:
  /// **'Available lessons:'**
  String get availableLessons;

  /// No description provided for @studyProgram.
  ///
  /// In en, this message translates to:
  /// **'Study program:'**
  String get studyProgram;

  /// No description provided for @teachers.
  ///
  /// In en, this message translates to:
  /// **'Teachers:'**
  String get teachers;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes:'**
  String get notes;

  /// No description provided for @contactNumber.
  ///
  /// In en, this message translates to:
  /// **'Contact number:'**
  String get contactNumber;

  /// No description provided for @numberOfStudents.
  ///
  /// In en, this message translates to:
  /// **'Number of students:'**
  String get numberOfStudents;

  /// No description provided for @registration.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get registration;

  /// No description provided for @sampleLessonsValue.
  ///
  /// In en, this message translates to:
  /// **'Holy Quran - Sharia Sciences - Arabic Language'**
  String get sampleLessonsValue;

  /// No description provided for @sampleProgramValue.
  ///
  /// In en, this message translates to:
  /// **'Sunday, Tuesday, and Thursday'**
  String get sampleProgramValue;

  /// No description provided for @sampleTeachersValue.
  ///
  /// In en, this message translates to:
  /// **'Sheikh Abdullah - Sheikh Mahmoud'**
  String get sampleTeachersValue;

  /// No description provided for @sampleNotesValue.
  ///
  /// In en, this message translates to:
  /// **'Please arrive 15 minutes early'**
  String get sampleNotesValue;

  /// No description provided for @sampleContactValue.
  ///
  /// In en, this message translates to:
  /// **'09XXXXXXXX'**
  String get sampleContactValue;

  /// No description provided for @sampleStudentsValue.
  ///
  /// In en, this message translates to:
  /// **'120 students'**
  String get sampleStudentsValue;

  /// No description provided for @sheikhDetails.
  ///
  /// In en, this message translates to:
  /// **'Sheikh details'**
  String get sheikhDetails;

  /// No description provided for @specialization.
  ///
  /// In en, this message translates to:
  /// **'Specialization:'**
  String get specialization;

  /// No description provided for @teachingLocations.
  ///
  /// In en, this message translates to:
  /// **'Teaching locations:'**
  String get teachingLocations;

  /// No description provided for @sampleSpecializationValue.
  ///
  /// In en, this message translates to:
  /// **'Fiqh - Tafsir - Quran Sciences'**
  String get sampleSpecializationValue;

  /// No description provided for @sampleTeachingLocationsValue.
  ///
  /// In en, this message translates to:
  /// **'Sample Mosque - Sample Academy'**
  String get sampleTeachingLocationsValue;

  /// No description provided for @showSheikhsBy.
  ///
  /// In en, this message translates to:
  /// **'Show sheikhs by'**
  String get showSheikhsBy;

  /// No description provided for @registrationComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Registration will be connected later'**
  String get registrationComingSoon;

  /// No description provided for @placesTeachingSubject.
  ///
  /// In en, this message translates to:
  /// **'Mosques and academies that teach {subject}'**
  String placesTeachingSubject(Object subject);

  /// No description provided for @sampleMosqueTitle.
  ///
  /// In en, this message translates to:
  /// **'Sample Mosque'**
  String get sampleMosqueTitle;

  /// No description provided for @sampleAcademyTitle.
  ///
  /// In en, this message translates to:
  /// **'Sample Academy'**
  String get sampleAcademyTitle;

  /// No description provided for @sampleMosqueDescription.
  ///
  /// In en, this message translates to:
  /// **'This mosque offers Quran حلقات and Sharia lessons supervised by qualified teachers.'**
  String get sampleMosqueDescription;

  /// No description provided for @sampleAcademyDescription.
  ///
  /// In en, this message translates to:
  /// **'A specialized educational academy that teaches Sharia sciences and Arabic through a structured program.'**
  String get sampleAcademyDescription;

  /// No description provided for @registerInClass.
  ///
  /// In en, this message translates to:
  /// **'Register in class'**
  String get registerInClass;

  /// No description provided for @registerInCourse.
  ///
  /// In en, this message translates to:
  /// **'Register in course'**
  String get registerInCourse;

  /// No description provided for @sampleSheikhTitle.
  ///
  /// In en, this message translates to:
  /// **'Sample Sheikh'**
  String get sampleSheikhTitle;

  /// No description provided for @sampleSheikhDescription.
  ///
  /// In en, this message translates to:
  /// **'A sheikh specialized in teaching Sharia sciences and Quran studies through regular lessons and a clear educational program.'**
  String get sampleSheikhDescription;

  /// No description provided for @registerWithSheikh.
  ///
  /// In en, this message translates to:
  /// **'Register in circle'**
  String get registerWithSheikh;

  /// No description provided for @teachersAndSheikhs.
  ///
  /// In en, this message translates to:
  /// **'Teachers and sheikhs:'**
  String get teachersAndSheikhs;

  /// No description provided for @maximumStudents.
  ///
  /// In en, this message translates to:
  /// **'Maximum students in the course:'**
  String get maximumStudents;

  /// No description provided for @registrationOpenFrom.
  ///
  /// In en, this message translates to:
  /// **'Registration form opens from:'**
  String get registrationOpenFrom;

  /// No description provided for @certificateAvailable.
  ///
  /// In en, this message translates to:
  /// **'Certificate available'**
  String get certificateAvailable;

  /// No description provided for @noCertificateAvailable.
  ///
  /// In en, this message translates to:
  /// **'No certificate for this course'**
  String get noCertificateAvailable;

  /// No description provided for @forMoreContactInfo.
  ///
  /// In en, this message translates to:
  /// **'For more information call:'**
  String get forMoreContactInfo;

  /// No description provided for @sampleLessonsMultiline.
  ///
  /// In en, this message translates to:
  /// **'The Holy Quran and how to apply it in our daily life'**
  String get sampleLessonsMultiline;

  /// No description provided for @sampleProgramMultiline.
  ///
  /// In en, this message translates to:
  /// **'Sunday from 2 to 4\nSunday from 2 to 4\nSunday from 2 to 4'**
  String get sampleProgramMultiline;

  /// No description provided for @sampleTeachersMultiline.
  ///
  /// In en, this message translates to:
  /// **'Sample Sheikh, preacher, imam'**
  String get sampleTeachersMultiline;

  /// No description provided for @sampleMaximumStudentsValue.
  ///
  /// In en, this message translates to:
  /// **'12'**
  String get sampleMaximumStudentsValue;

  /// No description provided for @sampleRegistrationDateValue.
  ///
  /// In en, this message translates to:
  /// **'Sample date'**
  String get sampleRegistrationDateValue;

  /// No description provided for @sampleRegistrationDateSecondValue.
  ///
  /// In en, this message translates to:
  /// **'Sample date'**
  String get sampleRegistrationDateSecondValue;

  /// No description provided for @registrationFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Registration form'**
  String get registrationFormTitle;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @enterArabicName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name in Arabic'**
  String get enterArabicName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @enterArabicLastName.
  ///
  /// In en, this message translates to:
  /// **'Enter your last name in Arabic'**
  String get enterArabicLastName;

  /// No description provided for @appUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get appUsername;

  /// No description provided for @enterAppUsername.
  ///
  /// In en, this message translates to:
  /// **'Your name in the app'**
  String get enterAppUsername;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your number starting with 09'**
  String get enterPhoneNumber;

  /// No description provided for @confirmRegistration.
  ///
  /// In en, this message translates to:
  /// **'Confirm registration'**
  String get confirmRegistration;

  /// No description provided for @registrationAgreement.
  ///
  /// In en, this message translates to:
  /// **'Please make sure the information in the form is accurate to complete the registration. Requests with incomplete data will not be approved.'**
  String get registrationAgreement;

  /// No description provided for @registrationSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Registration completed successfully!'**
  String get registrationSuccessTitle;

  /// No description provided for @registrationFailureTitle.
  ///
  /// In en, this message translates to:
  /// **'Registration failed!'**
  String get registrationFailureTitle;

  /// No description provided for @registrationFailureMessage.
  ///
  /// In en, this message translates to:
  /// **'Please review your information in the form'**
  String get registrationFailureMessage;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTitle;

  /// No description provided for @suggestions.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get suggestions;

  /// No description provided for @recentSearches.
  ///
  /// In en, this message translates to:
  /// **'Recent searches'**
  String get recentSearches;

  /// No description provided for @searchPlaceholderTitle.
  ///
  /// In en, this message translates to:
  /// **'Search here'**
  String get searchPlaceholderTitle;

  /// No description provided for @mosquesSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Mosques'**
  String get mosquesSuggestion;

  /// No description provided for @academiesSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Academies'**
  String get academiesSuggestion;

  /// No description provided for @shariaSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Sharia sciences'**
  String get shariaSuggestion;

  /// No description provided for @quranSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Holy Quran'**
  String get quranSuggestion;

  /// No description provided for @fiqhSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Fiqh'**
  String get fiqhSuggestion;

  /// No description provided for @hadithSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Hadith'**
  String get hadithSuggestion;

  /// No description provided for @sheikhSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Sheikh'**
  String get sheikhSuggestion;

  /// No description provided for @sampleRecentSearch.
  ///
  /// In en, this message translates to:
  /// **'Mosque'**
  String get sampleRecentSearch;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @accountSection.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountSection;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @notificationsSection.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsSection;

  /// No description provided for @latestNotifications.
  ///
  /// In en, this message translates to:
  /// **'Latest notifications'**
  String get latestNotifications;

  /// No description provided for @muteAppNotifications.
  ///
  /// In en, this message translates to:
  /// **'Mute app notifications'**
  String get muteAppNotifications;

  /// No description provided for @additionalSettingsSection.
  ///
  /// In en, this message translates to:
  /// **'Additional settings'**
  String get additionalSettingsSection;

  /// No description provided for @changeAppLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change app language'**
  String get changeAppLanguage;

  /// No description provided for @technicalSupport.
  ///
  /// In en, this message translates to:
  /// **'Technical support'**
  String get technicalSupport;

  /// No description provided for @contactForSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Contact us for suggestions and complaints:'**
  String get contactForSuggestions;

  /// No description provided for @logoutFromApp.
  ///
  /// In en, this message translates to:
  /// **'Log out from app'**
  String get logoutFromApp;

  /// No description provided for @confirmLogoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get confirmLogoutTitle;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @confirmAnswer.
  ///
  /// In en, this message translates to:
  /// **'Confirm answer'**
  String get confirmAnswer;

  /// No description provided for @logoutSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Logged out successfully'**
  String get logoutSuccessMessage;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @editProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfileTitle;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @currentLessons.
  ///
  /// In en, this message translates to:
  /// **'Lessons not attended yet'**
  String get currentLessons;

  /// No description provided for @completedLessons.
  ///
  /// In en, this message translates to:
  /// **'Lessons attended'**
  String get completedLessons;

  /// No description provided for @currentCoursesTitle.
  ///
  /// In en, this message translates to:
  /// **'Your current lessons'**
  String get currentCoursesTitle;

  /// No description provided for @completedCoursesTitle.
  ///
  /// In en, this message translates to:
  /// **'Lessons you completed'**
  String get completedCoursesTitle;

  /// No description provided for @editProfileButton.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfileButton;

  /// No description provided for @saveProfileChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveProfileChanges;

  /// No description provided for @sampleUserName.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get sampleUserName;

  /// No description provided for @sampleUserEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get sampleUserEmail;

  /// No description provided for @courseName.
  ///
  /// In en, this message translates to:
  /// **'Course name'**
  String get courseName;

  /// No description provided for @sampleCourseTeacher.
  ///
  /// In en, this message translates to:
  /// **'Any mosque, academy, sheikh, or teacher'**
  String get sampleCourseTeacher;

  /// No description provided for @sampleCourseTime.
  ///
  /// In en, this message translates to:
  /// **'Any lesson time'**
  String get sampleCourseTime;

  /// No description provided for @technicalSupportWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to technical support!'**
  String get technicalSupportWelcomeTitle;

  /// No description provided for @technicalSupportDescription.
  ///
  /// In en, this message translates to:
  /// **'Please describe your issue in detail so we can help you'**
  String get technicalSupportDescription;

  /// No description provided for @yourProblem.
  ///
  /// In en, this message translates to:
  /// **'Your issue...'**
  String get yourProblem;

  /// No description provided for @sendProblem.
  ///
  /// In en, this message translates to:
  /// **'Send issue'**
  String get sendProblem;

  /// No description provided for @problemSentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Issue sent successfully!'**
  String get problemSentSuccessfully;

  /// No description provided for @problemSendFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send issue!'**
  String get problemSendFailed;

  /// No description provided for @problemSendFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Please review your message and try again'**
  String get problemSendFailedMessage;

  /// No description provided for @changeLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Change app language'**
  String get changeLanguageTitle;

  /// No description provided for @searchForDesiredLanguage.
  ///
  /// In en, this message translates to:
  /// **'Search for the desired language'**
  String get searchForDesiredLanguage;

  /// No description provided for @englishLanguage.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get englishLanguage;

  /// No description provided for @germanLanguage.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get germanLanguage;

  /// No description provided for @languageUpdateNote.
  ///
  /// In en, this message translates to:
  /// **'More languages will be included in upcoming app updates'**
  String get languageUpdateNote;

  /// No description provided for @changeLanguageButton.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get changeLanguageButton;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @noMosquesFound.
  ///
  /// In en, this message translates to:
  /// **'No matching mosques found'**
  String get noMosquesFound;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @enterFirstName.
  ///
  /// In en, this message translates to:
  /// **'Enter first name'**
  String get enterFirstName;

  /// No description provided for @enterLastName.
  ///
  /// In en, this message translates to:
  /// **'Enter last name'**
  String get enterLastName;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'Birth date'**
  String get birthDate;

  /// No description provided for @enterBirthDate.
  ///
  /// In en, this message translates to:
  /// **'Choose birth date'**
  String get enterBirthDate;

  /// No description provided for @pleaseFillRequiredFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in the required fields'**
  String get pleaseFillRequiredFields;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @pleaseChooseCityAndNeighborhood.
  ///
  /// In en, this message translates to:
  /// **'Please choose a city and enter a neighborhood'**
  String get pleaseChooseCityAndNeighborhood;

  /// No description provided for @noLessonsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No lessons available حاليا'**
  String get noLessonsAvailable;

  /// No description provided for @completeCourse.
  ///
  /// In en, this message translates to:
  /// **'Complete course'**
  String get completeCourse;

  /// No description provided for @singleLesson.
  ///
  /// In en, this message translates to:
  /// **'Single lesson'**
  String get singleLesson;

  /// No description provided for @cityNameLabel.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get cityNameLabel;

  /// No description provided for @addLesson.
  ///
  /// In en, this message translates to:
  /// **'Add lesson'**
  String get addLesson;

  /// No description provided for @categoryIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Category ID'**
  String get categoryIdLabel;

  /// No description provided for @teacherIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Teacher ID'**
  String get teacherIdLabel;

  /// No description provided for @lessonNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Lesson name'**
  String get lessonNameLabel;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @liveStreamingCapabilityLabel.
  ///
  /// In en, this message translates to:
  /// **'Live streaming capability'**
  String get liveStreamingCapabilityLabel;

  /// No description provided for @published.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get published;

  /// No description provided for @unpublished.
  ///
  /// In en, this message translates to:
  /// **'Unpublished'**
  String get unpublished;

  /// No description provided for @publish.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get publish;

  /// No description provided for @unpublish.
  ///
  /// In en, this message translates to:
  /// **'Unpublish'**
  String get unpublish;

  /// No description provided for @lessonPublishedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Lesson published successfully'**
  String get lessonPublishedSuccessfully;

  /// No description provided for @lessonUnpublishedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Lesson unpublished successfully'**
  String get lessonUnpublishedSuccessfully;

  /// No description provided for @publishLessonFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to publish lesson'**
  String get publishLessonFailed;

  /// No description provided for @unpublishLessonFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to unpublish lesson'**
  String get unpublishLessonFailed;

  /// No description provided for @profileDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Write a short description about yourself'**
  String get profileDescriptionHint;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @profileImage.
  ///
  /// In en, this message translates to:
  /// **'Profile image'**
  String get profileImage;

  /// No description provided for @profileImageUrlHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the profile image URL'**
  String get profileImageUrlHint;

  /// No description provided for @noCitiesFound.
  ///
  /// In en, this message translates to:
  /// **'No matching cities found'**
  String get noCitiesFound;

  /// No description provided for @promoteUserToTeacher.
  ///
  /// In en, this message translates to:
  /// **'Promote user to teacher'**
  String get promoteUserToTeacher;

  /// No description provided for @promoteUserToTeacherHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name, email, or phone, then add the teacher information.'**
  String get promoteUserToTeacherHint;

  /// No description provided for @searchUserForPromotionHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a user'**
  String get searchUserForPromotionHint;

  /// No description provided for @searchUserForPromotionStart.
  ///
  /// In en, this message translates to:
  /// **'Type at least two characters to search for a user.'**
  String get searchUserForPromotionStart;

  /// No description provided for @noUsersFoundForPromotion.
  ///
  /// In en, this message translates to:
  /// **'No matching user was found. You can create a new teacher account.'**
  String get noUsersFoundForPromotion;

  /// No description provided for @promoteToTeacher.
  ///
  /// In en, this message translates to:
  /// **'Promote to teacher'**
  String get promoteToTeacher;

  /// No description provided for @createTeacherAccount.
  ///
  /// In en, this message translates to:
  /// **'Create teacher account'**
  String get createTeacherAccount;

  /// No description provided for @createTeacherAccountHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the new teacher details and link the account to this mosque.'**
  String get createTeacherAccountHint;

  /// No description provided for @qualification.
  ///
  /// In en, this message translates to:
  /// **'Qualification'**
  String get qualification;

  /// No description provided for @enterTeacherQualification.
  ///
  /// In en, this message translates to:
  /// **'Enter the teacher qualification'**
  String get enterTeacherQualification;

  /// No description provided for @bio.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bio;

  /// No description provided for @enterTeacherBio.
  ///
  /// In en, this message translates to:
  /// **'Enter the teacher bio'**
  String get enterTeacherBio;

  /// No description provided for @teacherSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Teacher saved successfully'**
  String get teacherSavedSuccessfully;

  /// No description provided for @noFavoriteMosques.
  ///
  /// In en, this message translates to:
  /// **'There are no favorite mosques yet'**
  String get noFavoriteMosques;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get viewDetails;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @addCategory.
  ///
  /// In en, this message translates to:
  /// **'Add category'**
  String get addCategory;

  /// No description provided for @editCategory.
  ///
  /// In en, this message translates to:
  /// **'Edit category'**
  String get editCategory;

  /// No description provided for @deleteCategory.
  ///
  /// In en, this message translates to:
  /// **'Delete category'**
  String get deleteCategory;

  /// No description provided for @categoryName.
  ///
  /// In en, this message translates to:
  /// **'Category name'**
  String get categoryName;

  /// No description provided for @enterCategoryName.
  ///
  /// In en, this message translates to:
  /// **'Enter category name'**
  String get enterCategoryName;

  /// No description provided for @deleteCategoryConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this category?'**
  String get deleteCategoryConfirmation;

  /// No description provided for @categoryCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Category created successfully'**
  String get categoryCreatedSuccessfully;

  /// No description provided for @categoryUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Category updated successfully'**
  String get categoryUpdatedSuccessfully;

  /// No description provided for @categoryDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Category deleted successfully'**
  String get categoryDeletedSuccessfully;

  /// No description provided for @noCategoriesFound.
  ///
  /// In en, this message translates to:
  /// **'No categories found'**
  String get noCategoriesFound;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select category'**
  String get selectCategory;
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
      <String>['ar', 'de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
