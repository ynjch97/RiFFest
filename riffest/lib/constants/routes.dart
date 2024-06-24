// ignore_for_file: slash_for_doc_comments

class Routes {
  static const mainScreen = "/:tab(festival|community|profile)";

  static const signUpScreen = "/";
  static const loginScreen = "/login";
  static const interestsScreen = "/tutorial";
}

class RoutesName {
  static const mainScreen = "main";

  static const signUpScreen = "signUp";
  static const loginScreen = "login";
  static const interestsScreen = "interests";
}

class Tabs {
  // MainNavigationScreen 탭
  static const List<String> mainTabs = [
    "festival",
    "community",
    "profile",
  ];
}
