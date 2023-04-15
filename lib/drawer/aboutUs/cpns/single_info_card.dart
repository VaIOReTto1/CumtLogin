import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../config.dart';

final Color loginColorGreen1 = const Color(0xFF33CC99).withAlpha(255);
const Color loginColorGreen2 = Color.fromRGBO(66, 184, 131, 1);

class SingleInfoCard extends StatefulWidget {
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
  State<SingleInfoCard> createState() => _SingleInfoCardState();
}

class _SingleInfoCardState extends State<SingleInfoCard> {
  Color getBGC(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Theme.of(context).cardColor
        : Colors.grey.shade300;
  }

  Color getTextTileBGC(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white70
        : Colors.black54;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
        BoxShadow(
          offset: const Offset(8, 8),
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF383837).withAlpha(255)
              : Colors.black38,
          blurRadius: 15,
        ),
        BoxShadow(
          offset: const Offset(-8, -8),
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF4c4c4b).withAlpha(255)
              : Colors.white70,
          blurRadius: 15,
        )
      ]),
      width: MediaQuery.of(context).size.width * .86,
      child: ExpansionTile(
        collapsedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        tilePadding: const EdgeInsets.all(6),
        childrenPadding: const EdgeInsets.all(6),
        collapsedBackgroundColor: getBGC(context),
        backgroundColor: getBGC(context),
        title: SizedBox(
          width: UIConfig.borderRadiusBox * 2,
          height: UIConfig.borderRadiusBox * 2,
          child: Stack(children: [
            Positioned(
              top: -UIConfig.fontSizeMain * 1.6,
              child: SizedBox(
                width: UIConfig.fontSizeMain * 20,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: DefaultTextStyle.of(context).style.color,
                    ),
                  ),
                  subtitle: Text(
                    widget.subTitle,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: DefaultTextStyle.of(context).style.color,
                    ),
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: CircleAvatar(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(UIConfig.borderRadiusBox),
                        child: CachedNetworkImage(
                          imageUrl:
                              "http://q1.qlogo.cn/g?b=qq&nk=${widget.QNumber}&s=640",
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
            ),
          ]),
        ),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '「${widget.personalSig}」',
                style: TextStyle(color: getTextTileBGC(context)),
              ),
              SizedBox(
                height: UIConfig.marginVertical * 2,
              ),
              SizedBox(
                height: UIConfig.marginVertical * 1.5,
              ),
              buildInfoLinkRow(context),
              SizedBox(
                height: UIConfig.marginVertical * 1.5,
              ),
              buildBlogLinkRow(context),
              SizedBox(
                height: UIConfig.marginVertical * 1.5,
              ),
              buildGitLinkRow(context),
            ],
          ),
        ],
      ),
    );
  }

  Row buildGitLinkRow(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.add,
          size: UIConfig.fontSizeMin * 2.5,
          // MdiIcons.github,
          color: getTextTileBGC(context),
        ),
        SizedBox(
          width: UIConfig.marginHorizontal * 2,
        ),
        InkWell(
          child: SizedBox(
            width: UIConfig.borderRadiusButton * 12.5,
            child: Text(widget.githubUrl,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: loginColorGreen2,
                )),
          ),
          onTap: () {
            launchUrl(Uri.parse(widget.githubUrl));
          },
        ),
      ],
    );
  }

  Row buildBlogLinkRow(BuildContext context) {
    return Row(
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
              widget.blogUrl,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                color: loginColorGreen2,
              ),
            ),
          ),
          onTap: () {
            launchUrl(Uri.parse(widget.blogUrl));
          },
        ),
      ],
    );
  }

  Row buildInfoLinkRow(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.add,
          // MdiIcons.qqchat,
          size: UIConfig.fontSizeMin * 2.5,
          color: getTextTileBGC(context),
        ),
        SizedBox(
          width: UIConfig.marginHorizontal * 2,
        ),
        InkWell(
          child: Text(widget.QNumber,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: loginColorGreen2)),
          onTap: () {
            launchUrl(Uri.parse(widget.qLaunchUrl),
                mode: LaunchMode.externalApplication);
          },
        ),
      ],
    );
  }
}
