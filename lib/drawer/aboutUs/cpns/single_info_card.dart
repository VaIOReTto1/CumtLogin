import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../config.dart';


final Color loginColorGreen1 = const Color(0xFF33CC99).withAlpha(255);
const Color loginColorGreen2 = Color.fromRGBO(66, 184, 131, 1);

class SingleInfoCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String QNumber;
  final String githubUrl;
  final String blogUrl;
  final String personalSig;
  final String qLaunchUrl;

  const SingleInfoCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.QNumber,
    required this.githubUrl,
    required this.blogUrl,
    required this.personalSig,
    required this.qLaunchUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.primary == Colors.blue
              ? Colors.grey.shade300
              : Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              offset: const Offset(8, 8),
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color(0xFF383837).withAlpha(255)
                  : Colors.black38,
              blurRadius: 15,
            ),
            BoxShadow(
              offset: const Offset(-8, -8),
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color(0xFF4c4c4b).withAlpha(255)
                  : Colors.white70,
              blurRadius: 15,
            )
          ]),
      width: MediaQuery.of(context).size.width * .86,
      child: GFAccordion(
        collapsedTitleBackgroundColor:
            Theme.of(context).colorScheme.primary == Colors.blue
                ? Colors.grey.shade300
                : Theme.of(context).colorScheme.primary,
        expandedTitleBackgroundColor:
            Theme.of(context).colorScheme.primary == Colors.blue
                ? Colors.grey.shade300
                : Theme.of(context).colorScheme.primary,
        contentBackgroundColor:
            Theme.of(context).colorScheme.primary == Colors.blue
                ? Colors.grey.shade300
                : Theme.of(context).colorScheme.primary,
        titleChild: SizedBox(
          width: UIConfig.borderRadiusBox * 2,
          height: UIConfig.borderRadiusBox * 2,
          child: Stack(children: [
            Positioned(
              top: -UIConfig.fontSizeMain * 1.5,
              child: SizedBox(
                width: UIConfig.fontSizeMain * 20,
                child: ListTile(
                  // dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    subTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: GFAvatar(
                    size: UIConfig.borderRadiusBox * 1.2,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(UIConfig.borderRadiusBox),
                      child: CachedNetworkImage(
                        imageUrl: "http://q1.qlogo.cn/g?b=qq&nk=$QNumber&s=640",
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
        // title: 'gf accordion',
        contentChild: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '「$personalSig」',
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white70
                      : Colors.black54),
            ),
            SizedBox(
              height: UIConfig.marginVertical * 2,
            ),
            SizedBox(
              height: UIConfig.marginVertical * 1.5,
            ),
            Row(
              children: [
                Icon(
                  // Icons.add,
                  MdiIcons.qqchat,
                  size: UIConfig.fontSizeMin * 2.5,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white70
                      : Colors.black45,
                ),
                SizedBox(
                  width: UIConfig.marginHorizontal * 2,
                ),
                InkWell(
                  child: Text(QNumber,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color:loginColorGreen2
                      )),
                  onTap: () {
                    launchUrl(Uri.parse(qLaunchUrl),
                        mode: LaunchMode.externalApplication);
                  },
                ),
              ],
            ),
            SizedBox(
              height: UIConfig.marginVertical * 1.5,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_history,
                  size: UIConfig.fontSizeMin * 2.5,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white70
                      : Colors.black45,
                ),
                SizedBox(
                  width: UIConfig.marginHorizontal * 2,
                ),
                InkWell(
                  child: SizedBox(
                    width: UIConfig.borderRadiusButton * 12.5,
                    child: Text(
                      blogUrl,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: loginColorGreen2,
                      ),
                    ),
                  ),
                  onTap: () {
                    launchUrl(Uri.parse(blogUrl));
                  },
                ),
              ],
            ),
            SizedBox(
              height: UIConfig.marginVertical * 1.5,
            ),
            Row(
              children: [
                Icon(
                  MdiIcons.github,
                  // Icons.add,
                  size: UIConfig.fontSizeMin * 2.5,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white70
                      : Colors.black45,
                ),
                SizedBox(
                  width: UIConfig.marginHorizontal * 2,
                ),
                InkWell(
                  child: SizedBox(
                    width: UIConfig.borderRadiusButton * 12.5,
                    child: Text(githubUrl,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: loginColorGreen2,
                        )),
                  ),
                  onTap: () {
                    launchUrl(Uri.parse(githubUrl));
                  },
                ),
              ],
            ),
          ],
        ),
        contentBorderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
