import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator',
    home: SIForm(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _currencies = ['Naira', 'Dollar', 'Pounds', 'Euro'];
  final _minPadding = 5.0;
  var _currentItemSelected = 'Dollar';

  var _formKey = GlobalKey<FormState>();

  TextEditingController principalControlled = TextEditingController();
  TextEditingController roiControlled = TextEditingController();
  TextEditingController termControlled = TextEditingController();

  var displayText = '';

  @override
  Widget build(BuildContext context) {
    TextStyle tstyle = Theme.of(context).textTheme.title;
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Simple Interest Calculator'),
        ),
        body: Form(
            key: _formKey,
            child: Padding(
                padding: EdgeInsets.all(_minPadding * 2),
                child: ListView(
                  children: <Widget>[
                    getImageAsset(),
                    Padding(
                        padding: EdgeInsets.only(
                            top: _minPadding, bottom: _minPadding),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: tstyle,
                          controller: principalControlled,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter Principal Amount';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Principal',
                              hintText: 'Enter Principal e.g 12000',
                              labelStyle: tstyle,
                              errorStyle: TextStyle(
                                  color: Colors.yellowAccent, fontSize: 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                            top: _minPadding, bottom: _minPadding),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: tstyle,
                          controller: roiControlled,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter the Rate';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Rate of Interest',
                              hintText: 'In percent',
                              labelStyle: tstyle,
                              errorStyle: TextStyle(
                                  color: Colors.yellowAccent, fontSize: 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          top: _minPadding, bottom: _minPadding),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: tstyle,
                            controller: termControlled,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Enter Term';
                              }
                            },
                            decoration: InputDecoration(
                                labelText: 'Term',
                                hintText: 'In Years',
                                labelStyle: tstyle,
                                errorStyle: TextStyle(
                                    color: Colors.yellowAccent, fontSize: 15.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          )),
                          Container(
                            width: _minPadding,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              items:
                                  _currencies.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              value: _currentItemSelected,
                              onChanged: (String newValueSelected) {
                                _dropDownItemSelected(newValueSelected);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: _minPadding, bottom: _minPadding),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              color: Theme.of(context).accentColor,
                              textColor: Theme.of(context).primaryColorDark,
                              child: Text(
                                'Calculate',
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState.validate()) {
                                    this.displayText = _calculateSI();
                                  }
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RaisedButton(
                              color: Theme.of(context).primaryColorDark,
                              textColor: Theme.of(context).primaryColorLight,
                              child: Text(
                                'Reset',
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  _reset();
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(_minPadding * 2),
                      child: Text(
                        displayText,
                        style: tstyle,
                      ),
                    )
                  ],
                ))));
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image im = Image(
      image: assetImage,
      height: 125.0,
      width: 125.0,
    );

    return Container(
      child: im,
      margin: EdgeInsets.all(_minPadding * 10),
    );
  }

  void _dropDownItemSelected(String a) {
      setState(() {
      this._currentItemSelected = a;
    });
  }

  String _calculateSI() {
    double principal = double.parse(principalControlled.text);
    double term = double.parse(termControlled.text);
    double roi = double.parse(roiControlled.text);

    double totalamountPaid =
        principal + ((principal * roi * term) / (100 * 365));

    String result =
        'After $term years. Your investment will worth $totalamountPaid $_currentItemSelected';
    return result;
  }

  void _reset() {
    principalControlled.text = '';
    roiControlled.text = '';
    termControlled.text = '';
    displayText = '';
    _currentItemSelected = _currencies[0];
  }
}
