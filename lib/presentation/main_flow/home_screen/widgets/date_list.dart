import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:softorium_test/gen/fonts.gen.dart';

class DateList extends StatefulWidget {
  const DateList({
    super.key,
    required this.onTapDate,
  });

  final Function(DateTime value) onTapDate;

  @override
  State<DateList> createState() => _DateListState();
}

class _DateListState extends State<DateList> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<DateTime> _dateTimeNotifier =
      ValueNotifier(DateTime.now());

  void _generateDates() {
    final today = DateTime.now();
    for (int i = 0; i < 20; i++) {
      _dates.add(
        today.add(
          Duration(days: i),
        ),
      );
    }
  }

  final List<DateTime> _dates = [];

  @override
  void initState() {
    super.initState();
    _generateDates();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _dateTimeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
      ),
      height: 96,
      decoration: const BoxDecoration(
        color: Color(0xFFEDEBF9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: ListView.builder(
        itemCount: _dates.length,
        physics: const ClampingScrollPhysics(),
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final date = _dates[index];
          return ValueListenableBuilder(
              valueListenable: _dateTimeNotifier,
              builder: (context, dateTime, _) {
                final isCurrentDate =
                    dateTime.day == date.day && dateTime.month == date.month;
                return GestureDetector(
                  onTap: () {
                    _dateTimeNotifier.value = date;
                    widget.onTapDate.call(date);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6.0,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        // vertical: 16.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: isCurrentDate
                            ? const Color(0xFFBEB7EB)
                            : Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Gap(16),
                          Text(
                            date.day.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: FontFamily.nunito,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            DateFormat('E', 'Ru_ru').format(date),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: isCurrentDate
                                  ? Colors.white
                                  : const Color(0xFFAFABC6),
                              fontFamily: FontFamily.nunito,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
