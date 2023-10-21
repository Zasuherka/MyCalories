import 'package:app1/bloc/eatingFood/eating_food_bloc.dart';
import 'package:app1/objects/food.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';



class AddFood extends StatefulWidget {
  final Food food;
  const AddFood({super.key, required this.food});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final _formKey = GlobalKey<FormState>();
  late Food food;
  late String weight;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    food = widget.food;
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child:
        Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30)
            ),
            width: screenWidth/1.1,
            height: screenHeight/3,
            child:
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(top: screenHeight/100)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            shadowColor: Colors.transparent
                        ),
                        child: SvgPicture.asset(
                          'images/arrow.svg',
                          width: screenHeight/27,
                          height: screenHeight/27,
                          colorFilter: const ColorFilter.mode(Color.fromRGBO(16, 240, 12, 1.0), BlendMode.srcIn),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth/1.5,
                        //height: screenHeight/,
                        child:
                        Text(
                          food.title,
                          style: TextStyle(
                              fontSize: screenHeight/40,
                              fontFamily: 'Comfortaa',
                              color: Colors.black
                          ),
                          textAlign: TextAlign.left,
                        )
                      ),

                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: screenHeight/60)),
                  SizedBox(
                    width: screenWidth/1.2,
                    height: screenHeight/12,
                    child:
                    Table(
                      border: TableBorder.all(
                        color: const Color.fromRGBO(16, 240, 12, 1.0),
                      ),
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                            children: [
                              TableCell(
                                  verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Белки",
                                      style: TextStyle(
                                          fontSize: screenHeight/70,
                                          fontFamily: 'Comfortaa',
                                          color: Colors.black
                                      ),
                                      textAlign: TextAlign.center,),
                                  )
                              ),
                              TableCell(
                                  verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                    Text("Жиры",
                                        style:
                                        TextStyle(
                                            fontSize: screenHeight/70,
                                            fontFamily: 'Comfortaa',
                                            color: Colors.black
                                        ),
                                        textAlign: TextAlign.center),
                                  )
                              ),
                              TableCell(
                                  verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Углеводы",
                                        style:
                                        TextStyle(
                                            fontSize: screenHeight/70,
                                            fontFamily: 'Comfortaa',
                                            color: Colors.black
                                        ),
                                        textAlign: TextAlign.center),
                                  )
                              ),
                              TableCell(
                                  verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("ккал",
                                        style:
                                        TextStyle(
                                            fontSize: screenHeight/70,
                                            fontFamily: 'Comfortaa',
                                            color: Colors.black
                                        ),
                                        textAlign: TextAlign.center),
                                  )
                              ),
                            ]
                        ),
                        TableRow(
                            children: [
                              TableCell(
                                  verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                        height: screenHeight/30,
                                        child: Center(
                                          child: Text(
                                            food.protein.toStringAsFixed(2),
                                            style: TextStyle(
                                                fontSize: screenHeight/50,
                                                fontFamily: 'Comfortaa',
                                                color: Colors.black
                                            ),
                                          )
                                        )
                                    ),
                                  )
                              ),
                              TableCell(
                                  verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                        height: screenHeight/30,
                                        child: Center(
                                          child: Text(
                                            food.fats.toStringAsFixed(2),
                                            style: TextStyle(
                                                fontSize: screenHeight/50,
                                                fontFamily: 'Comfortaa',
                                                color: Colors.black
                                            ),
                                          )
                                        )
                                    ),
                                  )
                              ),
                              TableCell(
                                  verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                                  child: Padding(padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                        height: screenHeight/30,
                                        child: Center(
                                          child: Text(
                                            food.carbohydrates.toStringAsFixed(2),
                                            style: TextStyle(
                                                fontSize: screenHeight/50,
                                                fontFamily: 'Comfortaa',
                                                color: Colors.black
                                            ),
                                          )
                                        )
                                    ),
                                  )
                              ),
                              TableCell(
                                  verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                                  child: Padding(padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                        height: screenHeight/30,
                                        child: Center(
                                          child:
                                            Text(
                                              food.calories.toStringAsFixed(2),
                                              style: TextStyle(
                                                      fontSize: screenHeight/50,
                                                      fontFamily: 'Comfortaa',
                                                      color: Colors.black
                                                  ),
                                            )
                                        )
                                    ),
                                  )
                              ),
                            ]
                        )
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: screenHeight/200)),
                  SizedBox(
                    width: screenWidth * 0.83,
                    height: screenHeight/12,
                    child:
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(bottom: screenHeight/100),
                        child: SvgPicture.asset(
                          'images/weight.svg',
                          width: screenHeight/27,
                          height: screenHeight/27,
                          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                        ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.4,
                          child:
                          Padding(padding: EdgeInsets.only(left: screenWidth/100),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value == ''){
                                      return 'Поле не заполнено';
                                    }
                                    return null;
                                  },
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true), // Разрешить ввод чисел с плавающей точкой
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                                  onChanged: (String value){
                                    weight = value;
                                  },
                                  style: TextStyle(
                                      fontSize: screenHeight/40,
                                      fontFamily: 'Comfortaa',
                                      color: Colors.black
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'гр/мл',
                                    hintStyle: TextStyle(
                                        fontSize: screenHeight/40,
                                        fontFamily: 'Comfortaa',
                                        color: const Color.fromRGBO(0, 0, 0, 0.3)
                                    ),
                                    hoverColor: Colors.orange,
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black, width: 1),
                                    ),
                                    contentPadding: const EdgeInsets.only(bottom: -10),
                                    border: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black, width: 1),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                        ),
                      ],
                    )
                  ),
                  Padding(padding: EdgeInsets.only(top: screenHeight/40)),
                  SizedBox(
                    height: screenHeight/25,
                    width: screenWidth/2.5,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState != null)
                        {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<EatingFoodBloc>(context).add(AddEatingFoodListEvent(food.idFood, food.title, food.protein, food.fats, food.carbohydrates, food.calories, int.parse(weight)));
                            Navigator.pop(context, true);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(16, 240, 12, 1.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36)
                          )
                      ),
                      child: Text(
                        "Добавить",
                        style:
                        TextStyle(
                            fontSize: screenHeight/40,
                            fontFamily: 'Comfortaa',
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
