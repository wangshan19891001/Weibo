#Readme

## 框架

### 控制器
* 多个控制器父类相同: 当多个控制器具有较多相同代码时候, 可使用继承的方法抽取一个父类
* 多个控制器父类不相同: 此时, 不能使用继承的方法重构代码. 在这里, 为了让所有push进来的控制器的左,右上方的按钮相同. 重写导航控制器, 重写导航控制器中的push方法, 拦截所有通过push 进入的控制器. 自定义导航控制器, 重写push方法 (90% 的拦截, 都是通过自定义类, 重写自带的方法实现的)
* "duplicate symbol _OBJC_METACLASS_$_类名 in:" 连接错误
	
	90% 都是因为#import 了.m文件
	也可能是因为项目中存在了2个一样的.h或.m文件
	
### navigationItem

* 项目中有多处地方用到这段代码
* 每一段代码都应该放在最合适的地方: 这段代码明显在创建一个UIBarButtonItem, 所以跟UIBarButtonItem 相关
* 按照明明习惯和规范:[UIBarButtonItem itemWith...]这种形式创建item比较规范
* initialize 在第一次使用的时候调用