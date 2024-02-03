// import 'package:app1/widgets/update_food.dart';
// import 'package:flutter/material.dart';
// import 'package:app1/service/user_sirvice.dart';
//
// class ListFood extends StatefulWidget {
//   const ListFood({super.key});
//
//   @override
//   State<ListFood> createState() => _ListFoodState();
// }
//
// class _ListFoodState extends State<ListFood> {
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     return SizedBox(
//         child:
//         ListView.builder(shrinkWrap: true,
//           padding: EdgeInsets.only(top: screenHeight/300),
//           itemCount: localUser!.myFoods.length,
//           itemBuilder: (BuildContext context, int index) {
//             int elementIndex = localUser!.myFoods.length - 1 - index;
//             return Padding(padding: EdgeInsets.only(top: screenHeight/200, left: screenWidth/100, right: screenWidth/100),
//                 child:
//                 GestureDetector(
//                   onTap: () async{
//                     await showDialog(context: context, builder: (BuildContext context) => UpdateFood(food: localUser!.myFoods[elementIndex]));
//                     setState(() {});
//                   },
//                   child: Container(
//                       decoration:
//                       BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.2),
//                               spreadRadius: 5,
//                               blurRadius: 13,
//                               offset: const Offset(0, 5),
//                             ),
//                           ],
//                           borderRadius: BorderRadius.circular(15.0)
//                       ),
//                       width: screenWidth,
//                       height: screenHeight/10,
//                       child: Padding(padding: EdgeInsets.only(left: screenWidth/20),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(padding: EdgeInsets.only(left: screenWidth/60)),
//                             Text(
//                               localUser!.myFoods.elementAt(elementIndex).title,
//                               style: TextStyle(
//                                 fontSize: screenHeight/32,
//                                 fontFamily: 'Comfortaa',
//                                 color: const Color.fromRGBO(16, 240, 12, 1.0),
//                               ),
//                             ),
//                             Padding(padding: EdgeInsets.only(top: screenHeight/100)),
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   width: screenWidth/3,
//                                   child: Text('${localUser!.myFoods.elementAt(elementIndex).calories.toString()}ккал.',style: TextStyle(
//                                     fontSize: screenHeight/50,
//                                     fontFamily: 'Comfortaa',
//                                     color: const Color.fromRGBO(16, 240, 12, 1.0),
//                                   ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: screenWidth/2.5,
//                                   child:
//                                   Text('${localUser!.myFoods.elementAt(elementIndex).protein.toString()}|'
//                                       '${localUser!.myFoods.elementAt(elementIndex).fats.toString()}|'
//                                       '${localUser!.myFoods.elementAt(elementIndex).carbohydrates.toString()}',
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       fontSize: screenHeight/50,
//                                       fontFamily: 'Comfortaa',
//                                       color: const Color.fromRGBO(16, 240, 12, 1.0),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       )
//                   ),
//                 )
//             );
//           },
//         )
//     );
//   }
// }
