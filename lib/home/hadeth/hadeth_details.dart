import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_c6_sat/home/hadeth/hadeth_tab.dart';

class HadethDetails extends StatefulWidget {
  static const String routeName ="HadethDetails_Widget";
  String title='0';
  String word='';
  HadethDetails( this.title, this.word);
  @override
  State<HadethDetails> createState() => _HadethDetailsState(this.title,this.word);
}

class _HadethDetailsState extends State<HadethDetails> {
  List<Hadeth> hadethList = [];

  _HadethDetailsState(String title, String word);

  @override
  Widget build(BuildContext context) {
    // print(number2);
    // print(word2);
    // print(widget.number);
    // print(widget.number);
    // print(widget.word);
    if (hadethList.isEmpty) readHadethFile();
    return Container(decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/light_background.png'),
        )),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title, textDirection: TextDirection.rtl,),
          centerTitle: true,
        ),
        body: widget.word.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 48),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24)),
          child: Text(widget.word,textDirection: TextDirection.rtl),
              )
        ),
        );


  }

  void readHadethFile() async {
    List<Hadeth> hadethDataList = [];
    String content = await rootBundle.loadString('assets/files/ahadeth.txt');
    content = content.trim();
    List<String> ahadethContent = content.split("#");
    for (int i = 0; i < ahadethContent.length; i++) {
      String singleHadeth = ahadethContent[i].trim();
      List<String> lines = singleHadeth.split('\n');
      String title = lines[0];
      if (title.isEmpty) continue;
      lines.removeAt(0);
      String content = lines.join("\n");
      Hadeth h = Hadeth(title, content);
      hadethDataList.add(h);
      // print(h.title);
      // print('-----');
      // print(h.content);
      // print('+++++++++++++++++++++++++++++++');
    }
    hadethList = hadethDataList;
    setState(() {});
  }
}

class Hadeth {
  String title;
  String content;

  Hadeth(this.title, this.content);
}
