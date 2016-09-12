## ACJSONPath

An easy way to get data from JSON.


## Installing

	Drag ACObjectFromDictionaryPath folder into your project.

```objective-c
#import "NSDictionary+ACObjectFromDictionaryPath.h"
```

## Usage

```objective-c
NSString *string = [NSDictionary ac_objectFrom:yourJSONObj path:@"query.created"];
             
NSNumber *unexpectedClassTypeWillBeNil = [NSDictionary ac_objectFrom:json
                                                                path:@"query.created"
                                                                type:[NSNumber class]];
```


## License

#### WTFPL


