import 'package:flutter/material.dart';
import 'package:movedor/components/rounded_icon_btn.dart';
import 'package:movedor/constants.dart';
import 'package:movedor/controllers/main_controller.dart';
import 'package:movedor/screens/book/book_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Size mediaSize;
  MainController controller = MainController();
  String aux;

  @override
  void initState() {
    super.initState();
    controller.actualDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: 
        RoundedIconBtn(
          iconData: Icon(Icons.arrow_back_ios, size: 18, color: Colors.black87),
          press: () => Navigator.pushNamed(context, BookScreen.routeName)
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: TableCalendar(
                locale: "pt_BR",
                firstDay: DateTime.now(),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: controller.actualDay,
                calendarFormat: CalendarFormat.month,
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Mês',
                  CalendarFormat.week: 'Mês',
                },
                onDaySelected: (data, date) {
                  setState(() {
                    controller.changeActualDay(date);
                  });
                },
                daysOfWeekHeight: 30,
              ),
            ),
            Container(
              width: mediaSize.width * 0.9,
              child: Divider(
                color: Color(0xff36a9b0),
              ),
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  child: Text(
                    'Atividade realizada?',
                    style: TextStyle(
                      fontFamily: 'MontserratRegular',
                      fontSize: mediaSize.width * 0.05,
                    ),
                  ),
                ),
                Wrap(
                  children: [
                    componentForms(context, 'Sim', true),
                    componentForms(context, 'Não', true),
                  ],
                ),
              ],
            ),
            Container(
              width: mediaSize.width * 0.9,
              child: Divider(
                color: Color(0xff36a9b0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget componentForms(BuildContext context, String label, bool value) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(left: 20),
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.blue[200]),
                borderRadius: BorderRadius.circular(5),
              ),
              child: aux == label
                  ? Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffa9d6c2), Color(0xff36a9b0)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ))
                  : Container(
                      height: 25,
                      width: 25,
                    ),
            ),
            onTap: () {
              setState(() {
                aux = label;
                controller.doneActivity = value;
              });
            },
          ),
          Container(
            margin: EdgeInsets.only(
              left: mediaSize.width * 0.03,
            ),
            child: Text(label,
                style: TextStyle(
                  fontSize: mediaSize.width * 0.03,
                  color: kTextColor,
                )),
          )
        ],
      ),
    );
  }
}