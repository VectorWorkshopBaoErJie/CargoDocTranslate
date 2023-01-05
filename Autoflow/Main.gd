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
    ##---> 做一些初化化工作
    print("项目启动！")
    init()
    
#    ## 遍历一次待翻译文件列表，并检索翻译库文件
#    for i in Data.DOC_files:
#        var new_str=i["目录"].replace("/Cargo_doc","/Cargo_doc_cn")
#        var new_file_str=new_str+"/"+i["文件"].replace(".md","_cn.md") ##对应的翻译库文件
#
#        var file = File.new() #尝试加载文件
#        if file.file_exists(new_file_str):
#            i["翻译"]=[]
#            i["翻译"].append(new_file_str)
#        file.close()
    
