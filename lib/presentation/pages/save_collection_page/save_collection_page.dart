import 'package:app1/domain/model/collection.dart';
import 'package:app1/internal/bloc/collection_food/collection_food_bloc.dart';
import 'package:app1/internal/bloc/colletion_bloc/collection_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/domain/model/food.dart';
import 'package:app1/presentation/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';


@RoutePage()
class SaveCollectionPage extends StatefulWidget {
  final List<Food> listFood;
  final Collection? collection;
  const SaveCollectionPage({super.key, required this.listFood, this.collection});

  @override
  State<SaveCollectionPage> createState() => _SaveCollectionPageState();
}

class _SaveCollectionPageState extends State<SaveCollectionPage> {
  final TextEditingController _titleTextController = TextEditingController();
  String _errorText = '';
  String title = '';
  List<Food> listFood = [];

  void _titleListener() {
    if(_titleTextController.text == ' '){
      _titleTextController.text = '';
    }
    title = _titleTextController.text;
    if(title != ''){
      setState(() {
        _errorText = '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if(widget.collection != null){
      title = widget.collection!.title;
    }
    _titleTextController.text = title;
    listFood.addAll(widget.listFood);
    _titleTextController.addListener(_titleListener);
  }

  @override
  void dispose() {
    super.dispose();
    _titleTextController.dispose();
    _titleTextController.removeListener(_titleListener);
  }

  @override
  Widget build(BuildContext context) {
    final Collection? collection = widget.collection;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              toolbarHeight: MediaQuery.of(context).padding.top + 20,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: AppColors.greenGradient
                ),),
              title: const Text('Редактирование'),
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(
                    maxWidth: 33,
                    maxHeight: 33,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'images/arrow.svg',
                      width: 33,
                      height: 33,
                      colorFilter:
                      const ColorFilter.mode(AppColors.primaryButtonColor, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
              actions: [
                Padding(padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if(_titleTextController.text == ''){
                          _errorText = 'Выберите название';
                        }
                        else{
                          if(collection == null){
                            BlocProvider.of<CollectionBloc>(context)
                                .add(CollectionEvent.createCollection(
                                title: title,
                                listFood: listFood
                            ));
                          }
                          else{
                            BlocProvider.of<CollectionFoodBloc>(context)
                                .add(CollectionFoodEvent
                                .updateCollection(
                                  updateListFood: listFood,
                                  collection: collection,
                                  title: _titleTextController.text,
                            ));
                          }
                          context.read<CollectionBloc>()
                              .add(const CollectionEvent.getUserListCollection());
                          context.router.popUntilRouteWithName(CollectionsRoute.name);
                        }
                      });
                    },
                    child: SvgPicture.asset(
                      'images/mark.svg',
                      width: 33,
                      height: 33,
                      colorFilter:
                      const ColorFilter.mode(AppColors.primaryButtonColor, BlendMode.srcIn),
                    ),
                  ),
                )
              ],
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: TextField(
                  controller: _titleTextController,
                  maxLength: 20,
                  decoration: InputDecoration(
                      counterText: '',
                      suffixIcon: GestureDetector(
                        onTap: () => _titleTextController.text = '',
                        child: const Icon(
                          Icons.close,
                          color: AppColors.colorForHintText,
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      constraints: BoxConstraints.tightFor(width: screenWidth - 300),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1,
                              color: AppColors.turquoise
                          ),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1,
                              color: AppColors.turquoise
                          ),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      hintText: 'Название',
                      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.colorForHintText
                      )
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 5,
              ),
            ),
            SliverToBoxAdapter(
              child: _errorText != '' ? Text(_errorText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.red
                ),
              ) : const SizedBox(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 5,
              ),
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () => context.router.popForced(),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: AppColors.greenGradient
                  ),
                  child: Text(
                    'Добавить ещё',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.primaryButtonColor
                    ),
                  ),
                ),
              ),
            ),
            SliverList.builder(
                itemCount: listFood.length,
                itemBuilder: (BuildContext context, int index) {
                  final food = listFood[listFood.length - 1 - index];
                  return Dismissible(
                    key: Key(listFood[index].title.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      listFood.removeAt(listFood.length - 1 - index);
                    },
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      height: 77,
                      child: const Icon(
                        size: 35,
                        Icons.delete,
                        color: AppColors.red,
                      ),
                    ),
                    child: GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 7,
                          left: 7,
                          right: 7,
                        ),
                        height: 77,
                        decoration: BoxDecoration(
                            color: AppColors.elementColor,
                            boxShadow: boxShadow,
                            borderRadius: BorderRadius.circular(25.0)),
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Spacer(),
                            Text(
                              food.title,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleLarge
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 130,
                                  child: Text(
                                    '${food.calories.toString()}ккал.',
                                    style: Theme.of(context).textTheme.titleSmall
                                  ),
                                ),
                                SizedBox(
                                  width: 180,
                                  child: Text(
                                    '${food.protein.toStringAsFixed(2)}|'
                                        '${food.fats.toStringAsFixed(2)}|'
                                        '${food.carbohydrates.toStringAsFixed(2)}',
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context).textTheme.titleSmall
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
