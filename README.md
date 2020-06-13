# SwiftToolsKit

SwiftToolsKit

### CocoaPods
  
pod 'SwiftToolsKit'
  
### Use

```
import SwiftToolsKit
```
  
#### stk:

1.UIColor
```
// UIColor
view.backgroundColor = UIColor.stk.randomColor
......
```

2.Date
    
```
// Date
Date().stk.toString(style: "YYYY-MM-dd HH:mm:ss")
......
```
    
3.UILabel
```
// init
UILabel(text: "SwiftToolsKit", textColor: .red, font: .systemFont(ofSize: 16))

// height
func getSpaceLabelHeight()
```

4.UIButton
```
func leftTitleAndRightImageFits()

func topImageAndBottomTitleFits()

func topImageAndBottomTitleFitsWith()
```

5.UIDevice
```
func getUUIDString()
```

6.UIView
```
1.frame(x/y/w/h)

2.func currentViewController() -> UIViewController?
......
```

7.UIImage
```
func createImage(with color: UIColor, rect: CGRect) -> UIImage?

func cutImage(from aImage: UIImage, cutRect: CGRect) -> UIImage?
```

8.String
```
func toDate(format: String) -> Date?

func toDateString(timeInterval: TimeInterval, format: String) -> String

func toPinyin() -> String

func firstLetterUpper() -> String

func getStringHeight(......)

func getStringWidth(......)

func getStringSize(......)

subscript(r: Range<Int>) -> String
```

9.Other
```
// 日期格式
public enum DateFormatType: String {
    case normal             = "yyyy-MM-dd HH:mm:ss"
    case yyMdHm             = "yy-MM-dd HH:mm"
    case yyyyMdHm           = "yyyy-MM-dd HH:mm"
    case yMd                = "yyyy-MM-dd"
    case MdHms              = "MM-dd HH:mm:ss"
    case MdHm               = "MM-dd HH:mm"
    case Hms                = "HH:mm:ss"
    case Hm                 = "HH:mm"
    case Md                 = "MM-dd"
    case yyMd               = "yy-MM-dd"
    case YYMMdd             = "yyyyMMdd"
    case yyyyMdHms          = "yyyyMMddHHmmss"
    case yyyyMdHmsS         = "yyyy-MM-dd HH:mm:ss.SSS"
    case yyyyMMddHHmmssSSS  = "yyyyMMddHHmmssSSS"
    case yMdWithSlash       = "yyyy/MM/dd"
    case yM                 = "yyyy-MM"
    case yMdChangeSeparator = "yyyy.MM.dd"
}
```

<br>
<br>

******

#### global

```
// App Version
func APP_VERSION() -> String?

func APP_BUILD() -> String?

func SYSTEM_VERSION() -> String

func isPhoneNumber(_ number: String) -> Bool
```
    
    
    
    
  
