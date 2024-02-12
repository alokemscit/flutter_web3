import 'package:flutter/material.dart';
 
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/settings/functions.dart';

class CustomCaptionForForAccordian extends StatefulWidget {
  CustomCaptionForForAccordian({
    super.key,
    required this.text,
    this.backgroundColor = kWebHeaderColor,
    this.boxShadoColor = Colors.black38,
    this.textColor = Colors.black,
    void Function(bool)? onTap,
  }) : onTap = onTap ?? ((bool b) {});
  final String text;
  final Color backgroundColor;
  final Color boxShadoColor;
  final Color textColor;
  final void Function(bool) onTap;

  @override
  State<CustomCaptionForForAccordian> createState() =>
      _CustomCaptionForForAccordianState();
}

class _CustomCaptionForForAccordianState
    extends State<CustomCaptionForForAccordian> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor.withOpacity(0.13),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        //border: Border.all(color: Colors.black38, width: 0.1),
        boxShadow: [
          BoxShadow(
              color: widget.boxShadoColor.withOpacity(0.3),
              blurRadius: 1.05,
              spreadRadius: 0.1)
        ],
      ),
      width: double.infinity,
      child: InkWell(
         onTap: () {
                widget.onTap(!isOpen);
                // controller.isOpen.value = !controller.isOpen.value;
                setState(() {
                  isOpen = !isOpen;
                });
              },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6, bottom: 8, top: 2),
              child: Text(
                widget.text,
                style: customTextStyle.copyWith(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    decorationColor: widget.textColor,
                    color: widget.textColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: () {
                  widget.onTap(!isOpen);
                  // controller.isOpen.value = !controller.isOpen.value;
                  setState(() {
                    isOpen = !isOpen;
                  });
                },
                child: Icon(
                  isOpen
                      ? Icons.keyboard_arrow_down_sharp
                      : Icons.keyboard_arrow_up_sharp,
                  color: widget.textColor,
                  size: 24,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AccordionContainer extends StatefulWidget {
  const AccordionContainer(
      {super.key,
      required this.headerName,
      required this.children,
      this.height = 350});
  final String headerName;
  final List<Widget> children;
  final double height;

  @override
  State<AccordionContainer> createState() => _AccordionContainerState();
}

class _AccordionContainerState extends State<AccordionContainer> {
  bool b = false;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCaptionForForAccordian(
            text: widget.headerName,
            onTap: (a) {
              setState(() {
                b = a;
              });
            },
          ),
          widget.height > 0 
              ? Container(
                  decoration: CustomCaptionDecoration().copyWith(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4)),
                    color: kWebBackgroundDeepColor,
                  ),
                  height: b?0:widget.height,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children:  widget.children,
                      )))
              : b?const SizedBox(): Expanded(
                  child: Container(
                      decoration: CustomCaptionDecoration().copyWith(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4)),
                        color: kWebBackgroundDeepColor,
                      ),
                      //height: height,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: widget.children,
                          ))),
                )
        ]);
  }
}



// AccordionContainer(String headerName, List<Widget> children,
//         [double height = 350]) =>
//     Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//            CustomCaptionForForAccordian(text: headerName,),
        
//         height>0?  Container(
//               decoration: CustomCaptionDecoration().copyWith(
//                 borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(4),
//                     bottomRight: Radius.circular(4)),
//                 color: kWebBackgroundDeepColor,
//               ),
//               height: height,
//               child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: children,
//                   ))):Expanded(
//             child: Container(
//                 decoration: CustomCaptionDecoration().copyWith(
//                   borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(4),
//                       bottomRight: Radius.circular(4)),
//                     color: kWebBackgroundDeepColor,
//                 ),
//                 //height: height,
//                 child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: children,
//                     ))),
//           )


//         ]);
