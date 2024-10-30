import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'category_widget.dart';

void main() {
  runApp(const AyBayHishab());
}

class AyBayHishab extends StatelessWidget {
  const AyBayHishab({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepPurple,width: 3),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepPurple,width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
        )
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final ayTEController = TextEditingController();
  final bayTEController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  List<AyBayModel> ayBayList = [];

  DateTime time = DateTime.now();

  int CalculateAySum (List<AyBayModel> ayBayList) {
    int aySum = 0;
    for(AyBayModel A in ayBayList) {
      aySum += int.parse(A.ay);
      setState(() {});
    }
    return aySum;
  }

  int CalculateBaySum (List<AyBayModel> ayBayList) {
    int baySum = 0;
    for(AyBayModel A in ayBayList) {
      baySum += int.parse(A.bay);
      setState(() {});
    }
    return baySum;
  }

  @override
  Widget build(BuildContext context) {

    int aySumresult = CalculateAySum(ayBayList);
    int baySumresult = CalculateBaySum(ayBayList);


    return Scaffold(
      appBar: AppBar(
        title: const Text("AyBay Hishab"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade100,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Form(
                key: formkey,
                child: Row(
                  children: [
                    Expanded(child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: ayTEController,
                      decoration: const InputDecoration(
                        labelText: "Ay",
                        isDense: true,
                      ),
                    )),
                    const SizedBox(width: 8,),
                    Expanded(child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: bayTEController,
                      decoration: const InputDecoration(
                        labelText: "Bay",
                        isDense: true,
                      ),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: (){
                        ayBayList.add(AyBayModel(ay: ayTEController.text.trim(), bay: bayTEController.text.trim(), date: DateFormat("yMd").format(time)));
                        ayTEController.clear();
                        bayTEController.clear();
                        setState(() {});
                      }, child: const Text("Add"))),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CategoryWidget(title: 'Ay', color: Colors.green,),
                  CategoryWidget(title: 'date', color: Colors.blue,),
                  CategoryWidget(title: 'bay', color: Colors.pink,),
                  CategoryWidget(title: 'more', color: Colors.brown,),
                ],
              ),
              const SizedBox(height: 10),
              Card(
                color: Colors.deepPurple.shade200,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: ayBayList.length,
                    itemBuilder: (context,index) {
                      return SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                          child: Row(
                            children: [
                              const SizedBox(width: 4,),
                              SizedBox(
                                  width: 70,
                                  child: Text(ayBayList[index].ay,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w700),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                              const SizedBox(width: 16,),
                              SizedBox(
                                  height: 30,
                                  width: 100,
                                  child: Card(
                                      margin: EdgeInsets.zero,
                                      child: Center(child: Text(ayBayList[index].date)))),
                              const SizedBox(width: 10,),
                              SizedBox(
                                  width: 70,
                                  child: Text(ayBayList[index].bay,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w700),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                              const SizedBox(width: 10,),
                              const Spacer(),
                              InkWell(
                                  onTap: (){
                                    ayBayList.remove(ayBayList[index]);
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.delete)),
                              const SizedBox(width: 10,),
                            ],
                          ),
                        ),
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(onPressed: (){}, label: Text("Ay : $aySumresult")),
          const SizedBox(width: 8,),
          FloatingActionButton.extended(onPressed: (){}, label: Text("Bay : $baySumresult")),
          const SizedBox(width: 8,),
          FloatingActionButton.extended(onPressed: (){}, label: Text("Left : ${aySumresult-baySumresult}")),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class AyBayModel {
  final String ay, bay, date;

  AyBayModel({required this.date, required this.ay, required this.bay});
}