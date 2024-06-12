import 'package:app1/internal/bloc/coach/coach_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      if(_scrollController.offset <= 100){
        _opacity = 1 - (_scrollController.offset / 100 * (100 - _scrollController.offset) / 100).clamp(0.0, 0.7);
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
            body: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                          if(_scrollController.offset <= 100){
                            _opacity = 1 - (_scrollController.offset / 100 * (100 - _scrollController.offset) / 100).clamp(0.0, 0.8);
                          } else{
                            _opacity = 0.2;
                          }
                          return AnimatedOpacity(
                            duration: animationDurationFast,
                            opacity: _opacity,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(7, 7, 7, 10),
                              child: TextField(
                                controller: _searchTextController,
                                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                                decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () => _searchTextController.text = '',
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
                                        borderSide: const BorderSide(width: 1, color: AppColors.turquoise),
                                        borderRadius: BorderRadius.circular(30)),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(width: 1, color: AppColors.turquoise),
                                        borderRadius: BorderRadius.circular(30)),
                                    hintText: 'Поиск',
                                    hintStyle: Theme.of(context)
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
                  SliverToBoxAdapter(
                    child: const SizedBox(height: 2000, width: 300,),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
