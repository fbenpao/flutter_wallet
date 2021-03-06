import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_template/core/utils/toast.dart';
import 'package:flutter_template/core/widget/grid/grid_item.dart';
import 'package:flutter_template/core/widget/list/article_item.dart';
import 'package:flutter_template/core/widget/list/token_item.dart';
import 'package:flutter_template/utils/sputils.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class TabHomePage extends StatefulWidget {
  @override
  _TabHomePageState createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage> {
  int _count = 5;
  static Map<String,dynamic> _boolList = jsonDecode(SPUtils.getBool());


  @override
  Widget build(BuildContext context) {
    // print(_boolList);
    return EasyRefresh.custom(
      header: MaterialHeader(),
      footer: MaterialFooter(),
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _count = 5;
          });
        });
      },
      onLoad: () async {
        await Future.delayed(Duration(seconds: 1), () {
          setState(() {
            // _count += 3;
          });
        });
      },
      slivers: <Widget>[
        SliverToBoxAdapter(
            child: Padding(
                padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Text(
                  '币种列表',
                  style: TextStyle(fontSize: 18),
                ))),

        //=====列表=====//
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              TokenInfo info = tokens[index];
              return TokenItem(
                  imageUrl: info.imageUrl,
                  tokenName: info.tokenName,
                  address: info.address,
                  balance: info.balance,
                  rpcUrl: info.rpcUrl,
                 );
            },
            childCount: _count,
          ),
        ),
      ],
    );
  }

  final List<TokenInfo> tokens = [
    TokenInfo(
      'https://api.bool.network/bool-backstage/pic/token?c=BTC',
      'BTC',
      _boolList["btcAccount"]!= null?_boolList["btcAccount"]:"",
      '0',
      "http://btc:btc@bitcoin-core-testnet.blockchain-node"
      ,),
    TokenInfo(
        'https://api.bool.network/bool-backstage/pic/token?c=ETH',
        'ETH',
        _boolList["ethAccount"]!= null?_boolList["ethAccount"]:"",
          '0',
        "http://test-rpc-eth.blockchain-node"
      ,),
    TokenInfo(
        'https://api.bool.network/bool-backstage/pic/token?c=BOOL',
        'BOOL',
        _boolList["boolAccount"] != null?_boolList["boolAccount"]:"",
        '0',
        "ws://test-rpc-bool.buer.network:789"
      ,),
    TokenInfo(
        'https://api.bool.network/bool-backstage/pic/token?c=FIL',
        'FIL',
        _boolList["filAccount"] != null?_boolList["filAccount"]:"",
        '0',
        "http://test-rpc-fil.buer.network:789/rpc/v0"
      ,),
    TokenInfo(
        'https://api.bool.network/bool-backstage/pic/token?c=PAD',
        'PAD',
        _boolList["padAccount"] != null?_boolList["padAccount"]:"",
        '0',
        ""
      ,),
  ];
}
