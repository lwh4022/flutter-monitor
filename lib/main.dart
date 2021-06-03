import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final controller = Get.put(ScrapingResultController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Infotech'),
        ),
        body: ChannelWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.updateResult();
            controller.inJsonNode.unfocus();
            controller.outJsonNode.unfocus();
          },
          child: Icon(Icons.done),
        ),
      ),
    );
  }
}

class ChannelWidget extends StatelessWidget{

  final scrapingController = Get.put(ScrapingResultController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Column(
                        children : [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Text('inJson', style: TextStyle(fontSize: 20),),
                          ),
                          TextField(
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            autofocus: false,
                            onTap: (){
                              scrapingController.inJsonNode.requestFocus();
                            },
                            decoration: InputDecoration(
                              focusedBorder: new OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black, width: 1.0)
                              ),
                            ),
                            minLines: 15,
                            maxLines: null,
                            focusNode: scrapingController.inJsonNode,
                            controller: scrapingController.inJsonController,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Text('outJson', style: TextStyle(fontSize: 20),),
                          ),
                          TextField(
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            onTap: (){
                              scrapingController.outJsonNode.requestFocus();
                            },
                            minLines: 10,
                            maxLines: null,
                            decoration: InputDecoration(
                              focusedBorder: new OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black, width: 1.0)
                              ),
                            ),
                            focusNode: scrapingController.outJsonNode,
                            controller: scrapingController.outJsonController,
                          )
                        ]
                    );
                  },
                  childCount: 1
              )
          )
        ],
      ),
    );
  }
}

class ScrapingResultController extends GetxController{


  TextEditingController inJsonController = TextEditingController();
  TextEditingController outJsonController = TextEditingController();

  FocusNode inJsonNode = FocusNode();

  FocusNode outJsonNode = FocusNode();


  static const platform = const MethodChannel('ift-engine-call');

  void updateResult(){

    String inJson = inJsonController.text;

    _getResult(inJson: inJson)
        .then((result) {
          outJsonController.text = result;
          update();
        });
  }

  Future<String> _getResult({required String inJson}) async {
    String result = '';
    try{
      result = await platform.invokeMethod('startEngine', inJson);
    } on PlatformException catch(e){
      result = 'Error : ${e.message}';
    } on Exception catch(e){
      result = e.toString();
      print(e.toString());
    }

    return result;
  }
}