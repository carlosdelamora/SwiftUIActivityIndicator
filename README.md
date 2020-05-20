# SwiftUIActivityIndicator
We create a native activity indicator using SwiftUI. 

## Usage

You need to create the content `View` that goes inside your activity indicator. For example, 

```
struct MyContent: View {
    var body: some View {
        GeometryReader { geometry in
            Color
                .red
                .cornerRadius(min(geometry.size.width, geometry.size.height))
                .frame(width: 6, height: 6)
        }
    }
}
```
Now you can pass your content as one of the arguments to the `ActivityIndicator` initialization view. 

``` 
ActivityIndicatorView(dataSource: 0...12) { _ in
      StandardPetalContent()
}
```

The initialization method for `ActivityIndicator` is similar to that of the standard SwiftUI component `ForEach`. Indeed, 
```
init(diameter: CGFloat = 110,
         animationScale: CGFloat = 1.0,
         dataSource: Data,
         contentBuilder: @escaping (Data.Element) -> Content) { ...
 }
```
Where `Data: RandomAcessCollection`. We can use then use the `Data.Element` to configure our content. For example, 

```
ActivityIndicatorView(dataSource: "Swift".reversed().map({"\($0)"})) { element in
    Text(element).foregroundColor(.blue)
}
```

The argument `diameter` increases the size of the `ActivityIndicator` and the `animationScale` animates to the given scale gradually in the same fashion the opacity changes.
