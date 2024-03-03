import 'package:app1/bloc/user_image_bloc/user_image_bloc.dart';
import 'package:app1/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:app1/constants.dart';
import 'package:app1/router/router.dart';
import 'package:app1/widgets/avatar_wrap.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    String name = '';
    String email = '';
    String weightNow = '';
    String weightGoal = '';
    String height = '';
    String age = '';
    late bool avatarIsNotNull = false;
    Image avatar = Image.asset('images/icon.jpg');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
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
                              avatar = Image.file(image);
                              avatarIsNotNull = true;
                            },
                            error: (error) {
                              avatarIsNotNull = false;
                              avatar = Image.asset('images/icon.jpg');
                            },
                            deleteImage: () {
                              {
                                avatarIsNotNull = false;
                                avatar = Image.asset('images/icon.jpg');
                              }
                            });
                        return GestureDetector(
                          onTap: (){
                            showModalBottomSheet(context: context, builder:
                                (BuildContext context) => AvatarWrap(avatarIsNotNull: avatarIsNotNull));
                          },
                          child: Container(
                            height: 145,
                            width: 145,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: avatar.image
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.17),
                                    spreadRadius: 4,
                                    blurRadius: 10,
                                    offset: const Offset(0, -5),
                                  )
                                ]
                            ),
                          ),
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
          const SizedBox(
            height: 10
          ),
          BlocBuilder<UserInfoBloc, UserInfoState>(
              builder: (context, state){
                final localUser = context.read<UserInfoBloc>().localUser;
                if(localUser != null){
                  name = localUser.name;
                  email = localUser.email;
                }
                // else{
                //   if (state is! StopBuildUserInfoState) {
                //     BlocProvider.of<UserInfoBloc>(context).add(LocalUserInfoEvent());
                //   }
                // }
                return Text(name,
                    style: Theme.of(context).textTheme.titleLarge
                );
          }),
          const SizedBox(
              height: 10
          ),
          BlocBuilder<UserInfoBloc, UserInfoState>(
            builder: (context, state) {
              return Text(
                email,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall
              );
            },
          ),
          const SizedBox(
              height: 10
          ),
          Container(
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
                            colorFilter: const ColorFilter.mode(AppColors.textColor, BlendMode.srcIn),
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
                          colorFilter: const ColorFilter.mode(AppColors.textColor, BlendMode.srcIn),
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
        ],
      )
    );
  }
}