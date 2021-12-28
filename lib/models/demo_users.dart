import 'package:flutter/material.dart';

const users = [
  userGordon,
  userSalvatore,
  userSacha,
  userRonaldo,
  userMessi,
  userReuben,
  userNash,
  userHoang,
  userlong,
  userToan,
  userViet,
  userThy,
];

const userHoang = DemoUser(
  id: 'Hoang',
  name: 'Trần Văn Hoàng',
  image:
  'https://s120-ava-talk.zadn.vn/5/1/1/3/9/120/5f4b9e30bd3ddd162839f8fd2fd9af32.jpg',
);

const userlong = DemoUser(
  id: 'Long',
  name: 'Mạnh Hùng Long',
  image:
  'https://png.pngtree.com/element_origin_min_pic/17/07/01/c94fa1c437bb1db26bc1bd12286e51c2.jpg',
);

const userToan = DemoUser(
  id: 'Toan',
  name: 'Nguyễn Viết Toàn',
  image:
  'https://s120-ava-talk.zadn.vn/6/d/3/9/44/120/bbea3e0f357a1338c93901575a59f025.jpg',
);

const userViet = DemoUser(
  id: 'Viet',
  name: 'Lê Văn Việt',
  image:
  'https://cover.talk.zdn.vn/default',
);

const userThy = DemoUser(
  id: 'Thy',
  name: 'Trương Bảo Thy',
  image:
  'https://cover-talk.zadn.vn/8/8/3/e/7/5879562575515eebd3db7fad35f78044.jpg',
);

const userGordon = DemoUser(
  id: 'gordon',
  name: 'Gordon Hayes',
  image:
  'https://pbs.twimg.com/profile_images/1262058845192335360/Ys_-zu6W_400x400.jpg',
);

const userSalvatore = DemoUser(
  id: 'salvatore',
  name: 'Salvatore Giordano',
  image:
  'https://pbs.twimg.com/profile_images/1252869649349238787/cKVPSIyG_400x400.jpg',
);

const userSacha = DemoUser(
  id: 'sacha',
  name: 'Sacha Arbonel',
  image:
  'https://pbs.twimg.com/profile_images/1199684106193375232/IxA9XLuN_400x400.jpg',
);

const userRonaldo = DemoUser(
  id: 'Ronaldo',
  name: 'Cristiano Ronaldo',
  image:
  'https://pbs.twimg.com/media/FFTo2ByXoBEN38_?format=jpg&name=medium',
);

const userMessi = DemoUser(
  id: 'Messi',
  name: 'Leo Messi',
  image:
  'https://pbs.twimg.com/media/FGBzM9sXEAAdhrM?format=jpg&name=small',
);

const userReuben = DemoUser(
  id: 'reuben',
  name: 'Reuben Turner',
  image:
  'https://pbs.twimg.com/profile_images/1370571324578480130/UxBBI30i_400x400.jpg',
);

const userNash = DemoUser(
  id: 'nash',
  name: 'Nash Ramdial',
  image:
  'https://pbs.twimg.com/profile_images/1436372495381172225/4wDDMuD8_400x400.jpg',
);

@immutable
class DemoUser {
  final String id;
  final String name;
  final String image;

  const DemoUser({
    required this.id,
    required this.name,
    required this.image,
  });
}
