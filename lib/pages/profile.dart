import 'package:app1/bloc/userImage/user_image_bloc.dart';
import 'package:app1/bloc/userInfo/user_info_bloc.dart';
import 'package:app1/constants.dart';
import 'package:app1/pages/authorizationPage.dart';
import 'package:app1/pages/editingProfile.dart';
import 'package:app1/widgets/avatarWrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatelessWidget {

  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    String name = '';
    String email = '';
    String weightNow = '';
    String weightGoal = '';
    String height = '';
    String age = '';
    late bool avatarIsNotNull = false;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    Image avatar = Image.asset('images/icon.jpg');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(137, 195, 232, 0.3),
                          spreadRadius: 5,
                          blurRadius: 13,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    width: screenWidth,
                    height: screenWidth / 27  * 13,
                    child: SvgPicture.asset(
                      'images/waves.svg',
                      colorFilter: const ColorFilter.mode(
                          Colors.transparent, BlendMode.color),
                      // Применение прозрачного фильтра
                      width: screenWidth,
                    )
                ),
                Padding(padding: EdgeInsets.only(top: screenWidth / 27  * 13 - screenHeight/12, left: screenWidth/2 - screenHeight/12),
                    child: BlocBuilder<UserImageBloc, UserImageState>(
                        builder: (context, state){
                          if(state is UserImageInitial){
                            BlocProvider.of<UserImageBloc>(context).add(LoadImageEvent());
                          }
                          if(state is LoadImageState){
                            avatar = Image.file(state.image);
                            avatarIsNotNull = true;
                          }
                          if(state is UserImageNullState || state is DeleteImageState){
                            avatarIsNotNull = false;
                            avatar = Image.asset('images/icon.jpg');
                          }
                          return GestureDetector(
                            onTap: (){
                              showModalBottomSheet(context: context, builder:
                                  (BuildContext context) => AvatarWrap(avatarIsNotNull: avatarIsNotNull));
                            },
                            child: Container(
                              height: screenHeight/6,
                              width: screenHeight/6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(360),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: avatar.image
                                  ),
                                  boxShadow: [BoxShadow(
                                    color: Colors.black.withOpacity(0.17),
                                    spreadRadius: 4,
                                    blurRadius: 10,
                                    offset: const Offset(0, -5),
                                  )]
                              ),
                            ),
                          );
                        })
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight/30, left: screenWidth/1.22),
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<UserInfoBloc>(context).add(LocalUserInfoEvent());
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditingProfile()));
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.transparent,
                        shadowColor: Colors.transparent
                    ),
                    child: SvgPicture.asset(
                      'images/editing.svg',
                      width: screenHeight / 27,
                      height: screenHeight / 27,
                      colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: screenHeight/70)),
            Padding(padding: EdgeInsets.only(top: screenHeight/70)),
            BlocBuilder<UserInfoBloc, UserInfoState>(builder: (context, state){
              if (state is LocalUserInfoState){
                name = state.appUser.name;
                email = state.appUser.email;
              }
              else{
                if (state is! StopBuildUserInfoState) {
                  BlocProvider.of<UserInfoBloc>(context).add(LocalUserInfoEvent());
                }
              }
              return Text(name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 30,
                  color: AppColors.dark
                )
              );
            }),
            Padding(padding: EdgeInsets.only(top: screenHeight/100)),
            BlocBuilder<UserInfoBloc, UserInfoState>(
              builder: (context, state) {
                return Text(
                  email,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.dark
                  )
                );
              },
            ),
            Padding(padding: EdgeInsets.only(top: screenHeight/70)),
            Container(
                width: screenWidth * 0.95,
                height: screenHeight/5.2,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 13,
                      offset: const Offset(10, 10),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: BlocBuilder<UserInfoBloc, UserInfoState>(builder: (context, state){
                  if (state is LocalUserInfoState){
                    weightNow = state.appUser.weightNow?.toString() ?? '—';
                    weightGoal = state.appUser.weightGoal?.toString() ?? '—';
                    height = state.appUser.height?.toString() ?? '—';
                    age = state.appUser.age?.toString() ?? '—';
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: screenHeight/50, left: screenWidth/50, right: screenWidth/20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: screenHeight/15,
                              child: SvgPicture.asset(
                                'images/weight.svg',
                                width: screenHeight/20,
                                height: screenHeight/20,
                                colorFilter: const ColorFilter.mode(Color(0xff2D2D2D), BlendMode.srcIn),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight/17,
                              width: screenWidth/4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    weightNow,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: const Color(0xff2D2D2D)
                                    )
                                  ),
                                  Text(
                                    'Сейчас',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        color: const Color(0xff2D2D2D)
                                    )
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screenHeight/17,
                              width: screenWidth/4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      weightGoal,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: const Color(0xff2D2D2D)
                                      )
                                  ),
                                  Text(
                                    'Цель',
                                    overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          color: const Color(0xff2D2D2D)
                                      )
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: screenHeight/40, left: screenWidth/50, right: screenWidth/20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: screenHeight/15,
                              child: SvgPicture.asset(
                                'images/people.svg',
                                width: screenHeight/20,
                                height: screenHeight/20,
                                colorFilter: const ColorFilter.mode(Color(0xff2D2D2D), BlendMode.srcIn),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight/17,
                              width: screenWidth/4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    height,
                                    overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: const Color(0xff2D2D2D)
                                      )
                                  ),
                                  Text(
                                      'Рост',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          color: const Color(0xff2D2D2D)
                                      )
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screenHeight/17,
                              width: screenWidth/4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(age,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: const Color(0xff2D2D2D)
                                      )
                                  ),
                                  Text(
                                    'Возраст',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        color: const Color(0xff2D2D2D)
                                    )
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                    ],
                  );
                })
            ),
            Padding(padding: EdgeInsets.only(top: screenHeight/3.8)),

          ],
        ),
      )
    );
  }
}