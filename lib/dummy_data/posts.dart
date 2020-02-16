import 'dart:math';
import '../utils/post.dart';

get posts => [
      Post(
          id: "1",
          userName: "Dev Sebatian",
          title: "Mozzarella Pizza",
          description:
              "Allow the dough to rest at room temperature before rolling it out. If it still shrinks back when you start to work with the dough, let it rest for another 10 minutes, and then try again. For a pretty finishing touch, save a few small basil leaves to sprinkle over the top after it cooks.",
          imageUrls: [
            "https://img.buzzfeed.com/thumbnailer-prod-us-east-1/dc23cd051d2249a5903d25faf8eeee4c/BFV36537_CC2017_2IngredintDough4Ways-FB.jpg",
          ],
          userProfileImageUrl: "https://loremflickr.com/300/300?random=" +
              Random().nextInt(10).toString()),
      Post(
          id: "2",
          title: "Chicken Lababdar",
          userName: "Ramesh Nair",
          description:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          imageUrls: [
            "https://i0.wp.com/files.hungryforever.com/wp-content/uploads/2017/08/17204011/feature-image-chicken-lababdar.jpg?fit=1200%2C630&ssl=1",
          ],
          userProfileImageUrl: "https://loremflickr.com/300/300?random=" +
              Random().nextInt(10).toString()),
      Post(
          id: "3",
          title: "Chicken Tikka",
          userName: "Nikola Switch",
          description:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          imageUrls: [
            "https://glebekitchen.com/wp-content/uploads/2016/12/chickentikkakebab.jpg",
          ],
          userProfileImageUrl: "https://loremflickr.com/300/300?random=" +
              Random().nextInt(10).toString()),
      Post(
          id: "3",
          title: "Malai Tikka",
          userName: "Nitesh Goel",
          description:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          imageUrls: [
            "https://www.fishvish.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/c/h/chicken-malai-tikka_1.jpg",
          ],
          userProfileImageUrl: "https://loremflickr.com/300/300?random=" +
              Random().nextInt(10).toString()),
    ];
