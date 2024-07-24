import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/features/festival/view_models/festival_vm.dart';

class TimeTableScreen extends ConsumerStatefulWidget {
  static const routeURL = Routes.timeTableScreen;
  static const routeName = RoutesName.timeTableScreen;

  const TimeTableScreen({super.key});

  @override
  TimeTableScreenState createState() => TimeTableScreenState();
}

class TimeTableScreenState extends ConsumerState<TimeTableScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initTimeTable();
    });
  }

  void _initTimeTable() async {
    await ref.read(festivalProvider.notifier).getTimeTables("1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ref.watch(festivalProvider).when(
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
              ),
            ),
            data: (FestivalModel festival) {
              return SafeArea(
                child: DefaultTabController(
                  length: 2,
                  child: Container(
                    color: Colors.amber,
                    child: Column(
                      children: [
                        for (var item in festival.timeTables) Text(item.artist),
                        Text(festival.startDate),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }
}
