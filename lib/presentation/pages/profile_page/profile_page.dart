import 'package:app1/internal/bloc/user_image_bloc/user_image_bloc.dart';
import 'package:app1/internal/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/router/router.dart';
import 'package:app1/presentation/pages/profile_page/widgets/avatar_wrap.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    const Widget verticalOffset = SliverToBoxAdapter(
      child: SizedBox(
          height: 10
      ),
    );
    String name = '';
    String email = '';
    String weightNow = '';
    String weightGoal = '';
    String height = '';
    String age = '';

    final localUser = context.read<UserInfoBloc>().localUser;
    if(localUser != null){
      name = localUser.name;
      email = localUser.email;
    }

    late bool avatarIsNotNull = false;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
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
                    child: BlocBuilder<UserImageBloc, UserImageState>(
                        builder: (context, state){
                          state.whenOrNull(
                            // initial: () {
                            //   BlocProvider.of<UserImageBloc>(context).add(LoadImageEvent());
                            // },
                              loadImage: (image) {
                                avatarIsNotNull = true;
                              },
                              error: (error) {
                                avatarIsNotNull = false;
                              },
                              deleteImage: () {
                                {
                                  avatarIsNotNull = false;
                                }
                              });
                          return GestureDetector(
                            onTap: (){
                              showModalBottomSheet(context: context, builder:
                                  (BuildContext context) => AvatarWrap(avatarIsNotNull: avatarIsNotNull));
                            },
                            child: SizedBox(
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
                                    child: localUser?.urlAvatar?.contains('http') ?? false
                                        ? Image.network(
                                      localUser!.urlAvatar!,
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


                            //
                            // Container(
                            //   height: 145,
                            //   width: 145,
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(360),
                            //       image: DecorationImage(
                            //           fit: BoxFit.cover,
                            //           image: avatar.image
                            //       ),
                            //       boxShadow: [
                            //         BoxShadow(
                            //           color: Colors.black.withOpacity(0.17),
                            //           spreadRadius: 4,
                            //           blurRadius: 10,
                            //           offset: const Offset(0, -5),
                            //         )
                            //       ]
                            //   ),
                            // ),
                          );
                        })
                ),
                Positioned(
                  top: 37,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      context.router.push(const EditingProfileRoute());
                    },
                    child: SvgPicture.asset(
                      'images/editing.svg',
                      width: 32,
                      height: 32,
                      colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                ),
              ],
            ),
          ),
          verticalOffset,
          SliverToBoxAdapter(
            child: Text(name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge
            ),
          ),
          verticalOffset,
          SliverToBoxAdapter(
            child: Text(
                email,
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
                  child: BlocBuilder<UserInfoBloc, UserInfoState>(builder: (context, state){
                    final localUser = context.read<UserInfoBloc>().localUser;
                    if(localUser != null){
                      weightNow = localUser.weightNow?.toString() ?? '—';
                      weightGoal = localUser.weightGoal?.toString() ?? '—';
                      height = localUser.height?.toString() ?? '—';
                      age = localUser.age?.toString() ?? '—';
                    }
                    return Column(
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
                                      weightNow,
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
                                      weightGoal,
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
                                      height,
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
                                  Text(age,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.titleLarge
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
                    );
                  })
              ),
            ),
          ),
          //const SliverToBoxAdapter(child: News())
        ],
      )
    );
  }
}