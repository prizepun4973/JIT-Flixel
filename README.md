由于引擎当前进度问题，教程文档可能会有较多漏洞，请谅解   
# State JIT教程文档 (beta)

再开始前，你需要知道什么是State（FlxState）。如果你已经了解，你可以跳过下面的介绍。   
## 何为State（FlxState，以下称为State）
State即游戏的界面，比如游玩曲目时的界面，或者菜单界面等。    
   
   
在编程上，State有三种基本行为，创建（create），更新（update）和销毁（destroy）。   
create：当切换到当前State的初始化行为   
update：游戏刷新时的行为   
destroy：当切换到其他State或游戏关闭时的销毁操作   
（其他几个后面做）   
   
## 如何进行State间的切换
等我回家把东西做了   
   
## State编程
以下为State JIT文件的基本架构：   
   
```
function onCreate()
    --TODO
end

function onUpdate(elapsed)
    --TODO
end

function onDestroy()
    --TODO
end
```