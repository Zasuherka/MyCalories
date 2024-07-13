import 'package:app1/internal/bloc/wards_bloc/wards_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/widgets/custom_app_bar.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class WardsRequestsPage extends StatelessWidget {
  const WardsRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final WardsBloc wardsBloc = context.read<WardsBloc>();
    wardsBloc.add(const WardsEvent.getWardRequestsListEvent());
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Заявки на тренерство',
      ),
      body: BlocBuilder<WardsBloc, WardsState>(
        builder: (context, state){
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(7, 10, 7, 20),
            itemCount: wardsBloc.wardRequestsList.length,
            itemBuilder: (context, index){
              final user = wardsBloc.wardRequestsList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: DecoratedBox(
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
                                wardsBloc.add(WardsEvent.replyWards(appUser: user, reply: true));
                              },
                              child: SvgPicture.asset(
                                'images/mark.svg',
                                height: 35,
                                width: 35,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.turquoise,
                                  BlendMode.srcIn,
                                ),
                              )
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                                onTap: () {
                                  wardsBloc.add(WardsEvent.replyWards(appUser: user, reply: false));
                                },
                                child: SvgPicture.asset(
                                  'images/delete.svg',
                                  height: 32,
                                  width: 32,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.red,
                                    BlendMode.srcIn,
                                  ),
                                )
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
