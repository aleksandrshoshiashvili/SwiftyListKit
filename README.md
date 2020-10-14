<p align="center">
<img src="https://github.com/aleksandrshoshiashvili/SwiftyListKit/blob/master/Resources/logo.png?raw=true" width="600px"></img>
</p>

<p align="center">
    <img src="https://img.shields.io/badge/platform-iOS10%2B-blue.svg?style=flat" alt="Platform: iOS 10+" />
    <a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/language-swift5-f48041.svg?style=flat" alt="Language: Swift 5" /></a>
    <a href="https://cocoapods.org/pods/SwiftyListKit"><img src="https://cocoapod-badges.herokuapp.com/v/SwiftyListKit/badge.png" alt="Cocoapods compatible" /></a>
    <img src="https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat" alt="License: MIT" />
</p>
 

# SwiftyListKit

- [Features](#features)
- [Dependency](#dependency)
- [Requirements](#requirements)
- [Installation](#installation)
- [Components](#components)
- [How to use](#how-to-use)
- [Credits](#credits)
- [License](#license)

## Features

- [x] Declarative approach to creating simple and complex list views
- [x] Custom reload/update animation
- [x] Builtin load view with shimmering effect: `ListLoader`
- [x] Integrated **O(N)** difference algorithm (provided by `DifferenceKit` framework)
- [x] Full `UITableView` support
- [ ] Full `UICollectionView` support

## Dependency

SwiftyListKit is dependent on [DifferenceKit](https://ra1028.github.io/DifferenceKit). DifferenceKit is a fast and flexible O(n) difference algorithm framework for Swift collection.

## Requirements

Swift 5.0, iOS >= 10.0

## Installation

### CocoaPods

 is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate SwiftyListKit into your Xcode project using [CocoaPods](https://cocoapods.org), add the following entry in your `Podfile`:

```ruby
pod 'SwiftyListKit'
```

Then run `pod install`.

In any file you'd like to use SwiftyListKit in, don't forget to import the framework with `import SwiftyListKit`.

### Manually

- Just drop `SwiftyListKit` folder in your project.
- You're ready to use `SwiftyListKit`!

## Components

SwiftyListKit items consist of 4 main components:

1. UI part (`UITableViewCell`, `UITableViewHeaderFooterView`, …)
2. Data Model (`ListItemDataModel`)
3. Mapper (`function`)
4. Style (`ListItemStyle`)

### UI part

For adapting `UITableViewCell` for `SwiftyListKit`, you need to add a protocol `TableItem` (or `CollectionItem` for `UICollectionViewCell`) to your cell, for example:

```swift
class OneTitleTableViewCell: UITableViewCell, TableItem {
}
```

You need to do the same  for `UITableViewHeaderFooterView` and for `UICollectionReusableView`.

Also, if your list item has any delegate methods, for example you have a cell with a button inside, you need to add the protocol `ListItemDelegatable` to your list item (cell, footer/header, reusable view) and add the protocol `Delegatable` to your delegate protocol. Then, inside your list item class you need to implement the method `func set(delegate: Delegatable)` from `ListItemDelegatable` protocol like this:

```swift
protocol ButtonTableViewCellDelegate: Delegatable {
  func buttonTableViewCellDidPressButton(_ cell: ButtonTableViewCell)
}

class ButtonTableViewCell: UITableViewCell, TableItem, ListItemDelegatable {

    weak var delegate: ButtonTableViewCellDelegate?

    public func set(delegate: Delegatable) {
        self.delegate = delegate as? ButtonTableViewCellDelegate
    }

    @IBAction func handleAction(_ sender: Any) {
      delegate?.buttonTableViewCellDidPressButton(self)
    }
}

```

### Data model

`ListItemDataModel` is a container of data needed to display the item in the list. `ListItemDataModel` is responsible for calculating `hashString` — the unique `id` for your list item. `hashString` is calculated automatically, but for some cases you may need to change the default calculation, so you can override it inside the data model.

Example of the data model:

```swift
struct TextDataModel: ListItemDataModel {
    var tag: Any?
    var text: String

    init(tag: String, text: String) {
        self.tag = tag
        self.text = text
    }
}
```

If you want to differentiate between objects, add the protocol variable `tag` to your data model. It might be needed, for example, when you need to react on `didSelectRow` action, for example.

Note: `ListItemDataModel` should contain only `plain` data, not business objects.

### Mapper

Mapper — this is just a function that maps your data model to your UI item. For example:

```swift
func map(model: TextWithIconDataModel, cell: IconWithTitleTableViewCell) {
        cell.iconImageView.setImage(fromUrl: model.iconUrl)
        cell.titleLabel.text = model.text
}
```

How to implement `map` functions is only up to you, here one example how to store them:

```swift
protocol Mapper {
    associatedtype TableItem: ListItem
    associatedtype Data: ListItemDataModel

    static func map(data: Data, cell: TableItem)
}


struct TitleCellMapper: Mapper {
    static func map(data: TextDataModel, cell: OneTitleTableViewCell) {
        cell.titleLabel.text = data.text
    }
}
```

### Style

`ListItemStyle` is a struct that helps to apply style to a list item. Instead of configuring, for example, the label's color in a cell, you create a style and apply it to your list item.

Example:
```swift
extension ListItemStyle where T: OneTitleTableViewCell {
    static var `default`: ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.titleLabel.textColor = .black
            $0.titleLabel.font = .boldSystemFont(ofSize: 12.0)
        }
    }

    static var error: ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.titleLabel.textColor = .red
            $0.titleLabel.font = .boldSystemFont(ofSize: 16.0)
        }
    }
}
```

### ListItemViewModel

We've discussed the 4 components that make up the list item, now is the time to put them together:

```swift
let textDataModel = TextDataModel(title: "some text here")
let viewModel = TableItemViewModel(data: textDataModel,
                                    map: TitleCellMapper.map,
                                  style: .error)
```

This view model represents `OneTitleTableViewCell` with the label containing the text `"some text here"` in red color in the `UITableView`.
If you want the color to be different or the background color to be different, just change the style. Or if you want change text in the label — just change the data model, or if you want to change the UI (cell) — then just change the mapper. All components are easy to change.

## How to use

[Example app](https://github.com/aleksandrshoshiashvili/SwiftyListKit/tree/master/Example)

Let's build an ViewController with TableView with some cells. We can do it by subclassing `BaseAnimatedTableViewController` or we can just add `AnimatedTableListProtocol` protocol to our ViewController:



Note: If you are using the protocol, then you have to call the `setup(withTableStyle: .plain)` method in `viewDidLoad`.

Example:

```swift
class ControllerWithProtocolOnly: UIViewController, AnimatedTableListProtocol {
    
    var tableView: UITableView!
    var dataSource: TableViewDataSourceAnimated<TableListSection>!
    var syncDelegate: SyncDelegate<TableListSection>!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup(withTableStyle: .plain)
        reloadViewModels()
    }
    
    private func reloadViewModels() {
        let sections = getSections()
        self.update(with: sections, updateAnimation: .default)
    }
    
    // MARK: - Generate random rows/headers
    
    private func getSections() -> [TableListSection] {
        var rowViewModels: [TableItemViewModel] = []

        let nameOfProductData = TextDataModel(text: "The Best Product")
        let nameOfProductViewModel = TableItemViewModel(data: nameOfProductData, map: TitleCellMapper.map, style: .custom(.title))

        let descriptionData = TextDataModel(text: "some description here")
        let descriptionViewModel = TableItemViewModel(data: textData, map: TitleCellMapper.map, style: .custom(.description))

        let productInfoSection = TableListSection(rows: [nameOfProductViewModel, descriptionData]])

        let productIconDataModel = IconDataModel(iconUrl: "some url here")
        let productViewModel = TableItemViewModel(data: productIconDataModel, map: IconCellMapper.map, style: .custom(.circle))

        let productImageSection = TableListSection(rows: [productViewModel])
        
        return [productInfoSection, productImageSection]
    }
}
```

This example shows how to implement a ViewController with a TableView containing 2 sections where the first section consist of 2 cells with the same UI and Map function, but with different styles and different data, and the second section consist of 1 cell.

Note: You do not need to register cells/header/footers/reusable views, because if you are using `AnimatedTableListProtocol`, then `tableView` contains `TableViewRegistrator`, that automatically registers all list elements. You just need to make sure that the reuseIdentifier of your list item matches the list item's name (only for `UITableViewCell` and for `UICollectionViewCell`, for headers/footers/reusable views it doesn't matter).

### SyncDelegate

If you need to use TableView delegate methods, then you can use SyncDelegate to do so. SyncDelegate is part of `AnimatedTableListProtocol` (and part of `BaseAnimatedTableViewController` сorrespondingly).

The delegate methods in SyncDelegate are based on closures. 

Example:

```swift
class SyncDelegateExampleViewController: UIViewController, AnimatedTableListProtocol {
    
    var tableView: UITableView!
    var dataSource: TableViewDataSourceAnimated<TableListSection>!
    var syncDelegate: SyncDelegate<TableListSection>!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup(withTableStyle: .plain)
        
        syncDelegate.didSelectRow = { [weak self] _, _, model in
            guard let tag = model?.data.tag as? String {
                    return
            }
            self?.showAlert(with: tag)
        }
        
        syncDelegate.onEditActions = { [weak self] _, _, _ in
            guard let self = self else { return nil }
            return [.init(style: .destructive, title: "Delete", handler: self.handleItemDelete)]
        }
    }
    
}
```

Also SyncDelegate contains all ScrollView delegate methods (e.g. onScrollViewDidScroll, onScrollViewWillBeginDragging, onScrollViewDidZoom and so on).

## Credits

SwiftyListKit was written by 
SwiftyListKit was written by [Alexander Shoshiashvili](https://github.com/aleksandrshoshiashvili) and by [Dmitrii Grebenshchikov](https://github.com/Alozavr).

It makes use of [DifferenceKit](https://github.com/ra1028/DifferenceKit).

## License

SwiftyListKit is released under the MIT license. [See LICENSE](https://github.com/aleksandrshoshiashvili/SwiftyListKit/blob/master/LICENSE) for details.
