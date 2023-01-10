extends Node2D

var loadController=LoadController.new()
var testController=TestController.new()

## 项目初始化工作
func init():
	## 执行控制器函数
	loadController.load_all_SF()
	loadController.load_all_TF()
	testController.Test_all_TF()
	
	
func _ready():
	Ui.add_test("项目启动！\n")
	init()
	
