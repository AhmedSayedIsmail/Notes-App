// ignore_for_file: prefer_final_fields
class IconsAssets {
  static IconsAssets _instance = IconsAssets._internal();
  factory IconsAssets() {
    return _instance;
  }
  IconsAssets._internal();
  Map<IconName, String> assets = {
    IconName.menu: "assets/icons/menu2.svg",
    IconName.search: "assets/icons/search.svg",
    IconName.notification: "assets/icons/notification1.svg",
    IconName.backarrow: "assets/icons/arrow-left.svg",
    IconName.forwardarrow: "assets/icons/arrow-right.svg",
    IconName.todoicon: "assets/icons/todotxt.svg",
    IconName.categoryicon: "assets/icons/category-icon.svg",
    IconName.soundgraphic: "assets/icons/sound-graphic.svg",
    IconName.airplan: "assets/icons/airplane.svg",
    IconName.car: "assets/icons/car.svg",
    IconName.cooking: "assets/icons/cooking.svg",
    IconName.payment: "assets/icons/dollar-symbol.svg",
    IconName.work: "assets/icons/work.svg",
    IconName.health: "assets/icons/health.svg",
    IconName.vacation: "assets/icons/vacation.svg",
    IconName.gift: "assets/icons/gift.svg",
    IconName.meeting: "assets/icons/calendar.svg",
    IconName.ideas: "assets/icons/idea.svg",
    IconName.fastfood: "assets/icons/food.svg",
    IconName.footballMatch: "assets/icons/football.svg",
    IconName.music: "assets/icons/music.svg",
    IconName.movie: "assets/icons/movie.svg",
    IconName.shopping: "assets/icons/shop-shopping.svg",
    IconName.personal: "assets/icons/personal.svg",
    IconName.meetavet: "assets/icons/pet.svg",
    IconName.party: "assets/icons/party.svg",
    IconName.add: "assets/icons/add.svg",
    IconName.noti: "assets/icons/notification-svgrepo-com.svg"
  };
}

enum IconName {
  menu,
  search,
  notification,
  backarrow,
  forwardarrow,
  noti,
  todoicon,
  categoryicon,
  soundgraphic,
  airplan,
  car,
  cooking,
  payment,
  work,
  health,
  vacation,
  gift,
  meeting,
  ideas,
  fastfood,
  footballMatch,
  music,
  movie,
  shopping,
  personal,
  meetavet,
  party,
  add,
}
