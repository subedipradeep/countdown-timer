import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimerApp extends StatefulWidget {
  @override
  _CountdownTimerAppState createState() => _CountdownTimerAppState();
}

class _CountdownTimerAppState extends State<CountdownTimerApp> {
  Timer timer;
  var minute = 0;
  var seconds = 0;
  int totalTime;

  void startTimer() {
    final oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(oneSecond, (timer) {
      totalTime = minute * 60 + seconds;
      setState(() {
        if (totalTime <= 1)
          timer.cancel();
        else {
          if (seconds == 0) minute -= 1;
          totalTime -= 1;
          seconds = (totalTime % 60);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch: Colors.deepPurple),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purpleAccent,
          title: Text('Countdown Timer'),
        ),
        body: Center(
          child: Text(
            '$minute:$seconds',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                child: SimpleDialog(
                  contentPadding: EdgeInsets.all(15),
                  children: <Widget>[
                    Text('Set your time'),
                    DropdownButton(
                      value: minute,
                      icon: Text('Minute'),
                      items: List.generate(99, (index) {
                        return DropdownMenuItem(
                            value: index, child: Text(index.toString()));
                      }),
                      onChanged: (value) {
                        setState(() {
                          minute = value;
                        });
                      },
                    ),
                    DropdownButton(
                      value: seconds,
                      icon: Text('Seconds'),
                      items: List.generate(60, (index) {
                        return DropdownMenuItem(
                            value: index, child: Text(index.toString()));
                      }),
                      onChanged: (value) {
                        setState(() {
                          seconds = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    OutlineButton(
                        child: Text('Start'),
                        onPressed: () {
                          startTimer();
                          Navigator.of(context).pop();
                        })
                  ],
                ));
          },
          child: Icon(Icons.alarm_add),
        ),
      ),
    );
  }
}
