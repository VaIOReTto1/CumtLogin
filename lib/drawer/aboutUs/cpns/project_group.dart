import 'package:flutter/material.dart';

import '../../../config.dart';
import 'package:cumt_login/drawer/aboutUs/cpns/single_info_card.dart';

class ProjectGroup extends StatelessWidget {
  const ProjectGroup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: UIConfig.fontSizeSubMain * 1.8,
        ),
        const SingleInfoCard(
          title: "叶典林",
          subTitle: '22级大数据2班',
          QNumber: '1302140648',
          githubUrl: 'https://github.com/VaIOReTto1',
          blogUrl: 'https://blog.csdn.net/VaIOReTto1?spm=1000.2115.3001.5343',
          personalSig: 'キエテシマオウ',
          qLaunchUrl: 'https://qm.qq.com/cgi-bin/qm/qr?k=5oOH3MdCC4TuB-GRkMg5BJFO5mqRhcrk&noverify=0',
        ),
        SizedBox(
          height: UIConfig.fontSizeSubMain * 1.8,
        ),
        const SingleInfoCard(
          title: "冯梓晨",
          subTitle: '22级计科3班',
          QNumber: '1486008923',
          githubUrl: 'https://github.com/w6rsty',
          blogUrl: 'https://w6rsty.github.io/',
          personalSig: '我在追光',
          qLaunchUrl:
          'https://qm.qq.com/cgi-bin/qm/qr?k=938q-5u__YgrZRAuNiFrGdXe5nunIQCU&noverify=0&personal_qrcode_source=4',
        ),
        SizedBox(
          height: UIConfig.fontSizeSubMain * 1.8,
        ),
        const SingleInfoCard(
          title: "牟金腾",
          subTitle: '19级大数据2班',
          QNumber: '1004275481',
          githubUrl: 'https://github.com/cnatom/',
          blogUrl: 'https://blog.csdn.net/qq_15989473?type=blog',
          qLaunchUrl:
          'https://qm.qq.com/cgi-bin/qm/qr?k=Io1xjbyMFhZIFoZzdR2aAdjLjvGI5E9f&noverify=0',
          personalSig: '喜欢就坚持吧',
        ),
        SizedBox(
          height: UIConfig.fontSizeSubMain * 1.8,
        ),
        const SingleInfoCard(
          title: "蒋昀松",
          subTitle: '22级大数据2班',
          QNumber: '2557978317',
          githubUrl: 'https://github.com/Jyjays',
          blogUrl: 'https://www.yuque.com/yuqueyonghuzk6ln0',
          personalSig: 'be mortal but not ordinary',
          qLaunchUrl:
          'https://qm.qq.com/cgi-bin/qm/qr?k=uPW3vi2vaFw1U0yCJEal-pm12TJJ-5zT&noverify=0&personal_qrcode_source=4',
        ),
        SizedBox(
          height: UIConfig.fontSizeSubMain * 1.8,
        ),
        const SingleInfoCard(
          title: "谭重阳",
          subTitle: '21级大数据3班',
          QNumber: '2452841017',
          githubUrl: 'https://github.com/blankAnswer',
          blogUrl: 'https://www.yuque.com/blankanswer',
          personalSig: '我其实更希望你可以，'
              '好好地吃一顿饭，'
              '感受你所在的世界的美好，'
              '好吗？',
          qLaunchUrl:
          'https://qm.qq.com/cgi-bin/qm/qr?k=71RsughhRrrughL-Tsh5LJ8fYoojn9yx&noverify=0&personal_qrcode_source=3',
        ),
        SizedBox(
          height: UIConfig.fontSizeSubMain * 1.8,
        ),
        const SingleInfoCard(
          title: "唐嘉诣",
          subTitle: '22级人工智能4班',
          QNumber: '1665534874',
          githubUrl: 'https://github.com/sanwu-maizi',
          blogUrl: 'https://blog.csdn.net/Oven_maizi?spm=1011.2480.3001.5343',
          personalSig: '节能中_(•ω• 」∠)_',
          qLaunchUrl:
          'https://qm.qq.com/cgi-bin/qm/qr?k=36rePLfT1IXIfTPrxNXnFLJ5VIHbpNjG&noverify=0&personal_qrcode_source=4',
        ),
        SizedBox(
          height: UIConfig.fontSizeSubMain * 1.8,
        ),
        const SingleInfoCard(
          title: "孙志豪",
          subTitle: '22级计科4班',
          QNumber: '2930877510',
          githubUrl: 'https://github.com/xiangxinliao43',
          blogUrl: 'mirrso.icu',
          personalSig: 'nULL',
          qLaunchUrl:
          'https://qm.qq.com/cgi-bin/qm/qr?k=QA35pFWmWonZ_KDs_ZFGPtaqBlXW1ZMh&noverify=0&personal_qrcode_source=4',
        ),
        SizedBox(
          height: UIConfig.fontSizeSubMain * 1.8,
        ),
        const SingleInfoCard(
          title: "朱恒",
          subTitle: '21级人工智能1班',
          QNumber: '1444731301',
          githubUrl: 'https://github.com/morandave',
          blogUrl: 'https://juejin.cn/user/2747006511498904',
          personalSig: '世界上只有10种人，一种懂二进制，一种不懂',
          qLaunchUrl:
          'https://qm.qq.com/cgi-bin/qm/qr?k=UDn0TfGSrAEzAD_J8iauosNNWCfV8KcD&noverify=0&personal_qrcode_source=4',
        ),
        SizedBox(
          height: UIConfig.fontSizeSubMain * 1.8,
        ),
      ],
    );
  }
}