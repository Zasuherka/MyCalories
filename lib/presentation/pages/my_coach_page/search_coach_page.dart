import 'package:app1/internal/bloc/coach_bloc/coach_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/widgets/custom_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchCoachPage extends StatefulWidget {
  const SearchCoachPage({super.key});

  @override
  State<SearchCoachPage> createState() => _SearchCoachPageState();
}

class _SearchCoachPageState extends State<SearchCoachPage> {
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _searchTextController = TextEditingController();

  double _opacity = 1;

  void _onScroll(double offset) {
    setState(() {
      if (_scrollController.offset <= 100) {
        _opacity = 1 -
            (_scrollController.offset / 100 * (100 - _scrollController.offset) / 100)
                .clamp(0.0, 0.7);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CoachBloc coachBloc = context.read<CoachBloc>();
    return BlocBuilder<CoachBloc, CoachState>(
      builder: (context, state) {
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification.metrics.axis == Axis.vertical) {
              _onScroll(notification.metrics.pixels);
            }
            return true;
          },
          child: Scaffold(
            appBar: CustomAppBar(
              leftOnTap: (){
                coachBloc.add(const CoachEvent.searchCoach(searchText: ''));
                context.router.popForced();
              },
              title: 'Поиск тренера',
            ),
            body: PopScope(
              canPop: true,
              onPopInvoked: (bool didPop) {
                coachBloc.add(const CoachEvent.searchCoach(searchText: ''));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      leading: const SizedBox(),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      flexibleSpace: RepaintBoundary(
                        child: Builder(
                          builder: (context) {
                            if (_scrollController.offset <= 100) {
                              _opacity = 1 -
                                  (_scrollController.offset /
                                      100 *
                                      (100 - _scrollController.offset) /
                                      100)
                                      .clamp(0.0, 0.8);
                            } else {
                              _opacity = 0.2;
                            }
                            return AnimatedOpacity(
                              duration: animationDurationFast,
                              opacity: _opacity,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(7, 0, 7, 10),
                                child: TextField(
                                  controller: _searchTextController,
                                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                                  onChanged: (text) {
                                    coachBloc.add(CoachEvent.searchCoach(searchText: text));
                                  },
                                  decoration: InputDecoration(
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          _searchTextController.text = '';
                                          coachBloc.add(const CoachEvent.searchCoach(searchText: ''));
                                        },
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
                                          borderSide:
                                          const BorderSide(width: 1, color: AppColors.turquoise),
                                          borderRadius: BorderRadius.circular(30)),
                                      border: OutlineInputBorder(
                                          borderSide:
                                          const BorderSide(width: 1, color: AppColors.turquoise),
                                          borderRadius: BorderRadius.circular(30)),
                                      hintText: 'Поиск',
                                      hintStyle: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: AppColors.colorForHintText)),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    state.maybeMap(
                      loading: (_) => SliverToBoxAdapter(
                        child: Center(
                            child: Image.asset(
                              'images/bouncing-circles.gif',
                              height: 100,
                            ),
                        ),
                      ),
                      orElse: () => SliverList.builder(
                        itemCount: coachBloc.appUserList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final user = coachBloc.appUserList[index];
                          return DecoratedBox(
                            decoration: BoxDecoration(
                                color: AppColors.primaryButtonColor,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: boxShadow),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: ClipOval(
                                      child: user.urlAvatar?.contains('http') ?? false
                                          ? Image.network(
                                        user.urlAvatar!,
                                        fit: BoxFit.cover,
                                      )
                                          : Image.asset('images/icon.png'),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      user.name,
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          overflow: TextOverflow.ellipsis
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          coachBloc.add(CoachEvent.coachRequest(coach: user));
                                        },
                                        child: user.userId != coachBloc.localUser?.requestCoachId
                                            ? SvgPicture.asset(
                                          'images/mark.svg',
                                          height: 35,
                                          width: 35,
                                          colorFilter: const ColorFilter.mode(
                                            AppColors.turquoise,
                                            BlendMode.srcIn,
                                          ),
                                        )
                                            : const SizedBox(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
