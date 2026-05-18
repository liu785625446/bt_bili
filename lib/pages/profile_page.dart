import 'package:bt_bili/http/core/bt_error.dart';
import 'package:bt_bili/http/dao/profile_dao.dart';
import 'package:bt_bili/models/profile_model.dart';
import 'package:bt_bili/util/toast.dart';
import 'package:bt_bili/util/view_util.dart';
import 'package:bt_bili/widget/benefit_card.dart';
import 'package:bt_bili/widget/bt_blur.dart';
import 'package:bt_bili/widget/bt_flexible_header.dart';
import 'package:bt_bili/widget/course_card.dart';
import 'package:bt_bili/widget/home/bt_banner.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileModel? _profileModel;

  /// 本地选取的头像，仅当前会话预览
  String? _localAvatarPath;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showAvatarSourceSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('拍照'),
              onTap: () {
                Navigator.pop(ctx);
                _pickAvatar(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('从相册选择'),
              onTap: () {
                Navigator.pop(ctx);
                _pickAvatar(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickAvatar(ImageSource source) async {
    final x = await ImagePicker().pickImage(source: source);
    if (!mounted || x == null) return;
    setState(() => _localAvatarPath = x.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[_buildAppBar()];
        },
        body: ListView(
          padding: EdgeInsets.only(top: 8),
          children: [...buildContentList()],
        ),
      ),
    );
  }

  void _loadData() async {
    try {
      var result = await ProfileDao.get();
      setState(() {
        _profileModel = result as ProfileModel;
      });
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on BtNetError catch (e) {
      showWarnToast(e.message);
    }
  }

  _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 160,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        titlePadding: EdgeInsets.only(left: 0),
        title: _buildHead(),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: cachedImage(
                "https://www.devio.org/img/beauty_camera/beauty_camera4.jpg",
              ),
            ),
            Positioned.fill(child: BtBlur(sigma: 20)),
            Positioned(bottom: 0, left: 0, right: 0, child: _buildProfileTab()),
          ],
        ),
      ),
    );
  }

  buildContentList() {
    if (_profileModel == null) {
      return [];
    }
    return [
      _buildBanner(),
      CourseCard(courseList: _profileModel?.courseList ?? []),
      BenefitCard(benefitList: _profileModel?.benefitList ?? []),
    ];
  }

  _buildBanner() {
    return BtBanner(
      bannerList: _profileModel?.bannerList ?? [],
      bannerHeight: 120,
      padding: EdgeInsets.only(left: 10, right: 10),
    );
  }

  Widget? _buildHead() {
    if (_profileModel == null) return Container();
    return BtFlexibleHeader(
      name: _profileModel?.name ?? "",
      face: _profileModel?.face ?? "",
      localAvatarPath: _localAvatarPath,
      onAvatarTap: _showAvatarSourceSheet,
      scrollController: _scrollController,
    );
  }

  Widget _buildProfileTab() {
    if (_profileModel == null) return Container();

    return Container(
      padding: EdgeInsets.only(bottom: 5, top: 5),
      decoration: BoxDecoration(color: Colors.white30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText("收藏", _profileModel?.favorite ?? 0),
          _buildIconText("点赞", _profileModel?.like ?? 0),
          _buildIconText("浏览", _profileModel?.browsing ?? 0),
          _buildIconText("金币", _profileModel?.coin ?? 0),
          _buildIconText("粉丝", _profileModel?.fans ?? 0),
        ],
      ),
    );
  }

  Column _buildIconText(String name, int count) {
    return Column(
      children: [
        Text('$count', style: TextStyle(fontSize: 15, color: Colors.black87)),
        Text(name, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}
