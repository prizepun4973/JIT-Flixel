# State JIT教程文档 (beta)

再开始前，你需要知道什么是State（FlxState）。如果你已经了解，你可以跳过下面的介绍。   
## 何为State（FlxState，以下称为State）
State即游戏的界面，比如游玩曲目时的界面，或者菜单界面等。    
   
在编程上，State有三种行为，创建（create），更新（update）和销毁（destroy）。   
create：当切换到当前State的初始化行为   
update：游戏刷新时的行为   
destroy：当切换到其他State或游戏关闭时的销毁操作   

