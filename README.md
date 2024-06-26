
![Logo](https://github.com/fodedoumbouya/os_ui/assets/47141813/633a53c3-9a96-4240-b40a-105ae74fd9ea)



This package helps you to showcase your project or play with computer OS interface for any kind of projects.

All the functions are ready include in the package such as: 

* Window management system
* Customizable toast notifications
* OS-specific functionalities
* Multi-language support


![App Screenshot](https://github.com/fodedoumbouya/os_ui/assets/47141813/1398cc6c-af28-4191-b798-7cec1473a636)



## Demo
![OS UI Demo](https://github.com/fodedoumbouya/os_ui/assets/47141813/f8f09daa-0a45-470a-9c35-71928d820d14)



See real examples:

* <https://github.com/fodedoumbouya/os_ui/tree/main/example>

## Table of contents

Run this command:

With Flutter:

```dart
flutter pub add os_ui
```

This will add a line like this to your package's pubspec.yaml with the latest version (and run an implicit flutter pub get):

```js
dependencies:
  os_ui: <latest_version>
```

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn
more about it.

Import the package in your code:

```dart 
import 'package:os_ui/os_ui.dart';
```

You can use standard os_ui like so :

```dart
    Os(
        osIndentifier: OsIndentifier(
            type: OsType.macos,
            windowsManagementController:
            WindowsManagementController(
                applications: [],
              ),
            ),
        )

```

If you want to customize it, you can use something like this : 

```dart
    Os(
        osIndentifier: OsIndentifier(
          type: OsType.macos,
          windowsManagementController: WindowsManagementController(
              // [dockStyle] make you change the style of the dock
              dockStyle: DockStyle(),
              // [topBarStyle] make you change the style of the top bar
              topBarModel: TopBarModel(),
              applications: []),
        ),
      ),

```

## Properties of ```TopBarModel```

| Property | Type | Description |
|----------|------|-------------|
| backgroundColor | Color? | The background color of the top bar |
| textStyle | TextStyle? | The text style of the top bar |
| iconColor | Color? | The color of the icons in the top bar |
| barText | String? | The text displayed in the top bar |
| popupMenuItemsOnAppleIcon | List<TopBarPopupMenuItem> | The popup menu items displayed when clicking on the Apple icon |
| popupMenuItemColor | Color? | The color of the popup menu items |
| popupMenuItemShadowColor | Color? | The color of the shadow of the popup menu items |
| popupMenuItemSurfaceTintColor | Color? | The color of the surface of the popup menu items |
| listLanguages | List<TopBarPopupMenuItem> | The list of available languages |
| dateFormat | DateFormat? | The date format for the top bar |

## Properties of ```DockStyle```

| Property | Type | Description |
|----------|------|-------------|
| backgroundColor | Color? | The background color of the dock |
| tooltipBackgroundColor | Color? | The background color of the tooltips in the dock |
| tooltipTextStyle | TextStyle? | The text style of the tooltips in the dock |

## Properties of ```WindowsModel```

| Property | Type | Default Value | Description |
|----------|------|---------------|-------------|
| index | int | Auto-incremented | The index of the window |
| iconUrl | String | Required | The URL of the window icon (supports network and asset) |
| name | String | Required | The name of the window |
| iconPosition | AppIconPosition | AppIconPosition.none | The position of the app icon |
| size | Size | Required | The size of the window |
| style | WindowsModelStyle? | null | The style of the window |
| canExpand | bool | true | Whether the window can be expanded |
| canMinimized | bool | true | Whether the window can be minimized |
| isMinimized | bool | false | Whether the window is minimized |
| entryApp | EntryWidgetBuilder? | null | The child widget of the window |
| onTap | EntryTapBuilder? | null | The callback function for the "Open" action |
| isFullScreen | bool | false | Whether the window is in full screen mode |
| isCurrentScreen | bool | true | Whether the window is the current screen |
| states | List<EntryWidgetBuilder> | [] | The list of states of the window |
| isOpenWindow | bool | false | Whether the window is open |
| isLaunchpad | bool | false | Whether the window is a launchpad |
| enableDragWidgets | bool | true | Whether drag widgets are enabled |
| lastPosition | WindowPosition? | null | The last position of the window |

Note: `iconUrl`, `name`, and `size` are required parameters when creating a new WindowsModel instance.



## License

[MIT](https://choosealicense.com/licenses/mit/)

