import 'package:app1/domain/model/collection_view.dart';
import 'package:app1/internal/bloc/colletion_bloc/collection_bloc.dart';
import 'package:app1/internal/bloc/food_bloc/food_bloc.dart';
import 'package:app1/presentation/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app1/presentation/constants.dart';


@RoutePage()
class CollectionsPage extends StatefulWidget {
  final bool isAddEatingFood;
  const CollectionsPage({super.key, required this.isAddEatingFood});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {

  String _searchText = '';

  final TextEditingController _searchTextController = TextEditingController();

  final BoxDecoration _activeDecoration = BoxDecoration(
    gradient: AppColors.greenGradient,
    borderRadius: BorderRadius.circular(25)
  );
  final BoxDecoration _inactiveDecoration = BoxDecoration(
      color: AppColors.primaryButtonColor,
      borderRadius: BorderRadius.circular(25)
  );

  bool _isUserCollections = true;

  void _searchListener(){
    if(_searchTextController.text == ' '){
      _searchTextController.text = '';
      return;
    }
    _searchText = _searchTextController.text;
    BlocProvider.of<CollectionBloc>(context)
        .add(CollectionEvent.getGlobalListCollection(searchText: _searchText));
  }

  @override
  void initState() {
    super.initState();
    _searchTextController.addListener(_searchListener);
    BlocProvider.of<CollectionBloc>(context).add(const CollectionEvent.getUserListCollection());
  }

  @override
  Widget build(BuildContext context) {
    final collection = context.watch<CollectionBloc>().listCollectionView;
    List<CollectionView> findCollection = [];
    bool stateIsNotLoading = true;
    context.watch<CollectionBloc>().state.whenOrNull(
        loading: () => stateIsNotLoading = false,
        globalListCollection: (list) {
          if(!_isUserCollections){
            findCollection = list;
          }
        }
    );
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              toolbarHeight: MediaQuery.of(context).padding.top + 20,
              //expandedHeight: MediaQuery.of(context).padding.top + 20,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: AppColors.greenGradient
                ),),
              title: const Text('Ныборы еды'),
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(
                    maxWidth: 33,
                    maxHeight: 33,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'images/arrow.svg',
                      width: 33,
                      height: 33,
                      colorFilter:
                      const ColorFilter.mode(AppColors.primaryButtonColor, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
              actions: [
                !widget.isAddEatingFood ? Padding(padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<FoodBloc>(context).add(const FoodEvent.getFoodList());
                      context.router.push(const CreateCollectionRoute());
                    },
                    child: SvgPicture.asset(
                      'images/plus.svg',
                      width: 33,
                      height: 33,
                      colorFilter:
                      const ColorFilter.mode(AppColors.primaryButtonColor, BlendMode.srcIn),
                    ),
                  ),
                ) : const SizedBox()
              ],
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: !widget.isAddEatingFood ? 10 : 0,
              ),
            ),
            SliverToBoxAdapter(
              child: !widget.isAddEatingFood ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  const SizedBox(
                    width: 12.5,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() {
                        _isUserCollections = true;
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.center,
                        decoration: _isUserCollections ? _activeDecoration : _inactiveDecoration,
                        child: Text(
                            'Мои коллекции',
                            style: _isUserCollections ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.primaryButtonColor
                            ) : Theme.of(context).textTheme.bodyMedium
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() {
                        _isUserCollections = false;
                      }),
                      child: Container(
                        width: screenWidth * 0.4,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.center,
                        decoration: !_isUserCollections ? _activeDecoration : _inactiveDecoration,
                        child: Text(
                          'Поиск',
                          style: _isUserCollections
                              ? Theme.of(context).textTheme.bodyMedium
                              : Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.primaryButtonColor
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.5,
                  ),
                ],
              ) : const SizedBox(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: !_isUserCollections ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: TextField(
                  controller: _searchTextController,
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
                          borderSide: const BorderSide(
                              width: 1,
                              color: AppColors.turquoise
                          ),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1,
                              color: AppColors.turquoise
                          ),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      hintText: 'Поиск',
                      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.colorForHintText
                      )
                  ),
                ),
              ) : const SizedBox(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            stateIsNotLoading ? SliverList.builder(
                itemCount: _isUserCollections
                    ? collection.length
                    : findCollection.length,
                itemBuilder: (BuildContext context, int index){
                  final list = _isUserCollections
                      ? collection
                      : findCollection;
                  index = list.length - 1 - index;
                  return GestureDetector(
                    onTap: () => context
                        .router.push(CollectionRoute(collectionId: list[index].id)),
                    child: Container(
                      margin: const EdgeInsets.only(
                          bottom: 8,
                          left: 7,
                          right: 7
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.elementColor,
                          boxShadow: boxShadow,
                          borderRadius: BorderRadius.circular(25.0)),
                      padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: 20),
                      child: Text(
                        list[index].title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  );
                }) :
            SliverToBoxAdapter(
              child: //SvgPicture.asset('images/bouncing-circles.svg')
              Image.asset(
                'images/bouncing-circles.gif',
                height: 100,
              ),
            ),
          ],
        ),
      )
    );
  }
}