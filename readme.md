## ACJSONPath

An easy way to get data from JSON.


## Installing

	Drag ACJSONPath folder into your project.

```objective-c
#import "ACJSONPath.h"   
```

## Usage

```objective-c
NSString *testStr =
[[ACJSONPath sharedInstance]
getDataFromJSONObject:yourJSONObj
               byPath:@"template.test[1][0].one[0][0].te"];

```


## License

#### WTFPL


