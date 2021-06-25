import 'dart:math';
import 'package:flutter/material.dart';
import 'package:movedor/components/rounded_icon_btn.dart';
import 'package:movedor/constants.dart';
import 'package:movedor/controllers/main_controller.dart';
import 'package:movedor/screens/book/book_screen.dart';
import 'package:movedor/screens/diary/components/custom_elevated_button.dart';
import 'package:movedor/screens/diary/components/dialog_borg.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  MainController controller = MainController();
  Size mediaSize;
  String aux;
  List<String> motivationalList = [
    'Não desanime! Enfrente cada dia e uma meta por vez!',
    "Sem problema! Mantenha o foco e não desanime!",
    "Não esqueça: uma rotina de exercícios pode nos ajudar a lidar melhor com a dor!",
    "O seu maior aliado nesse momento é a atividade física, não desista!",
    "Organize a sua rotina para o exercício faça parte dela!",
    "O mais importante nos exercícios físicos é praticar sempre!",
    "Você é o seu melhor aliado! Não desista!",
    "O repouso não vai melhor a sua dor. Viver em movimento sim!",
    "Inicie por atividades simples e progrida aos poucos, até ganhar mais confiança!",
    "Não desista! Você é capaz!",
    "O melhor exercício é aquele que você gosta!",
    "Hoje não deu, mas amanhã esperamos você para se exercitar!",
    "Você não está sozinho! Conte conosco para continuar!",
    "Caso você tenha feito algum tipo de exercício que não o ajudou, não significa que o exercício não funciona pra você! Tente outro tipo de exercício.",
    "Você não precisa começar pelo movimento mais desafiador! Você precisa fazer!",
    "Um passo de cada vez! Não desista!",
    "Dedique um tempo para cuidar da sua saúde!",
    "O melhor investimento para a sua vida é cuidar de si mesmo!",
    "Não desista, você pode mais!",
    "A persistência é o melhor caminho para o êxito!",
    "O exercício cura!",
    "Valorize as suas pequenas vitórias!",
    "Não desanime! O exercício físico é o melhor aliado para quem tem dor lombar!",
    "Cada dia é uma nova chance de realizar os seus objetivos! Não desista!",
    "Não deixe que a sua dor lhe defina!",
    "Estamos aqui dando suporte para você continuar!",
    "O exercício físico é importante para a sua saúde, não deixe de realiza-lo!"
  ];

  @override
  void initState() {
    super.initState();
    controller.actualDay = DateTime.now();
  }

  void _showBorgDialog() async {
    final selectedSliderValue = await showDialog<double>(
      context: context,
      builder: (context) =>
          DialogBorg(initialSliderValue: controller.valueBorg),
    );

    if (selectedSliderValue != null) {
      setState(() {
        controller.changeValueBorg(selectedSliderValue);
      });
    }
  }

  void _chooseAnswerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 25),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
          title: Text(
            'Marque a alternativa que corresponde ao motivo pelo qual você não realizou a atividade:'
                .toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'MontserratRegular',
              color: Color(0xff36a9b0),
              fontSize: mediaSize.width * 0.05,
            ),
          ),
          content: Wrap(
            runSpacing: 20.0,
            children: [
              CustomElevatedButton(
                mediaSize: mediaSize,
                text: 'Não tive tempo',
                onPressed: () {
                  Navigator.of(context).pop();
                  _motivationalDialog();
                },
              ),
              CustomElevatedButton(
                mediaSize: mediaSize,
                text: 'Não me senti motivado',
                onPressed: () {
                  Navigator.of(context).pop();
                  _motivationalDialog();
                },
              ),
              CustomElevatedButton(
                mediaSize: mediaSize,
                text: 'Minha dor aumentou após o último exercício',
                onPressed: () {
                  Navigator.of(context).pop();
                  _motivationalDialog();
                },
              ),
              CustomElevatedButton(
                mediaSize: mediaSize,
                text: 'Estava com dor no momento da realização',
                onPressed: () {
                  Navigator.of(context).pop();
                  _motivationalDialog();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _motivationalDialog() {
    var rng = new Random();
    String frase = motivationalList[rng.nextInt(26)];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 25),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
          title: Text(
            'Não desista!'.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'MontserratRegular',
              color: Color(0xff36a9b0),
              fontSize: mediaSize.width * 0.05,
            ),
          ),
          content: Wrap(
            children: [
              Text(
                frase,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: RoundedIconBtn(
            iconData:
                Icon(Icons.arrow_back_ios, size: 18, color: Colors.black87),
            press: () => Navigator.pushNamed(context, BookScreen.routeName)),
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
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(controller.selectedDay, selectedDay)) {
                    setState(() {
                      controller.changeSelectedDay(selectedDay);
                      controller.changeActualDay(focusedDay);
                    });
                  }
                },
                daysOfWeekHeight: 30,
                selectedDayPredicate: (day) {
                  // Use `selectedDayPredicate` to determine which day is currently selected.
                  // If this returns true, then `day` will be marked as selected.

                  // Using `isSameDay` is recommended to disregard
                  // the time-part of compared DateTime objects.
                  return isSameDay(controller.selectedDay, day);
                },
              ),
            ),
            Container(
              width: mediaSize.width * 0.9,
              child: Divider(
                color: Color(0xff36a9b0),
              ),
            ),
            activityFrame(context, "Exercícios aeróbicos"),
            Container(
              width: mediaSize.width * 0.9,
              child: Divider(
                color: Color(0xff36a9b0),
              ),
            ),
            activityFrame(context, "Exercícios de relaxamento"),
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

  Widget activityFrame(BuildContext context, String activity) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20),
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Container(
              width: 80,
              height: 80,
              child: Image.asset(
                activity == "Exercícios aeróbicos"
                    ? "assets/icons_borg/ÍconePrancheta1.png"
                    : activity == "Exercícios de fortalecimento"
                        ? "assets/icons_borg/ÍconePrancheta2.png"
                        : activity == "Exercícios de relaxamento"
                            ? "assets/icons_borg/ÍconePrancheta3.png"
                            : activity == "Exercícios na água"
                                ? "assets/icons_borg/ÍconePrancheta4.png"
                                : activity == "Ioga e thai chi chuan"
                                    ? "assets/icons_borg/ÍconePrancheta5.png"
                                    : "assets/icons_borg/ÍconePrancheta6.png",
              )),
        ),
        Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                activity,
                style: TextStyle(
                  fontFamily: 'MontserratRegular',
                  fontSize: mediaSize.width * 0.04,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(children: [
                    Text(
                      'Horário',
                      style: TextStyle(
                        fontFamily: 'MontserratRegular',
                        fontSize: mediaSize.width * 0.03,
                      ),
                    ),
                    Text('  '),
                    Text(
                      'Tipo',
                      style: TextStyle(
                        fontFamily: 'MontserratRegular',
                        fontSize: mediaSize.width * 0.03,
                      ),
                    ),
                  ]))
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 20),
          child: Column(
            children: [
              IconButton(
                iconSize: 32,
                icon: Icon(
                  Icons.done,
                  color: Colors.green,
                ),
                onPressed: () {
                  _showBorgDialog();
                },
              ),
              IconButton(
                iconSize: 32,
                icon: Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 32,
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
                onPressed: () {
                  _chooseAnswerDialog();
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
