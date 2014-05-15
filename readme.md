# ACJSONPath

有时候我们可能并不需要为某些接口的返回数据做对象模型，只是想取一个数据。<br /> 
层次稍微多一些的话，老式语法的 `objectForKey` `objectAtIndex` 只能说爱过了，<br /> 
即使使用新的语法特性也还是要写上一堆 `@"..."` 。<br />
ACJSONPath 实现了以类似 Javascript 中的语法结构来取 JSON 中的数据。<br />


---
Sometimes we do not need to map an JSON object.<br /> 
ACJSONPath makes it easy to get some data from a JSON object.



# Installing

	Drag ACJSONPath folder into your project. 
	
```objective-c
#import "ACJSONPath.h"   
```
    
# Usage

```objective-c
NSString *testStr = [[ACJSONPath sharedInstance] 
                    getDataFromJSONObject:yourJSONObj
                                   byPath:@"template.test[1][0].one[0][0].te"];

// UIKit+ACJSONPath
#import "UILabel+ACJSONPath.h"

[self.yourLabel ac_setTextWithJSON:youJSONObj andPath:@"abilities[0].name"];
```


## Requirements

* ARC


## LICENSE

####WTFPL 

```
            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO.

```


