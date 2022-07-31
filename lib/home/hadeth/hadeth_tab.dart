import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_c6_sat/home/hadeth/hadeth_details.dart';
import 'package:islami_c6_sat/my_theme.dart';

class HadethTab extends StatefulWidget {
  @override
  State<HadethTab> createState() => _HadethTabState();
}

class _HadethTabState extends State<HadethTab> {
  List<Hadeth> hadethList = [];
  List<String> hadethContent =[];
  List<String> hadethTitle =[];

  List<Hadeth> test=[];
  @override
  Widget build(BuildContext context) {
    if (hadethList.isEmpty) readHadethFile();
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center,

        children: [Text("Ahadieth", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),)],),
        Expanded(
          child: hadethList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HadethDetails(test[index].title,test[index].content)),
                        //arguments:
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                          alignment: Alignment.center,
                          child: Text(hadethList[index].title)),
                    );
                  },
                  itemCount: hadethList.length,
            separatorBuilder: (_, index){
                    return Container(
                      color: MyTheme.primaryColor,
                      width: double.infinity,
                      height: 2,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                    );
            },
                ),
        )
      ],
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
      test.add(Hadeth(h.title, h.content));
      // hadethContent.add(h.content);
      // hadethTitle.add(h.title);
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
