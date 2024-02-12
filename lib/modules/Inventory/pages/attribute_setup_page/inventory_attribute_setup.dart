import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/settings/functions.dart';

class InvAttributeSetup extends StatelessWidget {
  const InvAttributeSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Accordion(
            
            children: [
              AccordionSection(
               headerBackgroundColor: Colors.black12,
             headerBackgroundColorOpened:  Colors.black12,
            contentBackgroundColor: Colors.transparent,
            contentBorderColor: Colors.transparent,
                isOpen: true,
               // contentVerticalPadding: 20,
                leftIcon:null,
                rightIcon: null,
                header:  const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("data"),
                )  , 
                content:   Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                            for(var i=0;i<200;i++)
                              Text("loremIpsum",),
                      ],
                    ),
                  ],
                )
              ),
              // AccordionSection(
              //   isOpen: true,
              //   leftIcon: const Icon(Icons.input, color: Colors.white),
              //   header: const Text('Text Field & Button', ),
              //   contentHorizontalPadding: 40,
              //   contentVerticalPadding: 20,
              //   content: const Text('Text Field & Button', ),
              // ),
              // AccordionSection(
              //   isOpen: true,
              //   leftIcon:
              //       const Icon(Icons.child_care_rounded, color: Colors.white),
              //   header: const Text('Nested Accordion', ),
              //   content: const Text('Text Field & Button', ),
              // ),
            ]),
        ),
        
      );
  }
}