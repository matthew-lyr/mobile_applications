import 'package:flutter/material.dart';
import 'JsonPage.dart';
import 'dragon_animation.dart';

void main() => runApp(MyApp());

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ListViews',
      theme: ThemeData(
          primarySwatch: primaryBlack,
          primaryColor: Color.fromARGB(255, 90, 18, 22)),
      home: FirstRoute(),
    );
  }
}

class FirstRoute extends StatelessWidget {
  final myController = TextEditingController(text: '花前月下');
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 90, 18, 22),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 250,
                height: 250,
                child: Image.asset('assets/logo.png'),
              )
            ],
          ),
          SizedBox(width: 40.0, height: 30.0, child: Text("")),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            SizedBox(width: 50.0, height: 30.0, child: Text("")),
            SizedBox(
              width: 25,
              height: 30,
              child: Image.asset('assets/bracket1.png'),
            ),
            SizedBox(
              width: 100.0,
              height: 60.0,
              child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                  controller: myController,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 90, 18, 22), width: 0.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 90, 18, 22)),
                    ),
                  )),
            ),
            SizedBox(
              width: 25,
              height: 30,
              child: Image.asset('assets/bracket2.png'),
            ),
            SizedBox(width: 10.0, height: 30.0, child: Text("")),


            Stack(
              children: <Widget>[
                Container(
                  width: 30,
                  height: 30,
                  child:AnimationPage()
                ),


                GestureDetector(
                    child:
                    SizedBox(width: 40.0, height: 40.0, child: Container(
                      width: 40,
                      height: 30,
                      color: Colors.transparent,
                    ),),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BodyLayout(
                                firstCharacter: myController.text == ''
                                    ? (commonFirstWord.toList()..shuffle()).first
                                    : myController.text
                                    .substring(myController.text.length - 1))),
                      );
                    }),
            ]),
          ])
        ],
      ),
    ));
  }
}

class BodyLayout extends StatefulWidget {
  final String firstCharacter;
  BodyLayout({Key key, this.firstCharacter}) : super(key: key);

  @override
  BodyLayoutState createState() {
    return new BodyLayoutState();
  }
}

class BodyLayoutState extends State<BodyLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
            width: 90,
            height: 30,
            child: Image.asset('assets/fanhuizhuye.png')),
      ),
      body: _myListView(),
    );
  }

  Map<String, dynamic> _allCharacters;
  Map<String, dynamic> selectedCharacters;
  Map<String, dynamic> potentialNewChengyuList;
  List<String> chengyuList = List();
  List<String> newChengyuList = List();
  String firstCharacter;
  String newFirstCharacter;

  @override
  void initState() {
    super.initState();
    loadChengyu().then((s) => setState(() {
          _allCharacters = s;
          firstCharacter = widget.firstCharacter;
          newFirstCharacter = widget.firstCharacter;
          selectedCharacters = _allCharacters[widget.firstCharacter];
          selectedCharacters.forEach((k, v) => chengyuList.add(k));
        }));
  }

  Widget _myListView() {
    double name_width = 30;
    double name_height = 60;
    double c_width = MediaQuery.of(context).size.width * 0.8;

    return ListView.builder(
      itemCount: chengyuList.length,
      itemBuilder: (context, index) {
        final item = chengyuList[index];
        return Card(
          child: ExpansionTile(
            trailing: IconButton(
              icon: Image.asset('assets/button_white.png'),
              onPressed: () {
                setState(() {
                  newFirstCharacter =
                      _allCharacters[firstCharacter][item]["last"];
                  newChengyuList = List();
                  potentialNewChengyuList = _allCharacters[newFirstCharacter];

                  if (potentialNewChengyuList != null) {
                    potentialNewChengyuList
                        .forEach((k, v) => newChengyuList.add(k));
                    selectedCharacters = _allCharacters[newFirstCharacter];
                    chengyuList = newChengyuList;
                    firstCharacter = newFirstCharacter;
                  } else {
                    showAlertDialog(context);
                  }
                });
              },
            ),
            title: Text("     【" + item + "】"),
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                          width: name_width,
                          height: name_height,
                          child: Image.asset('assets/duyin.png')),
                    ),
                    Container(
                        width: c_width,
                        padding: const EdgeInsets.all(16.0),
                        child: Text(selectedCharacters[item]["pinyin"])),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                          width: name_width,
                          height: name_height,
                          child: Image.asset('assets/chuchu.png')),
                    ),
                    Container(
                        width: c_width,
                        padding: const EdgeInsets.all(16.0),
                        child: Text(selectedCharacters[item]["source"])),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                          width: name_width,
                          height: name_height,
                          child: Image.asset('assets/jieshi.png')),
                    ),
                    Container(
                        width: c_width,
                        padding: const EdgeInsets.all(16.0),
                        child: Text(selectedCharacters[item]["meaning"])),
                  ]),
            ],
          ),
        );
      },
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("好的"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("抱歉，词库查无相关成语"),
    content: Text("请选择别的成语，或返回主页重新来过"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
