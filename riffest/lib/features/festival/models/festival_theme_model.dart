class FestivalThemeModel {
  final String themeKey;
  final String themeName;
  // 필터링 값
  final String year; // 일시(년)
  final String month; // 일시(월) (ex. 6,3 : 6월부터 세 달을 의미 -> 6~8월)
  // 필터링 값 (filter 배열 공통 사용으로, 하나만 작성)
  final String location; // 지역
  final String genre; // 장르
  // 필터링 사용 여부
  final bool isDDay; // D-Day
  final bool isRating; // 순위
  final bool isStarRating; // 별점

  FestivalThemeModel({
    required this.themeKey,
    required this.themeName,
    required this.year,
    required this.month,
    required this.location,
    required this.genre,
    required this.isDDay,
    required this.isRating,
    required this.isStarRating,
  });

  FestivalThemeModel.empty()
      : themeKey = "",
        themeName = "",
        year = "",
        month = "",
        location = "",
        genre = "",
        isDDay = false,
        isRating = false,
        isStarRating = false;

  FestivalThemeModel.fromJson(Map<String, dynamic> json)
      : themeKey = json["themeKey"],
        themeName = json["themeName"],
        year = json["year"],
        month = json["month"],
        location = json["location"],
        genre = json["genre"],
        isDDay = json["isDDay"],
        isRating = json["isRating"],
        isStarRating = json["isStarRating"];

  // JSON 으로 변경하기
  Map<String, dynamic> toJson() {
    return {
      "themeKey": themeKey,
      "themeName": themeName,
      "year": year,
      "month": month,
      "location": location,
      "genre": genre,
      "isDDay": isDDay,
      "isRating": isRating,
      "isStarRating": isStarRating,
    };
  }
}

List<FestivalThemeModel> festivalThemeList() {
  return [
    FestivalThemeModel(
      themeKey: "2024-festival",
      themeName: "2024 기대작",
      year: "2024",
      month: "",
      location: "",
      genre: "",
      isDDay: true,
      isRating: false,
      isStarRating: false,
    ),
    FestivalThemeModel(
      themeKey: "2023-festival",
      themeName: "2023 평점 Top 10",
      year: "2023",
      month: "",
      location: "",
      genre: "",
      isDDay: false,
      isRating: false,
      isStarRating: true,
    ),
    FestivalThemeModel(
      themeKey: "2024-seoul-river",
      themeName: "한강공원 페스티벌 모아보기 ⛵",
      year: "2024",
      month: "",
      location: "한강",
      genre: "",
      isDDay: false,
      isRating: true,
      isStarRating: false,
    ),
    FestivalThemeModel(
      themeKey: "2024-incheon",
      themeName: "인천 페스티벌 모아보기 🌊",
      year: "2024",
      month: "",
      location: "인천",
      genre: "",
      isDDay: false,
      isRating: true,
      isStarRating: false,
    ),
    FestivalThemeModel(
      themeKey: "2024-busan",
      themeName: "부산 페스티벌 모아보기 🌊",
      year: "2024",
      month: "",
      location: "부산",
      genre: "",
      isDDay: false,
      isRating: true,
      isStarRating: false,
    ),
    FestivalThemeModel(
      themeKey: "2024-gangwon",
      themeName: "강원도 페스티벌 모아보기",
      year: "2024",
      month: "",
      location: "강원",
      genre: "",
      isDDay: false,
      isRating: true,
      isStarRating: false,
    ),
    FestivalThemeModel(
      themeKey: "2024-gyeonggi",
      themeName: "경기도 페스티벌 모아보기",
      year: "2024",
      month: "",
      location: "경기",
      genre: "",
      isDDay: false,
      isRating: true,
      isStarRating: false,
    ),
    FestivalThemeModel(
      themeKey: "2024-summer-rock",
      themeName: "한여름의 락 페스티벌 🎸",
      year: "2024",
      month: "6,3",
      location: "",
      genre: "rock",
      isDDay: false,
      isRating: false,
      isStarRating: true,
    ),
    FestivalThemeModel(
      themeKey: "2024-autumn-jazz",
      themeName: "가을의 재즈 페스티벌 🎺",
      year: "2024",
      month: "9,3",
      location: "",
      genre: "jazz",
      isDDay: false,
      isRating: false,
      isStarRating: true,
    ),
    FestivalThemeModel(
      themeKey: "2024-inside",
      themeName: "실내 페스티벌 모아보기 🎪",
      year: "2024",
      month: "",
      location: "실내",
      genre: "",
      isDDay: false,
      isRating: false,
      isStarRating: true,
    ),
    FestivalThemeModel(
      themeKey: "2024-global",
      themeName: "최고의 해외 라인업",
      year: "2024",
      month: "",
      location: "",
      genre: "global",
      isDDay: false,
      isRating: false,
      isStarRating: true,
    ),
  ];
}

// 실제 사용할 버전
List<FestivalThemeModel> festivalThemes(int start, int end) {
  List<FestivalThemeModel> festivalThemes = festivalThemeList();
  festivalThemes.shuffle(); // 랜덤 섞기
  return festivalThemes.sublist(start, end);
}

// 테스트용 버전
List<FestivalThemeModel> festivalThemesTest() {
  List<FestivalThemeModel> festivalThemes = festivalThemeList();
  List<FestivalThemeModel> festivalThemes2 = [];

  festivalThemes2.add(festivalThemes[0]);
  festivalThemes2.add(festivalThemes[1]);
  festivalThemes2.add(festivalThemes[2]);
  festivalThemes2.add(festivalThemes[3]);
  festivalThemes2.add(festivalThemes[7]);
  festivalThemes2.add(festivalThemes[9]);
  festivalThemes2.add(festivalThemes[10]);

  return festivalThemes2;
}
