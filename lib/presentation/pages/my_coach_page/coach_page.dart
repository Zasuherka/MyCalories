import 'package:app1/internal/bloc/coach/coach_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class CoachPage extends StatelessWidget {
  const CoachPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Widget verticalOffset = SliverToBoxAdapter(
      child: SizedBox(
          height: 10
      ),
    );
    final coachBloc = context.read<CoachBloc>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<CoachBloc, CoachState>(
          builder: (BuildContext context, CoachState state){
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
                            colorFilter: const ColorFilter.mode(
                                Colors.transparent, BlendMode.color),
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 117.5, left: screenWidth/2 - 145/2),
                        child: SizedBox(
                          height: 145,
                          width: 145,
                          child: ClipOval(
                            child: coachBloc.coach?.urlAvatar?.contains('http') ?? false
                                ? Image.network(
                              'https://sun9-64.userapi.com/impg/Ab1TSqAT0YQuWbHPbCzTyMR1LF28_lMaIBuopQ/aK_DWhAKmBk.jpg?size=1440x2160&quality=95&sign=ad7649c02922d09a2565dc10b7a224a8&type=album',
                              fit: BoxFit.cover,
                            )
                                : Image.asset('images/icon.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalOffset,
                SliverToBoxAdapter(
                  child: Text(
                      coachBloc.coach?.name ?? '',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge
                  ),
                ),
                verticalOffset,
                SliverToBoxAdapter(
                    child: Text(
                        coachBloc.coach?.email ?? '',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall
                    )
                ),
                verticalOffset,
                SliverToBoxAdapter(
                  child: GestureDetector(
                    onTap: () => context.router.push(const EditingProfileRoute()),
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
                                    colorFilter: const ColorFilter.mode(AppColors.secondaryTextColor, BlendMode.srcIn),
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
                                          coachBloc.coach?.weightNow.toString() ?? '—',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.titleLarge
                                      ),
                                      Text(
                                          'Сейчас',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.titleSmall
                                      ),
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
                                          coachBloc.coach?.weightGoal.toString() ?? '—',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.titleLarge
                                      ),
                                      Text(
                                          'Цель',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.titleSmall
                                      ),
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
                                  colorFilter: const ColorFilter.mode(AppColors.secondaryTextColor, BlendMode.srcIn),
                                ),
                                const Spacer(flex: 3),
                                SizedBox(
                                  width: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          coachBloc.coach?.height.toString() ?? '—',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.titleLarge
                                      ),
                                      Text(
                                          'Рост',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.titleSmall
                                      ),
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
                                          coachBloc.coach?.age.toString() ?? '—',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.titleLarge,
                                      ),
                                      Text(
                                          'Возраст',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.titleSmall
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(flex: 2),
                              ],
                            ),
                            const Spacer()
                          ],
                        )
                    ),
                  ),
                ),
                //const SliverToBoxAdapter(child: News())
              ],
            );
          },
        )
    );
  }
}