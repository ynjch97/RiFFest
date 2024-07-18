// ignore_for_file: slash_for_doc_comments

class Routes {
  static const mainScreen = "/:tab(festival|community|profile)";

  static const signUpScreen = "/";
  static const loginScreen = "/login";
  // static const emailScreen = "/email";
  // static const nameScreen = "/name";
  static const termsScreen = "/terms";
  static const interestsScreen = "/tutorial";

  static const festivalScreen = "/festival";
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
}

class Tabs {
  // MainNavigationScreen 탭
  static const List<String> mainTabs = [
    "festival",
    "community",
    "profile",
  ];
}
