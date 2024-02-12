// ignore: must_be_immutable
 

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/settings/responsive.dart';

import '../../admin/module_page/model/module_model.dart';
import '../home_page.dart';

// ignore: must_be_immutable
class ParentMainModuleListWidget extends StatelessWidget {
  List<ModuleMenuList> list;
  ParentMainModuleListWidget({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: _mobile(list),
        tablet: _desktop(list, context),
        desktop: _desktop(list, context));
  }
}

_desktop(List<ModuleMenuList> list, BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Padding(
    padding: size.width <= 650
        ? const EdgeInsets.only(bottom: 45)
        : const EdgeInsets.only(bottom: 0),
    child: GridView.builder(
      itemCount: list.length,
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: size.width <= 650
            ? 1
            : (size.width > 650 && size.width < 1200)
                ? 2
                : (size.width >= 1200 && size.width < 1730)
                    ? 3
                    : 4,
        childAspectRatio: 2.0,
        mainAxisSpacing: 25.0,
        crossAxisSpacing: 25.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              // print('object');
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => HomePage(
                      module: list[index],
                    ),
                  ));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        color: Colors.black87.withOpacity(0.3), width: 0.38),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 1,
                          color: const Color.fromARGB(255, 11, 0, 36)
                              .withOpacity(0.135)),
                      BoxShadow(
                          blurRadius: 50,
                          spreadRadius: 15,
                          color: const Color.fromARGB(255, 41, 241, 1)
                              .withOpacity(0.015)),
                      BoxShadow(
                          blurRadius: 80,
                          spreadRadius: 40,
                          color: const Color.fromARGB(255, 255, 255, 255)
                              .withOpacity(0.015))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            // border: Border.all(color: Colors.black)
                          ),
                          child: Image(
                            image: AssetImage(
                                "assets/images/${list[index].img!}.png"),
                            height: size.width < 650
                                ? 40
                                : (size.width >= 1200 && size.width < 1600)
                                    ? 60
                                    : (size.width > 650 && size.width < 805)
                                        ? 50
                                        : 70,
                            width: size.width < 650
                                ? 30
                                : (size.width >= 1200 && size.width < 1600)
                                    ? 50
                                    : (size.width > 650 && size.width < 805)
                                        ? 40
                                        : 60,
                            fit: BoxFit.contain,
                            //color: Colors.amber,
                            colorBlendMode: BlendMode.srcIn,
                          )),
                      Text(
                        list[index].name!,
                        style: GoogleFonts.roboto(
                            fontSize: size.width < 650
                                ? 13
                                : (size.width > 650 && size.width < 805)
                                    ? 16
                                    : 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.indigo),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Expanded(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: size.width < 650
                                  ? 200
                                  : (size.width > 650 && size.width <= 705)
                                      ? 30
                                      : (size.width > 705 && size.width < 805)
                                          ? 45
                                          : (size.width >= 1200 &&
                                                  size.width < 1600)
                                              ? 50
                                              : 100),
                          child: Text(
                            list[index].desc!,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.roboto(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

_mobile(List<ModuleMenuList> list) => ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            decoration: customBoxDecoration.copyWith(border:Border.all(color: kHeaderolor.withOpacity(0.25)) ),
            margin: const EdgeInsets.only(bottom: 12,top: 4),
          
          
            child: InkWell(
               borderRadius:BorderRadius.circular(8),
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => HomePage(
                      module: list[index],
                    ),
                  ));
            },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(8),
                          //  color:Colors.blue,
                          boxShadow:  [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              spreadRadius: 0.5,
                              blurRadius: 10.5,
                              offset: const Offset(0, 0),
                            )
                          ]
                          ),
                          child: Center(
                            child: Image(
                              
                              image: AssetImage("assets/images/${list[index].img!}.png"),
                              width: 40,
                              height: 32,
                              color: kHeaderolor.withOpacity(0.8),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                const SizedBox(width: 8,),
                  Flexible(
                    child: Text(
                            list[index].name!,
                            style: customTextStyle.copyWith(fontSize: 18,fontWeight: FontWeight.w600, color: kHeaderolor,),
                          ),
                  )
                        
                        
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      list[index].desc!,
                      overflow: TextOverflow.clip,
                      style: customTextStyle.copyWith(fontSize: 12,fontWeight: FontWeight.normal),),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
