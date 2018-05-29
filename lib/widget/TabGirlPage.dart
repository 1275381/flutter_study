import 'package:flutter/material.dart';
import 'package:flutter_study/model/FLModel.dart';
import 'package:flutter_study/mvp/presenter/FLPresenterImpl.dart';
import 'package:flutter_study/mvp/presenter/FLPresenter.dart';

class GirlsAppPage extends StatefulWidget {
  GirlsAppPage({Key key}) : super(key: key);

  @override
  _GirlsAppPageState createState() {
    _GirlsAppPageState view = new _GirlsAppPageState();
    FLPresenterImpl presenter = new FLPresenterImpl(view);
    presenter.init();
    return view;
  }
}

class _GirlsAppPageState extends State<GirlsAppPage> with WidgetsBindingObserver implements FLView {

  AppLifecycleState _lastLifecyleState;

  List<FLModel> datas = [];

  FLPresenterImpl _flPresenter;

  @override
  void initState() {
    super.initState();
    _loadData(1, 10);
    WidgetsBinding.instance.addObserver(this);
    print('initState');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    print('dispose');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    switch(state) {
      case AppLifecycleState.paused:
        print('AppLifecycleState.paused');
        break;
      case AppLifecycleState.resumed:
        print('AppLifecycleState.resumed');
        break;
      default:
        break;
    }

//
//    setState(() {
//      _lastLifecyleState = state;
//    });
  }

  _loadData(int pageNum,int pageSize){
    _flPresenter.loadFLData(1, 10);
  }

  @override
  Widget build(BuildContext context) {
    var content;

    if (datas == null) {
      content = new Center(
        // 可选参数 child:
        child: new CircularProgressIndicator(),
      );
    } else {
      content = new ListView.builder(
        itemCount: datas.length,
        itemBuilder: buildCard,
      );
    }

    return content;
  }

  Widget buildCard(BuildContext context, int index) {
    final String item = datas[index].url;
    return new Card(
      child: new Image.network(item),
    );
  }

  @override
  void onloadFLFail() {
    // TODO: implement onloadFLFail
  }

  @override
  void onloadFLSuc(List<FLModel> list) {
    if (!mounted) return; //异步处理，防止报错
    setState(() {
      datas = list;
    });
  }

  @override
  setPresenter(FLPresenter presenter) {
    // TODO: implement setPresenter
    _flPresenter = presenter;
  }
}

class TabGirlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new GirlsAppPage(),
    );
  }
}