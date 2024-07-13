import 'package:app1/internal/bloc/coach_bloc/coach_bloc.dart';
import 'package:app1/presentation/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app1/presentation/constants.dart';

@RoutePage()
class CoachCollectionsPage extends StatefulWidget {
  final bool isAddEatingFood;

  const CoachCollectionsPage({super.key, required this.isAddEatingFood});

  @override
  State<CoachCollectionsPage> createState() => _CoachCollectionsPageState();
}

class _CoachCollectionsPageState extends State<CoachCollectionsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CoachBloc>(context).add(const CoachEvent.getCoachCollectionViewList());
  }

  @override
  Widget build(BuildContext context) {
    final CoachBloc coachBloc = context.read<CoachBloc>();
    return BlocBuilder<CoachBloc, CoachState>(
      builder: (context, state) {
        return Scaffold(
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    toolbarHeight: MediaQuery
                        .of(context)
                        .padding
                        .top + 20,
                    //expandedHeight: MediaQuery.of(context).padding.top + 20,
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                          gradient: AppColors.greenGradient
                      ),),
                    title: const Text('Ныборы еды'),
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
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  state.maybeMap(
                    loading: (_) => SliverToBoxAdapter(
                      child: //SvgPicture.asset('images/bouncing-circles.svg')
                      Image.asset(
                        'images/bouncing-circles.gif',
                        height: 100,
                      ),
                    ),
                    orElse: () => SliverList.builder(
                        itemCount: coachBloc.collectionViewList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final list = coachBloc.collectionViewList;
                          index = list.length - 1 - index;
                          return GestureDetector(
                            onTap: () =>
                                context
                                    .router.push(CollectionRoute(collectionId: list[index].id)),
                            child: Container(
                              margin: const EdgeInsets.only(
                                  bottom: 8,
                                  left: 7,
                                  right: 7
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.elementColor,
                                  boxShadow: boxShadow,
                                  borderRadius: BorderRadius.circular(25.0)),
                              padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                  left: 20),
                              child: Text(
                                list[index].title,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleMedium,
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            )
        );
      },
    );
  }
}
