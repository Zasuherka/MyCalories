import 'package:app1/internal/bloc/wards_bloc/wards_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/pages/ward_page/widgets/remove_ward_dialog.dart';
import 'package:app1/presentation/router/router.dart';
import 'package:app1/presentation/widgets/custom_buttons/primary_app_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class WardPage extends StatelessWidget {
  const WardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final WardsBloc wardsBloc = context.read<WardsBloc>();
    const Widget verticalOffset = SliverToBoxAdapter(
      child: SizedBox(height: 10),
    );
    return Scaffold(
      body: PopScope(
        onPopInvoked: (canPop){
          wardsBloc.resetData();
          wardsBloc.resetWorkoutData();
        },
        child: BlocListener<WardsBloc, WardsState>(
          listener: (context, state) {
            state.whenOrNull(
              successRemoveWard: () => context.router.popForced()
            );
          },
          child: CustomScrollView(
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
                            child: wardsBloc.selectedWard?.urlAvatar?.contains('http') ?? false
                                ? Image.network(
                              wardsBloc.selectedWard!.urlAvatar!,
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
                          wardsBloc.resetData();
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
                          showDialog(context: context, builder: (context) => const RemoveWardDialog());
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
                child: Text(wardsBloc.selectedWard?.name ?? '',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              verticalOffset,
              SliverToBoxAdapter(
                  child: Text(wardsBloc.selectedWard?.email ?? '',
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
                                  Text(wardsBloc.selectedWard?.weightNow?.toString() ?? '—',
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
                                  Text(wardsBloc.selectedWard?.weightGoal?.toString() ?? '—',
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
                                  Text(wardsBloc.selectedWard?.height?.toString() ?? '—',
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
                                    wardsBloc.selectedWard?.age?.toString() ?? '—',
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
                    context.router.push(const WardFoodDiaryRoute());
                  },
                  margin: const EdgeInsets.symmetric(horizontal: 12.5),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  withColor: true,
                  child: Text(
                    'Дневник питания',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              verticalOffset,
              SliverToBoxAdapter(
                child: PrimaryAppButton(
                  onTap: () {
                    wardsBloc.add(const WardsEvent.completedWorkoutList());
                    context.router.push(const WardCompletedWorkoutsRoute());
                  },
                  margin: const EdgeInsets.symmetric(horizontal: 12.5),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  withColor: true,
                  child: Text(
                    'Выполненные тренировки',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              verticalOffset,
              SliverToBoxAdapter(
                child: PrimaryAppButton(
                  onTap: () {
                    context.router.push(const WorkoutForWardRoute());
                  },
                  margin: const EdgeInsets.symmetric(horizontal: 12.5),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  withColor: true,
                  child: Text(
                    'Отправить тренировку',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
