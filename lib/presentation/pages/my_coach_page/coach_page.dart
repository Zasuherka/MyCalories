import 'package:app1/internal/bloc/coach_bloc/coach_bloc.dart';
import 'package:app1/internal/bloc/colletion_bloc/collection_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/pages/my_coach_page/widgets/remove_coach_dialog.dart';
import 'package:app1/presentation/router/router.dart';
import 'package:app1/presentation/widgets/custom_buttons/primary_app_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoachPage extends StatelessWidget {
  const CoachPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CollectionBloc>(context).add(const CollectionEvent.getUserListCollection());
    const Widget verticalOffset = SliverToBoxAdapter(
      child: SizedBox(height: 10),
    );
    final coachBloc = context.read<CoachBloc>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<CoachBloc, CoachState>(
          listener: (BuildContext context, CoachState state){
            state.whenOrNull(
              removeSuccess: (){
                context.router.popForced();
              }
            );
          },
          builder: (BuildContext context, CoachState state) {
            state.whenOrNull(
                loading: () => Center(
                      child: Image.asset(
                        'images/bouncing-circles.gif',
                        height: 100,
                      ),
                    ));
            return CustomScrollView(
              physics: const RangeMaintainingScrollPhysics(),
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            boxShadow: boxShadow,
                          ),
                          height: 190,
                          child: SvgPicture.asset(
                            'images/waves.svg',
                            fit: BoxFit.cover,
                            colorFilter:
                                const ColorFilter.mode(Colors.transparent, BlendMode.color),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 117.5, left: screenWidth / 2 - 145 / 2),
                        child: SizedBox(
                          height: 145,
                          width: 145,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.17),
                                    spreadRadius: 4,
                                    blurRadius: 10,
                                    offset: const Offset(0, -5),
                                  )],
                                shape: BoxShape.circle
                            ),
                            child: ClipOval(
                              child: coachBloc.coach?.urlAvatar?.contains('http') ?? false
                                  ? Image.network(
                                coachBloc.coach!.urlAvatar!,
                                fit: BoxFit.cover,
                              )
                                  : Image.asset(
                                'images/icon.jpg',
                                height: 145,
                                width: 145,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 37,
                        left: 20,
                        child: GestureDetector(
                          onTap: () {
                            context.router.popForced();
                          },
                          child: SvgPicture.asset(
                            'images/arrow.svg',
                            width: 32,
                            height: 32,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 37,
                        right: 20,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(context: context, builder: (context) => const RemoveCoachDialog());
                          },
                          child: const Icon(
                            Icons.settings,
                            size: 32,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                verticalOffset,
                SliverToBoxAdapter(
                  child: Text(coachBloc.coach?.name ?? '',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                verticalOffset,
                SliverToBoxAdapter(
                    child: Text(coachBloc.coach?.email ?? '',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall)),
                verticalOffset,
                SliverToBoxAdapter(
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12.5),
                      height: 170,
                      decoration: BoxDecoration(
                        boxShadow: boxShadow,
                        color: AppColors.elementColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Spacer(flex: 2),
                              SizedBox(
                                child: SvgPicture.asset(
                                  'images/weight.svg',
                                  width: 45,
                                  colorFilter: const ColorFilter.mode(
                                      AppColors.secondaryTextColor, BlendMode.srcIn),
                                ),
                              ),
                              const Spacer(flex: 3),
                              SizedBox(
                                width: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(coachBloc.coach?.weightNow?.toString() ?? '—',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.titleLarge),
                                    Text('Сейчас',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.titleSmall),
                                  ],
                                ),
                              ),
                              const Spacer(flex: 3),
                              SizedBox(
                                width: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(coachBloc.coach?.weightGoal?.toString() ?? '—',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.titleLarge),
                                    Text('Цель',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.titleSmall),
                                  ],
                                ),
                              ),
                              const Spacer(flex: 2),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Spacer(flex: 2),
                              SvgPicture.asset(
                                'images/people.svg',
                                width: 45,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.secondaryTextColor, BlendMode.srcIn),
                              ),
                              const Spacer(flex: 3),
                              SizedBox(
                                width: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(coachBloc.coach?.height?.toString() ?? '—',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.titleLarge),
                                    Text('Рост',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.titleSmall),
                                  ],
                                ),
                              ),
                              const Spacer(flex: 3),
                              SizedBox(
                                width: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      coachBloc.coach?.age?.toString() ?? '—',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                    Text('Возраст',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.titleSmall),
                                  ],
                                ),
                              ),
                              const Spacer(flex: 2),
                            ],
                          ),
                          const Spacer()
                        ],
                      )),
                ),
                verticalOffset,
                verticalOffset,
                SliverToBoxAdapter(
                  child: PrimaryAppButton(
                    onTap: () {
                      context.router.push(CoachCollectionsRoute(isAddEatingFood: false));
                    },
                    margin: const EdgeInsets.symmetric(horizontal: 12.5),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    withColor: true,
                    child: Text(
                      'Наборы еды',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                )
                //const SliverToBoxAdapter(child: News())
              ],
            );
          },
        ));
  }
}
