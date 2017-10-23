<p align="center">
  <img src="promo/onlyPictures/only_pictures1.png"  style="width: 500px;" width="500" />
</p>

<br />
<br />

<p align="center">
  <img src="promo/general/recent_left_colorful.png"  style="width: 220px;" width="220" /> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="promo/general/left_scroll_colorful.gif"  style="width: 280px;" width="280" /> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="promo/general/recent_left_with_gap_colorful.png"  style="width: 260px;" width="260" />
</p>

<p align="center">
  <img src="promo/general/recent_right_colorful.png"  style="width: 220px;" width="220" /> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="promo/general/right_scroll_colorful.gif"  style="width: 280px;" width="280" /> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="promo/general/recent_right_with_gap_colorful.png"  style="width: 260px;" width="260" />
</p>

<p align="center">
  <img src="promo/URL_images/URL_images_allocation.gif"  style="width: 220px;" width="220" /> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="promo/Insert_and_remove/descending_work/append_and_reload_when_scroll.gif"  style="width: 280px;" width="280" /> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="promo/Insert_and_remove/descending_work/append_and_reload_when_count.gif"  style="width: 260px;" width="260" />
</p>

<p align="center">
  <img src="promo/Insert_and_remove/descending_work/insert_at_first_when_count.gif"  style="width: 220px;" width="220" /> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="promo/Insert_and_remove/descending_work/insert_at_last_when_scrollable.gif"  style="width: 280px;" width="280" /> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="promo/Insert_and_remove/descending_work/insert_at_specific_position_when_count.gif"  style="width: 260px;" width="260" />
</p>

<p align="center">
  <img src="promo/Insert_and_remove/descending_work/remove_from_first_when_count.gif"  style="width: 220px;" width="220" /> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="promo/Insert_and_remove/descending_work/remove_from_last_when_scrollable.gif"  style="width: 280px;" width="280" /> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="promo/Insert_and_remove/descending_work/remove_from_specific_position_when_count.gif"  style="width: 260px;" width="260" />
</p>

<br />
<br />

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
### Explaination & Live tracker.
<p align="center">
  <img src="promo/onlyPictures//live_tracker_3.gif"  style="width: 260px;" width="260" />
</p>
<p align="center">
  <img src="promo/onlyPictures/explanation.png"  style="width: 700px;" width="700" />
</p>
<p align="center">
  
```swift
onlyPictures.order = .descending
```
</p>


### Usage

Add `UIView` in your outlet, select it and go to `Properties -> Identity Inspector`,  add `OnlyHorizontalPictures` in `class property`. `OnlyVerticalPictures` about to release soon.

<img src="promo/general/UIVIew_outlet.png"  style="width: 220px;" width="220" /> &nbsp;&nbsp;&nbsp;&nbsp; `->` &nbsp;&nbsp;&nbsp;&nbsp; <img src="promo/general/identity_inspector_class_property_assignment.png"  style="width: 220px;" width="220" /> 

Create `instance` of this outlet as below.
```swift
@IBOutlet weak var onlyPictures: OnlyHorizontalPictures!
```

Use `DataSource` for data assignment & `Delegate` to get indication of action performed in pictures.
```swift
onlyPictures.dataSource = self
onlyPictures.delegate = self
```

#### DataSource Methods

```swift
extension ViewController: OnlyPicturesDataSource {

    // ---------------------------------------------------
    // returns the total no of pictures
    
    func numberOfPictures() -> Int {
        return pictures.count
    }
    
    // ---------------------------------------------------
    // returns the no of pictures should be visible in screen. 
    // In above preview, Left & Right formats are example of visible pictures, if you want pictures to be shown without count, remove this function, it's optional.
    
    func visiblePictures() -> Int {
        return 6
    }
    
    
    // ---------------------------------------------------
    // return the images you want to show. If you have URL's for images, use next function instead of this.
    // use .defaultPicture property to set placeholder image. This only work with local images. for URL's images we provided imageView instance, it's your responsibility to assign placeholder image in it. Check next function.
    // onlyPictures.defaultPicture = #imageLiteral(resourceName: "defaultProfilePicture")
    
    func pictureViews(index: Int) -> UIImage {
        return pictures[index]
    }
    
    
    // ---------------------------------------------------
    // If you do have URLs of images. Use below function to have UIImageView instance and index insted of 'pictureViews(index: Int) -> UIImage'
    // NOTE: It's your resposibility to assign any placeholder image till download & assignment completes.
    // I've used AlamofireImage here for image async downloading, assigning & caching, Use any library to allocate your image from url to imageView.
    
    func pictureViews(_ imageView: UIImageView, index: Int) { 
    
        // Use 'index' to receive specific url from your collection. It's similar to indexPath.row in UITableView.
        let url = URL(string: self.pictures[index])
        
        imageView.image = #imageLiteral(resourceName: "defaultProfilePicture")   // placeholder image
        imageView.af_setImage(withURL: url!)   
    }
}
```
#### Delegate Methods
```swift
extension ViewController: OnlyPicturesDelegate {
    
    // ---------------------------------------------------
    // receive an action of selected picture tap index
    
    func pictureView(_ imageView: UIImageView, didSelectAt index: Int) {
        
    }
    
    // ---------------------------------------------------
    // receive an action of tap upon count
    
    func pictureViewCountDidSelect() {
        
    }
    
    // ---------------------------------------------------
    // receive a count, incase you want to do additionally things with it.
    // even if your requirement is to hide count and handle it externally with below fuction, you can hide it using property `isVisibleCount = true`.
    
    func pictureViewCount(value: Int) {
        print("count value: \(value)")
    }
    
    
    // ---------------------------------------------------
    // receive an action, whem tap occures anywhere in OnlyPicture view.
    
    func pictureViewDidSelect() {
        
    }
}
```

#### Reload

##### `.reloadData()`
- `reloadData()` will work similar to `UITableView -> reloadData()`, it will call `numberOfPictures()` & `pictureViews(index: Int)`/`pictureViews(_ imageView: UIImageView, index: Int)` again to reform pictures. 

#### Properties

##### .order

- Pictures works based on `LIFO` - Last In First Out, means last added will be shown at top (recent). 
- If your array contains pictures in `ascending`, it will show last picture OR in other words last appended picture at top (recent). 
- If your array contains pictures in `descending`, set `.order property` to `.descending` to show first picture at top (recent). 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  `.ascending` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    `.descending`

&nbsp;&nbsp;&nbsp; <img src="promo/order_property/ascending.png"  style="width: 160px;" width="180" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <img src="promo/order_property/descending.png"  style="width: 180px;" width="180" /> 

```swift
onlyPictures.order = .descending
```

##### .recentAt
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  `.left` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    `.right`

&nbsp;&nbsp;&nbsp; <img src="promo/general/recent_left_colorful.png"  style="width: 160px;" width="180" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <img src="promo/general/recent_right_colorful.png"  style="width: 180px;" width="180" /> 

```swift
onlyPictures.recentAt = .left
```


##### .alignment
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   `.left` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    `.center`    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    `.right`

<img src="promo/alignment_property/left.png"  style="width: 280px;" width="280" /> &nbsp; <img src="promo/alignment_property/center.png"  style="width: 280px;" width="280" /> &nbsp; <img src="promo/alignment_property/right.png"  style="width: 280px;" width="280" />

```swift
onlyPictures.alignment = .left
```


##### .countPosition
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  `.right` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   `.left`

&nbsp;&nbsp;&nbsp; <img src="promo/general/recent_left_colorful.png"  style="width: 160px;" width="180" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <img src="promo/general/recent_right_colorful.png"  style="width: 180px;" width="180" /> 

```swift
onlyPictures.countPosition = .right
```


##### .gap
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`.gap = 20` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    `.gap = 36`     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    `.gap = 50` 

&nbsp;&nbsp;&nbsp;&nbsp; <img src="promo/gap_property/gap_20.png"  style="width: 120px;" width="120" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="promo/gap_property/gap_36.png"  style="width: 180px;" width="180" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="promo/gap_property/gap_50.png"  style="width: 220px;" width="220" />

```swift
onlyPictures.gap = 36
```

##### .spacing
&nbsp;&nbsp;&nbsp;    `.spacing = 0` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     `.spacing = 2`     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   `.spacing = 4` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   `.spacing = 4` 

<img src="promo/spacing_property/spacing_0.png"  style="width: 160px;" width="160" /> &nbsp;&nbsp; <img src="promo/spacing_property/spacing_2.png"  style="width: 180px;" width="180" /> &nbsp;&nbsp; <img src="promo/spacing_property/spacing_4.png"  style="width: 200px;" width="200" /> &nbsp;&nbsp; <img src="promo/spacing_property/spacing_4_with_white.png"  style="width: 200px;" width="200" />

```swift
onlyPictures.spacing = 2
```

##### .spacingColor
&nbsp; `.spacingColor = .gray` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `.spacingColor = .white`

<img src="promo/spacingColor_property/spacing_4_with_gray.png"  style="width: 220px;" width="220" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="promo/spacingColor_property/spacing_4_with_white.png"  style="width: 220px;" width="220" />

```swift
onlyPictures.spacingColor = UIColor.white
```

##### .imageInPlaceOfCount

- Set image in place of count. If this property set, count properties won't effect.

<img src="promo/imageInPlaceOfCount_property/imageInPlaceOfCount_1.png"  style="width: 220px;" width="220" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="promo/imageInPlaceOfCount_property/imageInPlaceOfCount_2.png"  style="width: 260px;" width="260" />

```swift
onlyPictures.imageInPlaceOfCount = UIImage(named:"image_name")
```

#### Properties for count

##### .backgroundColorForCount

<img src="promo/backgroundColorForCount_property/backgroundColorForCount.png"  style="width: 220px;" width="220" /> 

```swift
onlyPictures.backgroundColorForCount = .orange
```

##### .textColorForCount

<img src="promo/textColorForCount_property/textColorForCount.png"  style="width: 220px;" width="220" /> 

```swift
onlyPictures.textColorForCount = .red
```

##### .fontForCount

<img src="promo/fontForCount_property/fontForCount.png"  style="width: 220px;" width="220" /> 

```swift
onlyPictures.fontForCount = UIFont(name: "HelveticaNeue", size: 18)!
```

##### .isHiddenVisibleCount
- To hide count, set `.isHiddenVisibleCount = true`. But you can receive count in a following funtion of `OnlyPicturesDelegate` - `pictureViewCount(value: Int)`. 
```swift
onlyPictures.isHiddenVisibleCount = true
```

#### *Things you can do additionally, Insert & Remove at First/Last/Specific-Position*
- NOTE: it's your responsibility to insert/remove image in your collection too, you used for pictures. It's similar pattern you follows using UITableView.

##### Insert first in `.order = .descending`

<img src="promo/Insert_and_remove/descending_work/insert_at_first_when_count.gif"  style="width: 260px;" width="260" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="promo/Insert_and_remove/descending_work/insert_at_first_when_scrollable.gif"  style="width: 260px;" width="260" /> 
```swift
onlyPictures.insertFirst(image: UIImage(named: "p11"), withAnimation: .popup)
```

##### Insert last in `.order = .descending`
<img src="promo/Insert_and_remove/descending_work/insert_at_last_when_count.gif"  style="width: 260px;" width="260" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="promo/Insert_and_remove/descending_work/insert_at_last_when_scrollable.gif"  style="width: 260px;" width="260" /> 
```swift
onlyPictures.insertLast(image: UIImage(named: "p12"), withAnimation: .popup)
```

##### Insert at specific position in `.order = .descending`, below added at 2nd position
<img src="promo/Insert_and_remove/descending_work/insert_at_specific_position_when_count.gif"  style="width: 260px;" width="260" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="promo/Insert_and_remove/descending_work/insert_at_specific_position_when_scrollable.gif"  style="width: 260px;" width="260" /> 
```swift
onlyPictures.insertPicture(UIImage(named: "p12"), atIndex: 2, withAnimation: .popup)
```

##### Remove first in `.order = .descending`
<img src="promo/Insert_and_remove/descending_work/remove_from_first_when_count.gif"  style="width: 260px;" width="260" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="promo/Insert_and_remove/descending_work/remove_from_first_when_scrollable.gif"  style="width: 260px;" width="260" /> 
```swift
onlyPictures.removeFirst(withAnimation: .popdown)
```

##### Remove last in `.order = .descending`
<img src="promo/Insert_and_remove/descending_work/remove_from_last_when_count.gif"  style="width: 260px;" width="260" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="promo/Insert_and_remove/descending_work/remove_from_last_when_scrollable.gif"  style="width: 260px;" width="260" /> 
```swift
onlyPictures.removeLast(withAnimation: .popdown)
```


##### Remove from specific position in `.order = .descending`, below removed from 2nd position
<img src="promo/Insert_and_remove/descending_work/remove_from_specific_position_when_count.gif"  style="width: 260px;" width="260" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="promo/Insert_and_remove/descending_work/remove_from_specific_position_when_scrollable.gif"  style="width: 260px;" width="260" /> 
```swift
onlyPictures.removePicture(atIndex: 2, withAnimation: .popdown)
```

##### *Let's check how insertion works with dynamic images. remove is same as above.*
##### Insert first in `.order = .descending`
<img src="promo/Insert_and_remove/URL_Images/insert_at_first.gif"  style="width: 260px;" width="260" />

```swift
let url = URL(string: "http://insightstobehavior.com/wp-content/uploads/2017/08/testi-5.jpg")
onlyPictures.insertFirst(withAnimation: .popup) { (imageView) in
        imageView.image = #imageLiteral(resourceName: "defaultProfilePicture")
        imageView.af_setImage(withURL: url!)
}
```

##### Insert last in `.order = .descending`
<img src="promo/Insert_and_remove/URL_Images/insert_at_last.gif"  style="width: 260px;" width="260" />

```swift
let url = URL(string: "http://insightstobehavior.com/wp-content/uploads/2017/08/testi-5.jpg")
onlyPictures.insertLast(withAnimation: .popup) { (imageView) in
        imageView.image = #imageLiteral(resourceName: "defaultProfilePicture")
        imageView.af_setImage(withURL: url!)
}
```

##### Insert at specific position in `.order = .descending`, below added at 2nd position
<img src="promo/Insert_and_remove/URL_Images/insert_at_specific_position.gif"  style="width: 260px;" width="260" />

```swift
let url = URL(string: "http://insightstobehavior.com/wp-content/uploads/2017/08/testi-5.jpg")
onlyPictures.insertPicture(atIndex: 2, withAnimation: .popup) { (imageView) in
        imageView.image = #imageLiteral(resourceName: "defaultProfilePicture")
        imageView.af_setImage(withURL: url!)
}
```

### Author

Kiran Jasvanee,

Skype - kiranjasvanee

LinkedIn - https://www.linkedin.com/in/kiran-jasvanee-ab363778

eMail -  kiran.jasvanee@gmail.com

### License

OnlyPictures is available under the MIT license. See the LICENSE file for more info.
