class FestivalThemeModel {
  final String themeName;
  // 필터링 값
  final String year; // 일시(년)
  final String month; // 일시(월)
  final String location; // 지역
  // 필터링 사용 여부
  final bool isDDay; // D-Day
  final bool isRating; // 순위
  final bool isStarRating; // 별점

  FestivalThemeModel({
    required this.year,
    required this.month,
    required this.location,
    required this.themeName,
    required this.isDDay,
    required this.isRating,
    required this.isStarRating,
  });
}

List<FestivalThemeModel> festivalThemes(int start, int end) {
  List<FestivalThemeModel> festivalThemes = [
    FestivalThemeModel(
      themeName: "2024 기대작",
      year: "2024",
      month: "",
      location: "",
      isDDay: true,
      isRating: false,
      isStarRating: false,
    ),
    FestivalThemeModel(
      themeName: "2024 평점 Top 10",
      year: "",
      month: "",
      location: "",
      isDDay: false,
      isRating: false,
      isStarRating: false,
    ),
    FestivalThemeModel(
      themeName: "한강공원 페스티벌 모아보기 ⛵",
      year: "",
      month: "",
      location: "서울 난지한강공원",
      isDDay: false,
      isRating: false,
      isStarRating: false,
    ),
    FestivalThemeModel(
      themeName: "인천 페스티벌 모아보기 🌊",
      year: "",
      month: "",
      location: "인천 송도 달빛축제공원",
      isDDay: false,
      isRating: false,
      isStarRating: false,
    ),
    FestivalThemeModel(
      themeName: "부산 페스티벌 모아보기 🌊",
      year: "",
      month: "",
      location: "",
      isDDay: false,
      isRating: false,
      isStarRating: false,
    ),
    FestivalThemeModel(
      themeName: "강원도 페스티벌 모아보기",
      year: "",
      month: "",
      location: "",
      isDDay: false,
      isRating: false,
      isStarRating: false,
    ),
    FestivalThemeModel(
      themeName: "한여름의 락 페스티벌 🎸",
      year: "",
      month: "",
      location: "",
      isDDay: false,
      isRating: true,
      isStarRating: false,
    ),
    FestivalThemeModel(
      themeName: "가을의 재즈 페스티벌 🎺",
      year: "",
      month: "",
      location: "",
      isDDay: false,
      isRating: false,
      isStarRating: false,
    ),
    FestivalThemeModel(
      themeName: "실내 페스티벌 모아보기 🎪",
      year: "",
      month: "",
      location: "",
      isDDay: false,
      isRating: false,
      isStarRating: false,
    ),
    FestivalThemeModel(
      themeName: "최고의 해외 라인업",
      year: "",
      month: "",
      location: "",
      isDDay: false,
      isRating: false,
      isStarRating: false,
    ),
  ];

  festivalThemes.shuffle(); // 랜덤 섞기
  return festivalThemes.sublist(start, end);
}
