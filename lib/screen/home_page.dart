import 'dart:async';

import 'package:age/age.dart';
import 'package:age_calculator/services/age_calculation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TimeOfDay _curentTime = TimeOfDay.now();
  DateTime todayDate = DateTime.now();
  DateTime dob = DateTime(2000, 8, 19);
  AgeDuration _ageDuration;
  AgeDuration _nextBirthday;
  int _nextbdayWeekDay;
  int counter = 0;
  var min;

  List<String> _months = [
    "months",
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  List<String> _weeks = [
    "Weeks",
    "MONDAY",
    "TUESDAY",
    "WEDNESDAY",
    "THURSDAY",
    "FRIDAY",
    "SATURDAY",
    "SUNDAY"
  ];

  Future<Null> _selectTodayDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: todayDate,
      firstDate: dob,
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != todayDate) {
      setState(() {
        todayDate = picked;
        _ageDuration = AgeCalculation().calculateAge(todayDate, dob);
        _nextBirthday = AgeCalculation().nextBirthday(todayDate, dob);
        _nextbdayWeekDay = AgeCalculation().nextday(todayDate, dob);
        _curentTime = TimeOfDay.now();
      });
    }
  }

  Future<Null> _selectDOBDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: dob,
      firstDate: DateTime(1900),
      lastDate: todayDate,
    );
    if (picked != null && picked != todayDate) {
      setState(() {
        dob = picked;
        _ageDuration = AgeCalculation().calculateAge(todayDate, dob);
        _nextBirthday = AgeCalculation().nextBirthday(todayDate, dob);
        _nextbdayWeekDay = AgeCalculation().nextday(todayDate, dob);
        _curentTime = TimeOfDay.now();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _ageDuration = AgeCalculation().calculateAge(todayDate, dob);
    _nextBirthday = AgeCalculation().nextBirthday(todayDate, dob);
    _nextbdayWeekDay = AgeCalculation().nextday(todayDate, dob);

    min = _curentTime.minute;

    new Timer.periodic(
        Duration(seconds: 1),
            (Timer t) => setState(() {
          if(_curentTime.minute == min){
            counter = counter + 1;
          }else{
            counter = 1;
            min = _curentTime.minute;
          }
          _curentTime = TimeOfDay.now();
        }));
  }

  @override
  Widget build(BuildContext context) {

    var year = _ageDuration.years;
    var month = ((_ageDuration.years) * 12) + (_ageDuration.months);
    var week = (todayDate.difference(dob).inDays / 7).floor();
    var day = (todayDate.difference(dob).inDays);
    var hours = (todayDate.difference(dob).inHours) + _curentTime.hour;
    var minutes = hours * 60 + (_curentTime.minute);
    var second = minutes * 60 + counter;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
                width: double.maxFinite,
              ),
              Text(
                "AGE CALCULATOR",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${todayDate.day} ${_months[todayDate.month]} ${todayDate.year}",
                          style: TextStyle(
                            color: Color(0xffCDDC39),
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _selectTodayDate(context);
                          },
                          child: Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Date of Birth",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${dob.day} ${_months[dob.month]} ${dob.year}",
                          style: TextStyle(
                            color: Color(0xffCDDC39),
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _selectDOBDate(context);
                          },
                          child: Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 40),
                // height: 400,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Color(0xff333333),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 200,
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "AGE",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${_ageDuration.years}",
                                    style: TextStyle(
                                      color: Color(0xffCDDC39),
                                      fontSize: 50,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 13),
                                    child: Text(
                                      "YEARS",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${_ageDuration.months} months | ${_ageDuration.days} days",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 170,
                          width: 1,
                          color: Color(0xff999999),
                        ),
                        Container(
                          height: 200,
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "NEXT BIRTHDAY",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Icon(
                                Icons.cake,
                                color: Color(0xffCDDC39),
                                size: 50,
                              ),
                              Text(
                                "${_weeks[_nextbdayWeekDay]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "${_nextBirthday.months} months | ${_nextBirthday.days} days",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 2,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      color: Color(0xff999999),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "SUMMARY",
                      style: TextStyle(
                          color: Color(0xffCDDC39),
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "YEARS",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                  Text(
                                    year.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Column(
                                children: [
                                  Text(
                                    "DAYS",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                  Text(
                                    day.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: 35),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "MONTHS",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                  Text(
                                    month.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Column(
                                children: [
                                  Text(
                                    "HOURS",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                  Text(
                                    hours.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: 0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "WEEKS",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                  Text(
                                    week.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Column(
                                children: [
                                  Text(
                                    "MINUTES",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                  Text(
                                    minutes.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "SECONDS",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                              Text(
                                second.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
