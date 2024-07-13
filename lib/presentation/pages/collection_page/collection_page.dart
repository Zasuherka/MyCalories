import 'package:app1/domain/model/collection.dart';
import 'package:app1/domain/model/eating_food.dart';
import 'package:app1/domain/model/food.dart';
import 'package:app1/internal/bloc/collection_food/collection_food_bloc.dart';
import 'package:app1/internal/bloc/colletion_bloc/collection_bloc.dart';
import 'package:app1/internal/bloc/eating_food_bloc/eating_food_bloc.dart';
import 'package:app1/internal/cubit/warning_cubit/warning_cubit.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/pages/collection_page/widgets/collection_wrap.dart';
import 'package:app1/presentation/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class CollectionPage extends StatefulWidget {
  final String collectionId;
  const CollectionPage({super.key, required this.collectionId});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {

  String title = '';
  List<Food> listFood = [];
  Collection? collection;
  bool isUserCollection = false;
  bool userHaveThisCollection = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CollectionFoodBloc>(context)
        .add(CollectionFoodEvent.getCollection(collectionId: widget.collectionId));
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    final state = context.watch<CollectionFoodBloc>().state;
    state.whenOrNull(
      loading: () => isLoading = true,
      success: () => userHaveThisCollection = !userHaveThisCollection,
      collection: (collection, isUserCollection, userHaveThisCollection) {
        this.collection = collection;
        title = collection.title;
        listFood = collection.listFood;
        this.isUserCollection = isUserCollection;
        this.userHaveThisCollection = userHaveThisCollection;
      },
    );
    return Scaffold(
      body: BlocListener<EatingFoodBloc, EatingFoodState>(
        listener: (context, state) {
          state.whenOrNull(
            success: () => context.read<WarningCubit>().saveInfoWarning,
          );
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              toolbarHeight: MediaQuery.of(context).padding.top + 20,
              flexibleSpace: Container(
                decoration: const BoxDecoration(gradient: AppColors.greenGradient),
              ),
              title: Text(!isLoading ? title : ''),
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {
                    context.router.popForced();
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
              actions: state.maybeMap(
                  loading: (_) => [],
                  orElse: () => [
                        if (isUserCollection)
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              onTap: () => context.router
                                  .push(UpdateCollectionRoute(collection: collection!)),
                              child: SvgPicture.asset(
                                'images/editing.svg',
                                height: 33,
                                width: 33,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.primaryButtonColor, BlendMode.srcIn),
                              ),
                            ),
                          ),
                        userHaveThisCollection
                            ? Padding(
                                padding: const EdgeInsets.only(right: 23),
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<CollectionFoodBloc>().add(
                                        CollectionFoodEvent.deleteCollection(
                                            collectionId: collection!.id));
                                    context
                                        .read<CollectionBloc>()
                                        .add(const CollectionEvent.getUserListCollection());
                                    context.router.popForced();
                                  },
                                  child: SvgPicture.asset(
                                    'images/delete.svg',
                                    height: 33,
                                    width: 33,
                                    colorFilter: const ColorFilter.mode(
                                        AppColors.primaryButtonColor, BlendMode.srcIn),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(right: 23),
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<CollectionFoodBloc>().add(
                                        CollectionFoodEvent.addCollectionInUserListCollection(
                                            collection: collection!));
                                    context
                                        .read<CollectionBloc>()
                                        .add(const CollectionEvent.getUserListCollection());
                                  },
                                  child: SvgPicture.asset(
                                    'images/add.svg',
                                    height: 33,
                                    width: 33,
                                    colorFilter: const ColorFilter.mode(
                                        AppColors.primaryButtonColor, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                      ]),
            ),
            !isLoading ? SliverList.builder(
              itemCount: listFood.length,
              itemBuilder: (BuildContext context, int index){
                index = listFood.length - 1 - index;
                return GestureDetector(
                  onTap: () {
                    BlocProvider.of<EatingFoodBloc>(context).add(EatingFoodEvent.getEatingFoodInfo(
                        eatingFood: EatingFood(
                            listFood[index].idFood,
                            listFood[index].authorEmail,
                            listFood[index].title,
                            listFood[index].protein,
                            listFood[index].fats,
                            listFood[index].carbohydrates,
                            listFood[index].calories, -1
                        ))
                    );
                    showModalBottomSheet(context: context, builder:
                        (BuildContext context) => const CollectionWrap());
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 8,
                        left: 7,
                        right: 7
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.elementColor,
                        boxShadow: boxShadow,
                        borderRadius: BorderRadius.circular(25.0)),
                    //width: screenWidth,
                    height: 77,
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Text(
                          listFood.elementAt(index).title,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.secondaryTextColor
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            SizedBox(
                              width: 130,
                              child: Text(
                                '${listFood.elementAt(index).calories.toString()}ккал.',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: AppColors.secondaryTextColor
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: Text(
                                '${listFood.elementAt(index).protein.toStringAsFixed(2)}|'
                                    '${listFood.elementAt(index).fats.toStringAsFixed(2)}|'
                                    '${listFood.elementAt(index).carbohydrates.toStringAsFixed(2)}',
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: AppColors.secondaryTextColor
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                );
          }) : SliverToBoxAdapter(
            child: //SvgPicture.asset('images/bouncing-circles.svg')
            Image.asset(
              'images/bouncing-circles.gif',
              height: 100,
            ),
          ),
        ],
      ),
),
    );
  }
}
