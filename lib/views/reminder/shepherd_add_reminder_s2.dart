// import 'package:alarm/alarm.dart';
// import 'package:alarm/model/alarm_settings.dart';
import 'package:camel_trace/Helpers/const.dart';
import 'package:camel_trace/modles/reminderModel.dart';
import 'package:camel_trace/modles/shepherd_reminder_model.dart';
import 'package:camel_trace/views/reminder/shepherd_add_reminder.dart';
import 'package:fast_color_picker/fast_color_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../Combonet/my_widget.dart';

class ShepherdAddReminders2 extends StatefulWidget {
  const ShepherdAddReminders2({super.key, required this.checkedGamels});
  final Map<String, CamelsChecked> checkedGamels;
  @override
  State<ShepherdAddReminders2> createState() => _ShepherdAddReminders2State();
}

class _ShepherdAddReminders2State extends State<ShepherdAddReminders2> {
  var ownerId = "";
  var titleController = TextEditingController();
  var noteController = TextEditingController();
  var dateController = TextEditingController();
  var categoryController = TextEditingController();
  String categoryDropDownText = 'select category';
  String categoryDropDownValue = "-1";
  DateTime? _selectedDate = DateTime.now();
  TimeOfDay? _selectedTime = TimeOfDay.now();
  Color _selectedColor = const Color(0xff232323);
  Map<String, String> category = {
    "cat1": "cat1",
    "cat2": "cat2",
    "cat3": "cat3"
  };
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        ownerId = value.getString("userId") ?? "";
      });
    });
    super.initState();
  }

  List<DropdownMenuEntry<dynamic>> categoryItemList() {
    var listItems = <DropdownMenuEntry<dynamic>>[];
    for (var i in category.entries) {
      listItems.add(DropdownMenuEntry(
        label: i.value,
        value: i.key,
      ));
    }
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    var w = MyWidgets(context: context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              w.addTitleTextView("Reminder"),
              const SizedBox(height: 30),
              w.regularEditText(titleController, "Title", icon: Icons.abc),
              const SizedBox(height: 18),
              w.regularEditText(noteController, "Note", icon: Icons.note),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: DropdownMenu(
                  width: MediaQuery.of(context).size.width - 50,
                  controller: categoryController,
                  enableFilter: false,
                  label: Text(categoryDropDownText),
                  onSelected: (newValue) {
                    if (newValue != null) {
                      categoryDropDownValue = newValue;
                    }
                  },
                  dropdownMenuEntries: categoryItemList(),
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: ListTile(
                  leading: const Icon(Icons.color_lens_rounded),
                  title: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: FastColorPicker(
                      selectedColor: _selectedColor,
                      onColorSelected: (color) {
                        setState(() {
                          _selectedColor = color;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: ListTile(
                  leading: const Icon(Icons.date_range),
                  title: Text(DateFormat("yyyy-MM-dd").format(_selectedDate!)),
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        initialDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        initialEntryMode: DatePickerEntryMode.calendarOnly);
                    if (date != null) {
                      setState(() {
                        _selectedDate = date;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: ListTile(
                  leading: const Icon(Icons.date_range),
                  title: Text(DateFormat('HH:mm').format(_selectedDate!)),
                  onTap: () async {
                    TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() {
                        _selectedTime = time;
                        _selectedDate = DateTime(
                            _selectedDate!.year,
                            _selectedDate!.month,
                            _selectedDate!.day,
                            _selectedTime!.hour,
                            _selectedTime!.minute);
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: () {
                  var id = const Uuid().v1();
                  var model = ShepherdReminderModel(
                      id: id,
                      title: titleController.text,
                      note: noteController.text,
                      color: _selectedColor.value,
                      dateTime: _selectedDate!.microsecondsSinceEpoch,
                      category: categoryDropDownValue,
                      shepherdId: ownerId);
                  FirebaseDatabase.instance
                      .ref()
                      .child("ShepherdReminders")
                      .child(ownerId)
                      .child(model.dateTime.toString())
                      .child(id)
                      .set(model.toJson())
                      .then((value) {
                    w.showAlertDialog(context, "reminder added Successfully",
                        () {
                      // final alarmSettings = AlarmSettings(
                      //   id: 42,
                      //   dateTime: _selectedDate!,
                      //   assetAudioPath: 'assets/alarm.mp3',
                      //   loopAudio: true,
                      //   vibrate: true,
                      //   volume: 0.8,
                      //   fadeDuration: 3.0,
                      //   notificationTitle: titleController.text,
                      //   notificationBody: noteController.text,
                      //   enableNotificationOnKill: true,
                      // );
                      // Alarm.set(alarmSettings: alarmSettings).then((value) {
                      //   Navigator.of(context).pop();
                      // }).onError((error, stackTrace) {
                      //   ////////////////// need action
                      // });
                    });
                  }).onError((error, stackTrace) {
                    w.showAlertDialog(context, error.toString(), () {
                      Navigator.of(context).pop();
                    });
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightOrangeColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: Text(Cons.save),
              )
            ],
          ),
        ),
      ),
    );
  }
}
