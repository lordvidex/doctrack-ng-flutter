import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:final_year/utils/constants/colors.dart';
import 'package:final_year/utils/widgets/custom_appbar.dart';
import 'package:final_year/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/document.dart';

class StepsEventScreen extends StatelessWidget {
  final List<DocumentEvent> events;
  const StepsEventScreen({
    super.key,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBAr(text: 'Step Events'),
        body: events.isEmpty
            ? Center(child: boldText(text: 'No events on this application'))
            : ListView.builder(
                itemCount: events.length,
                itemBuilder: (ctx, i) {
                  return EventWidget(event: events[i]);
                }));
  }
}

class EventWidget extends StatelessWidget {
  final DocumentEvent event;
  const EventWidget({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (event.type == 'TYPE_COMMENT') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(format(event.createdAt),
                style:
                    const TextStyle(color: Color.fromARGB(255, 172, 171, 171))),
            Row(children: [
              const CircleAvatar(
                  backgroundColor: AppColors.mainColor,
                  child: Text('ADMIN', style: TextStyle(fontSize: 6))),
              BubbleSpecialThree(
                  text: event.message ?? 'Empty message',
                  color: event.actor == 'ACTOR_USER'
                      ? AppColors.mainColor
                      : const Color(0xFFE8E8EE),
                  tail: true,
                  isSender: event.actor == 'ACTOR_USER')
            ]),
          ],
        ),
      );
    } else if (event.type == 'TYPE_APPROVAL') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: AppColors.mainColor),
            const SizedBox(width: 8),
            const Text('This step has been approved. - '),
            Text(format(event.createdAt),
                style:
                    const TextStyle(color: Color.fromARGB(255, 172, 171, 171))),
          ],
        ),
      );
    } else if (event.type == 'TYPE_SUBMISSION') {
      // small message with submission and ... icon
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.more_horiz_rounded, color: AppColors.mainColor),
          const SizedBox(width: 8),
          const Text('You made submissions. -'),
          Text(format(event.createdAt),
              style:
                  const TextStyle(color: Color.fromARGB(255, 172, 171, 171))),
        ],
      );
    }
    return Container();
  }

  String format(DateTime d) {
    return DateFormat.yMd().add_jm().format(d);
  }
}
