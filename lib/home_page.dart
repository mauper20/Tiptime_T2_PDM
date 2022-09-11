import 'package:flutter/material.dart';
import 'dart:ffi';

class home_page extends StatefulWidget {
  home_page({
    Key? key,
  }) : super(key: key);
  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  var costofserviceController = TextEditingController();
  var radioGroup = {
    1: '''Amazing 20%''',
    2: '''good    18%''',
    3: '''Okay    15%''',
  };

  int? tipPercentSelected;
  double tipCalculated = 0;
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip time'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(height: 14),
            ListTile(
              leading: Icon(
                Icons.store,
                color: Colors.green,
                size: 35,
              ),
              title: Padding(
                padding: EdgeInsets.only(right: 24),
                child: TextField(
                  controller: costofserviceController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'Cost of service',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.room_service,
                size: 35,
              ),
              title: Text("How was the service?"),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(children: [
                radiocreate(20, 1),
                radiocreate(18, 2),
                radiocreate(15, 3)
              ]),
            ),
            ListTile(
              leading: Icon(
                Icons.credit_card,
                size: 35,
              ),
              title: Text("Round up tip"),
              trailing: Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
            ),
            MaterialButton(
              color: Colors.green,
              child: Text(
                "CALCULATE",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _tipCalculation(isSwitched);
                setState(() {});
              },
            ),
            myprintText(tipCalculated.toStringAsFixed(2)),
          ],
        ),
      ),
    );
  }

  Text myprintText(String s) {
    return Text(
      "Tip amount: $s",
      textAlign: TextAlign.end,
    );
  }

  ListTile radiocreate(int vaLTip, int textKeymap) {
    return ListTile(
      leading: Radio(
          value: vaLTip,
          groupValue: tipPercentSelected,
          onChanged: (int? value) {
            tipPercentSelected = value;
            setState(() {});
          }),
      title: Text("${radioGroup[textKeymap]}"),
    );
  }

  void _tipCalculation(bool roundedTipSwitch) {
    if (costofserviceController.text.isNotEmpty) {
      if (!roundedTipSwitch) {
        double costService = double.parse(costofserviceController.text);
        tipCalculated = ((tipPercentSelected ?? 0) / 100) * (costService);
      } else {
        double costService = double.parse(costofserviceController.text);
        tipCalculated =
            (((tipPercentSelected ?? 0) / 100) * (costService)).roundToDouble();
      }
    } else {
      _dialogo(context);
    }
  }

  void _dialogo(BuildContext context) {
    showDialog(
      context: context,
      builder: ((BuildContext context) {
        return AlertDialog(
          content: Text(
              "No ha introducido valores, porfavor ingrese y vuelva a intenar"),
          title: const Text("Advertencia:"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("ok"),
            )
          ],
        );
      }),
    );
  }
}
