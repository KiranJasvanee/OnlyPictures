
<p align="center">
  <img src="promo/recent_left_colorful.png"  style="width: 220px;" width="220" /> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="promo/left_scroll_colorful.gif"  style="width: 280px;" width="280" /> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="promo/recent_left_with_gap_colorful.png"  style="width: 260px;" width="260" />
</p>

<p align="center">
  <img src="promo/recent_right_colorful.png"  style="width: 220px;" width="220" /> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="promo/right_scroll_colorful.gif"  style="width: 280px;" width="280" /> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="promo/recent_right_with_gap_colorful.png"  style="width: 260px;" width="260" />
</p>



<p align="center">
    <a href="https://twitter.com/Kiranjasvanee">
        <img src="https://img.shields.io/badge/contact-@kiranjasvanee-blue.svg?style=flat"
             alt="Twitter">
    </a>
    <a href="https://github.com/KiranJasvanee/OnlyPictures/blob/master/LICENSE">
        <img src="https://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="Codecov" />
    </a>
    <a href="https://cocoapods.org/pods/OnlyPictures">
        <img src="https://img.shields.io/cocoapods/v/OnlyPictures.svg?style=flat"
             alt="Pods Version">
    </a>
    <a href="http://cocoapods.org/pods/OnlyPictures/">
        <img src="https://img.shields.io/cocoapods/p/OnlyPictures.svg?style=flat"
             alt="Platforms">
    </a>
    <a href="https://github.com/KiranJasvanee/OnlyPictures/issues">
        <img src="https://img.shields.io/github/issues/KiranJasvanee/OnlyPictures.svg"
             alt="Issues">
    </a>
    <a href="https://github.com/KiranJasvanee/OnlyPictures">
        <img src="https://img.shields.io/github/forks/KiranJasvanee/OnlyPictures.svg"
             alt="Forks">
    </a>
    <a href="https://github.com/KiranJasvanee/OnlyPictures">
        <img src="https://img.shields.io/github/stars/KiranJasvanee/OnlyPictures.svg"
             alt="Stars">
    </a>
    <a href="https://github.com/KiranJasvanee/OnlyPictures">
        <img src="https://img.shields.io/badge/Language-Swift-yellow.svg"
             alt="Stars">
    </a>
</p>

----------------

### Installation

OnlyPictures is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'OnlyPictures'
```

### Usage
Use `DataSource` for data assignment & `Delegate` to get indication of action performed in pictures.

#### DataSource 

```
extension ViewController: OnlyPicturesDataSource {

    // returns the total no of pictures
    func numberOfPictures() -> Int {
        return pictures.count
    }
    
    // returns the no of pictures should be visible in screen. 
    // In above preview, Left & Right formats are example of visible pictures, if you want pictures to be shown without count, remove this function, it's optional.
    func visiblePictures() -> Int {
        return 6
    }
    
    // return the images you want to show.
    func pictureViews(index: Int) -> UIImage {
        return pictures[index]
    }
}
```

### Author

Kiran Jasvanee, kiran.jasvanee@gmail.com

### License

OnlyPictures is available under the MIT license. See the LICENSE file for more info.
