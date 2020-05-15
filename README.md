# SwiftyListKit

TableView data source
======================================

- [Features](#features)
- [Dependency](#dependency)
- [Requirements](#requirements)
- [Installation](#installation)
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

## How to use

### !!! Documentation is outdated !!!

[Example app](https://github.com/aleksandrshoshiashvili/SwiftyListKit/tree/master/Example)

Разберем как работает `SwiftyListKit` на примере одного из экранов тестового приложения.

![Example app](https://i.imgur.com/LJJwKLR.png)

Как мы можем заметить, на экране отображаются ячейки с хэдером. Причем ячейки отличаются друг от друга только наполнением (текст) и стилем (цвет текста и фона).

Для начала нам нужен `ViewController` с таблицей, в `SwiftyListKit` уже есть реализованные контроллеры, от которых можно наследоваться:

```swift
class PlainExampleViewController: BaseAnimatedTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```

Мы выберем контроллер с возможностью анимированного апдейта таблиц. На данном этапе мы создали контроллер `PlainExampleViewController` с `plain` таблицей, с реализованным dataSource и delegate для таблицы. Просто, не правда ли?

В SwiftyListKit вы не работаете с UITableViewCell, UITableViewHeaderFooterView напрямую, вы работаете с вью моделями `ListItemViewModel`, которые описывают будущий вид ячейки. 

`ListItemViewModel` поддерживает несколько типов инициализации, для нашего примера подойдет следующий:

```swift
public init<T: ListItemDataModel, U: ListItem>(data: T,
                                                map: @escaping MapDataToItem<T, U>,
                                                style: StyleType<U>? = nil,
                                                heightStyle: ListItemHeightStyle = .automatic)
```

где 

 - `data` —  `ListItemDataModel` отвечает за наполнение ячейки данными. В нашем примере — это структура, которая хранит `title`.

```swift
public struct TitleCellViewModel: ListItemDataModel {
    public var tag: Any?
    public var title: String
    
    public init(tag: String = "", title: String = "123") {
        self.tag = tag
        self.title = title
    }
}
```

`tag` нужен в основном для того, чтобы различать одну `ListItemDataModel` от другой. Обычно туда записывается что-то вроде `id` ячейки.

За наполнение  отвечает `ListItemDataModel`, за стиль `StyleType`, а за ячейку/футер/хэдер в целом — `ListItemViewModel`.

 - `map` — это блок, который выполняет маппинг данных из `ListItemDataModel` в `ListItem`. можно использовать дефолтный `map` для конкретного типа `ListItem`, а можно определить кастомный.

Кастомный `map` выглядит следующим образом

```swift
extension OneTitleTableViewCell {
    static func mapTitleViewModel(model: TitleCellViewModel, cell: OneTitleTableViewCell) {
        cell.titleLabel.text = model.title
    }
}
```

 - `style` — это элемент `enum`, который говорит как стилизовать данную ячейку. Стиль бывает дефолтный и кастомный. 

Если стиль дефолтный, то значение для стиля берется из `defaultStyle: MapStyleToItemClosure?` в `ListItem`, который можно переопределять внутри конкретной ячейки.
Для создания кастомного стиля используйте `ListItemStyle`:

```swift
    // создаем стиль для titleLabel внутри ячейки OneTitleTableViewCell
    let customStyle1: ListItemStyle<OneTitleTableViewCell> = ListItemStyle<OneTitleTableViewCell> {
        $0.titleLabel.textColor = .magenta
    }
            
    // создаем стиль для dummyImageView внутри OneTitleTableViewCell
    let customStyle2: ListItemStyle<OneTitleTableViewCell> = ListItemStyle<OneTitleTableViewCell> {
        $0.dummyImageView.layer.borderColor = UIColor.black.cgColor
        $0.dummyImageView.layer.borderWidth = 2.0
        $0.dummyImageView.apply(.rounded)
    }
    
    // объединяем стили
    let customStyle = customStyle1 + customStyle2
```

Кроме того вы можете написать `extension` над `ListItemStyle`, чтобы не писать одинаковые стили каждый раз, а хранить их все в одном месте

```swift
extension ListItemStyle where T: OneTitleTableViewCell {
    
    static var `default`: ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.dummyImageView.apply(.rounded)
            $0.titleLabel.apply(.uppercasedAlert)
        }
    }
    
    static var squareIconAlertTitle: ListItemStyle<T> {
        return ListItemStyle<T> {
            $0.dummyImageView.apply(.squared)
            $0.titleLabel.apply(.uppercasedAlert)
        }
    }
    
}
```

 - `heightStyle` — этот параметр определяет какую высоту задать ячейки, по дефолту стоит  `automatic`.


Теперь, когда мы знаем как инициализировать вью модель ячейки, вернемся к примеру. Нам нужно создать секции с хэдерами и ячейками внутри секций.

Для этого нам нужно создать `ListSection`:

```swift
var rowViewModels: [ListItemViewModel] = []

// ячейка с желтым фоном и текстом "123", стиль для желтого фона реализован в `.default`
let oneLineDataModel = TitleCellViewModel(title: "123")
let cellViewModel = ListItemViewModel(data: oneLineDataModel,
                                        map: OneTitleTableViewCell.map1,
                                        style: .default)
rowViewModels.append(cellViewModel)

// ячейка с той же дата моделью, что и у cellViewModel, но другим стилем. Стиль реализован в extenstion над ListItemStyle
let oneLineDataModel1 = TitleCellViewModel(title: .randomString())
let cellViewModel1 = ListItemViewModel(data: oneLineDataModel1,
                                        map: OneTitleTableViewCell.map1,
                                        style: .custom(style: .squareIconAlertTitle))

// ячейка с той же дата моделью, что и у cellViewModel, но другим стилем. Стиль реализован в extenstion над ListItemStyle
let oneLineDataModel1 = TitleCellViewModel(title: .randomString())
let cellViewModel1 = ListItemViewModel(data: oneLineDataModel1,
                                        map: OneTitleTableViewCell.map1,
                                        style: .custom(style: .squareIconAlertTitle))
                                        
let cellViewModel1 = ListItemViewModel(data: oneLineDataModel1,
                                                   map: OneTitleTableViewCell.map1,
                                                   style: .custom(style: .squareIconAlertTitle))
            
let customStyle1: ListItemStyle<OneTitleTableViewCell> = ListItemStyle<OneTitleTableViewCell> {
    $0.titleLabel.textColor = .magenta
}
            
let customStyle2: ListItemStyle<OneTitleTableViewCell> = ListItemStyle<OneTitleTableViewCell> {
    $0.dummyImageView.layer.borderColor = UIColor.black.cgColor
    $0.dummyImageView.layer.borderWidth = 2.0
    $0.dummyImageView.apply(.rounded)
}
            
let customStyle = customStyle1 + customStyle2
            
let oneLineDataModel2 = TitleCellViewModel(title: .randomString())

// ячейка опять с другой дата моделью, и с кастомный стилем, который реализован не в extension
let cellViewModel2 = ListItemViewModel(data: oneLineDataModel2,
                                        map: OneTitleTableViewCell.map1,
                                        style: .custom(style: customStyle))
                                        
let dividerDataModel = TitleCellViewModel(title: .randomString())
        
let headerViewModel = ListItemViewModel(data: dividerDataModel,
                                        map: DividerHeader.map)

let section = ListSection(header: headerViewModel,
                                  footer: nil,
                                  rows: rowViewModels)
```

В примере кода, приведенном выше мы создали секцию хэдером и тремя ячейками одного класса, но с разным наполнением и стилем.

Теперь нам нужно отобразить эту секциию на экране, для этого просто вызовем метод:

```swift
// этот метод реализован в BaseAnimatedTableViewController
update(with: [section])
```

Всё, таблица отрисовалась с нашими ячейками. 

Если, например, вы запросили новые данные с сервера, они пришли и вы хотите обновить только те ячейки, которые изменились, то:
просто создайте секции как и в примере выше с новыми данными и вызовите тот же самый метод `update(with: [section])`, встроенный в SwiftyListKit difference алгоритм найдет отличия в моделях и обновит только те ячейки, которые изменились.

Если вам нужно всё равно обновить всю таблицу целиком и без анимации, то выставите значение `noAnimations` в свойство контроллера `updateAnimation`.

### Auto registration

В `SwiftyListKit` есть функция авторегистрации ячеек/хедеров/футеров, которая позволяет вам забыть о существовании метода `tableView.register(...)`.

Но есть два требования, чтобы всё работало как надо: название класса ячейки и её reuseIdentifier должны совпадать, а также таблица должна быть наследником класса `TableView` и использоваться dataSource от `SwiftyListKit`'а.

 - reuseIdentifier

Если вы используете xib для ячейки или создаете её в storyboard, то просто впишите в поле reuseIdentifier название класса ячейки.

Если вы создали ячейки без использования xib или storyboard, то вам нужно переопределить init и выставить значение для reuseIdentifier следующим образом:

```swift
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "InCodeTableViewCell") // класс ячейки называется точно также `InCodeTableViewCell`
        textLabel?.text = .randomString()
        accessoryType = .detailButton
    }
```

- TableView и dataSource SwiftyListKit'а

Если вы используете любой из `BaseTableViewController, BaseAnimatedTableViewController или BaseAnimatedRxTableViewController`, то за вас уже всё сделано.

Если же вы хотите использовать функционал авторегистрации без использования «базового контроллера», то просто вместо `UITableView` используйте `TableView` в связке с любым dataSource из SwiftyListKit'а (с любым наследнииком `TableViewDataSource`). 


### Diffs and animations

Чтобы воспользоваться встроенным механизмом анимирования обновлений таблицы, используемый вами dataSource должен быть наследником `TableViewDataSourceAnimated`. В неё вы можете использовать проперти `var updateAnimation: ListUpdateAnimation` для настройки анимаций.
Для вашего удобства в `SwiftyListKit` встроены два «базовых» контроллера, которые содержат в себе анимированный dataSource: `BaseAnimatedTableViewController` и `BaseAnimatedRxTableViewController`.
При использовании «базовых» контроллеров вы можете менять свойство для настройки анимации у него, а не у dataSource.

Доступные следующие виды анимации:

```swift
public enum ListUpdateAnimation {
    case `default`
    case standard(configuration: TableAnimationConfiguration)
    case custom(configuration: Animation)
    case noAnimations
}
```

где 

 - `default` — это по сути `standard` с `fade`. Диффы в этом виде анимаций включены
 - - `standard(configuration: TableAnimationConfiguration)` — это способ настроить анимацию стандартными для таблицы анимациями, в том числе `none`. Диффы включены
 - - `custom(configuration: Animation)` — этот вариант позволяет реализовать абсолютно любой способ анимирования обновления, в `SwiftyListKit` есть несколько встроенных примеров, которые можно посмотреть (и использовать) в `ListUpdateAnimations`. Диффы включены
 - - `noAnimations` — это `reloadData()` без анимаций. Диффы выключены

В  `SwiftyListKit` встроен алгоритм диффов, который вычисляет разницу между ячейками и секциями, которые надо отрисовать и перерисовывает лишь те, которые изменились. Это дает прирост производительности и выглядит лучше.

За «одинаковость» ячеек отвечает `hashString` в `ListItemDataModel`. 
По дефолту значение `hashString` вычисляется автоматически, пытаясь взять значения из хранимых проперти в `String`. Если же вам нужно какое-то другое поведение, то просто переопределите `hashString` в вашей структуре/классе, реализующей `ListItemDataModel`.

Например, у нас есть структура `TitleWithDescriptionDataModel`. Она содержит title и description. По дефолту диффы будут смотреть на изменение title или description и если что-то изменится, то диффы обновят ячейку.

```swift
struct TitleWithDescriptionDataModel: ListItemDataModel {
    public var tag: Any?
    public var title: String
    public var description: String
    
    public init(tag: String = "", title: String, description: String) {
        self.tag = tag
        self.title = title
        self.description = description
    }
}
```

Чтобы сказать диффам смотреть только на изменение title, нужно переопределить `hashString` следующим образом:

```swift
struct TitleWithDescriptionDataModel: ListItemDataModel {
    public var tag: Any?
    public var title: String
    public var description: String
    
    public var hashString: String {
        return title
    }
    
    public init(tag: String = "", title: String, description: String) {
        self.tag = tag
        self.title = title
        self.description = description
    }
}
```

### Shimmering

В `SwiftyListKit` встроена компонента `ListLoader`, которая показывает `shimmering` эффект на ячейках и хэдерах/футерах. 

![Example](https://i.imgur.com/IOCt7YU.png)

Пример использования:

```swift
        let oneTitleVM = ListItemViewModel(itemType: OneTitleTableViewCell.self)
        let imageVM = ListItemViewModel(itemType: WithImageTableViewCell.self)
        let headerVM = ListItemViewModel(itemType: DividerHeader.self)
        
        let placeholderSection = ListSection(header: headerVM,
                                             footer: headerVM,
                                             rows: [oneTitleVM, imageVM, oneTitleVM, imageVM, oneTitleVM, oneTitleVM, oneTitleVM])
        
        ListLoaderConfiguration.direction = .fromTopLeftToBottomRight
        
        view.showLoader(with: [placeholderSection])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            let sections = [ListSection].init(repeating: self.getSection(), count: 5)
            self.view.hideLoader(with: sections)
        })
```

Так как предполагается, что показ этого вида эффекта используется для показа «дефолтного» состояния экрана, когда еще не известно сколько данных будет и какие это будут данные, то вы можете инициализировать ячейки по их типу, не беспокоясь за их стилизацию и наполнение.

Вы можете нестроить `ListLoader` с помощью `ListLoaderConfiguration` как вам нужно, и вызвать  `view.showLoader(with: [placeholderSection])`. 
Как только данные придут и новые секции будут сформированы, вы можете вызвать метод `view.hideLoader(with: sections)`: он уберет лоадер и обновит таблицу с новыми данными.

## Credits


## License

SwiftyListKit is released under the MIT license. [See LICENSE](https://github.com/aleksandrshoshiashvili/SwiftyListKit/blob/master/LICENSE) for details.
