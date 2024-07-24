// ignore_for_file: slash_for_doc_comments

class Routes {
  static const mainScreen = "/:tab(festival|community|guide|profile)";

  static const signUpScreen = "/";
  static const loginScreen = "/login";
  // static const emailScreen = "/email";
  // static const nameScreen = "/name";
  static const termsScreen = "/terms";
  static const interestsScreen = "/tutorial";

  static const festivalScreen = "/festival";
  static const timeTableScreen = "/guide";
}

class RoutesName {
  static const mainScreen = "main";

  static const signUpScreen = "signUp";
  static const loginScreen = "login";
  // static const emailScreen = "email";
  // static const nameScreen = "name";
  static const termsScreen = "terms";
  static const interestsScreen = "interests";

  static const festivalScreen = "festival";
  static const timeTableScreen = "guide";
}

class Tabs {
  // MainNavigationScreen 탭
  static const List<String> mainTabs = [
    "festival",
    "community",
    "guide",
    "profile",
  ];
}
