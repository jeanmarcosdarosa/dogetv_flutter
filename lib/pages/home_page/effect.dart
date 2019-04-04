import 'package:dogetv_flutter/pages/category_page/page.dart';
import 'package:dogetv_flutter/pages/topic_page/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:dogetv_flutter/pages/home_page/action.dart';
import 'package:dogetv_flutter/pages/home_page/state.dart';
import 'package:dogetv_flutter/pages/tv_page/page.dart';
import 'package:dogetv_flutter/repository/movie.dart';

Effect<HomePageState> buildEffect() {
  return combineEffects(<Object, Effect<HomePageState>>{
    Lifecycle.initState: _init,
    HomePageAction.onFetch: _onFetch,
    HomePageAction.onShowTV: _onShowTV,
    HomePageAction.onShowTopic: _onShowTopic,
    HomePageAction.onShowLibrary: _onShowLibrary
  });
}

void _init(Action action, Context<HomePageState> ctx) async {
  APIs.getMovies().then((movies) {
    ctx.dispatch(HomePageActionCreator.didLoadAction(movies));
  });
}

void _onFetch(Action action, Context<HomePageState> ctx) async {
  APIs.getMovies().then((movies) {
    ctx.dispatch(HomePageActionCreator.didLoadAction(movies));
  });
}

void _onShowTV(Action action, Context<HomePageState> ctx) async {
  Navigator.of(ctx.context).push(MaterialPageRoute(builder: (context) {
    return TVPage().buildPage(null);
  }));
}

void _onShowLibrary(Action action, Context<HomePageState> ctx) async {
  Navigator.of(ctx.context).push(MaterialPageRoute(builder: (context) {
    return CategoryPage().buildPage(null);
  }));
}

void _onShowTopic(Action action, Context<HomePageState> ctx) async {
  Navigator.of(ctx.context).push(MaterialPageRoute(builder: (context) {
    return TopicDetailPage().buildPage(action.payload);
  }));
}
