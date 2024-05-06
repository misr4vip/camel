import 'package:camel_trace/Helpers/drawer_Widets.dart';
import 'package:camel_trace/modles/reminderModel.dart';
import 'package:camel_trace/views/reminder/add_reminder.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class Reminders extends StatefulWidget {
  const Reminders({super.key});

  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  Map<DateTime, List<Event>> _events = {};
  DateTime _currentDate = DateTime.now();
  List<ReminderModel> remindersList = [];
  List<ReminderModel> _tempList = [];
  var ownerId = "";
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        ownerId = value.getString("userId") ?? "";
      });
    });
    getReminders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Helper(),
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const AddReminder();
          }));
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CalendarCarousel<Event>(
              onDayPressed: (DateTime date, List<Event> events) {
                List<ReminderModel> remindersListTemp = [];

                for (var e in remindersList) {
                  var pdate = DateTime.fromMicrosecondsSinceEpoch(e.dateTime);

                  if (pdate.day == date.day && pdate.month == date.month) {
                    remindersListTemp.add(e);
                  }
                }
                setState(() {
                  _currentDate = date;
                  _tempList = remindersListTemp;
                });
              },
              weekendTextStyle: const TextStyle(
                color: Colors.red,
              ),
              thisMonthDayBorderColor: Colors.grey,
              customDayBuilder: (
                /// you can provide your own build function to make custom day containers
                bool isSelectable,
                int index,
                bool isSelectedDay,
                bool isToday,
                bool isPrevMonthDay,
                TextStyle textStyle,
                bool isNextMonthDay,
                bool isThisMonthDay,
                DateTime day,
              ) {
                for (var date in _events.keys) {
                  if (date.day == day.day && date.month == day.month) {
                    return Container(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        child: Text(day.day.toString()),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  } else {
                    return null;
                  }
                }
                return null;
              },

              weekFormat: false,
              markedDatesMap: EventList(events: _events),
              height: 420.0,
              selectedDateTime: _currentDate,
              daysHaveCircularBorder: false,

              /// null for not rendering any border, true for circular border, false for rectangular border
            ),
          ),
          _tempList.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                      itemCount: _tempList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Color(_tempList[index].color),
                              ),
                              title: Text(_tempList[index].title),
                              shape: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(39, 81, 86, 90),
                                    width: 2),
                              ),
                            ));
                      }),
                )
              : Container(
                  margin: const EdgeInsets.all(16),
                  child: const Text(
                    "No events",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  )),
        ],
      ),
    );
  }

  Future getReminders() async {
    Map<DateTime, List<Event>> events = {};
    List<ReminderModel> models = [];
    await FirebaseDatabase.instance
        .ref()
        .child("reminders")
        .child(ownerId)
        .get()
        .then((value) {
      if (value.exists) {
        for (var element in value.children) {
          for (var item in element.children) {
            var key = DateTime.fromMicrosecondsSinceEpoch(int.parse(item.key!));

            List<Event> e = [];
            for (var x in item.children) {
              var model = ReminderModel.fromJson(x.value as Map);
              print("model title is : ${model.title}");
              e.add(Event(
                date: DateTime.fromMicrosecondsSinceEpoch(model.dateTime),
                title: model.title,
                description: model.note,
              ));
              models.add(model);
            }
            events[key] = e;
          }
        }
      }
      setState(() {
        _events = events;
        remindersList = models;
      });
    });
  }
}
