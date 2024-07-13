import 'package:app1/internal/bloc/wards_bloc/wards_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/router/router.dart';
import 'package:app1/presentation/widgets/custom_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class WardsListPage extends StatelessWidget {
  const WardsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final WardsBloc wardsBloc = context.read<WardsBloc>();
    wardsBloc.add(const WardsEvent.getWardsListEvent());
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Подопечные',
      ),
      body: BlocBuilder<WardsBloc, WardsState>(
        builder: (context, state){
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(7, 10, 7, 20),
            itemCount: wardsBloc.wardsList.length,
            itemBuilder: (context, index){
              final user = wardsBloc.wardsList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: (){
                    wardsBloc.getInfoAboutWard(user);
                    context.router.replace(const WardRoute());
                  },
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
                            child: Text(
                              user.name,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),
                          ),
                        ],
                      ),
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
