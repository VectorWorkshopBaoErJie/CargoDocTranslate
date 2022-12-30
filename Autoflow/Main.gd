extends Control

## 待翻译的文件路径列表 其每一个文件为一个字典，{文件:git-authentication.md, 目录:E:/develop/CargoDocTranslate/Cargo_doc/appendix },
var DOC_files=[]            

var Cargo_doc_path=G.dir_current_parent()+"Cargo_doc"
var Cargo_doc_cn_path=G.dir_current_parent()+"Cargo_doc_cn"

var is_test=true

func _ready():
    ##---> 做一些初化化工作
    print("当前项目路径：",G.dir_current_parent())
    $ButtonA.connect("button_down",self,"__on_merge_button_down")
    
    ## 扫描待翻译文件列表
    G.dir_contents(Cargo_doc_path,DOC_files)
    
    ## 遍历一次待翻译文件列表，并检索翻译库文件
    for i in DOC_files:
        var new_str=i["目录"].replace("/Cargo_doc","/Cargo_doc_cn")
        var new_file_str=new_str+"/"+i["文件"].replace(".md","_cn.md") ##对应的翻译库文件
        
        var file = File.new() #尝试加载文件
        if file.file_exists(new_file_str):
            i["翻译"]=[]
            i["翻译"].append(new_file_str)
        file.close()

    #print(DOC_files)
    ##---> 做一些检测工作
    #is_test=config_obj.TL_flow_objs_init()

## 文档合并按钮按下后，开始执行合并操作。
func __on_merge_button_down():
    ## 遍历所有文件
    var dir = Directory.new()
    for i in DOC_files:
        var file_str=i["目录"]+"/"+i["文件"]
        var new_dir_str=i["目录"].replace("/Cargo_doc","/Cargo_doc_merge")
        dir.make_dir_recursive(new_dir_str)
        if i.has("翻译"):
            var content=G.load_file(i["翻译"][0]) ##  目前排除补充翻译的情况
            var TL_s=get_TL_entrys(content)
            TL_flow_obj_sorting_by_length(TL_s)  ##  对字符翻译数组按字符串长度进行一次排序。
            ## 这里应该对循环引用等进行验证
            var original_text=G.load_file(file_str)
            
            for it in TL_s:
                original_text=original_text.replace(it.source_text,it.translation_text)
            
            print(original_text)
            G.save_file(original_text,new_dir_str+"/"+i["文件"])
        else: ## 说明些文件没有对应的翻译,则直接进行移动操作
            pass
            var new_file_str=new_dir_str+"/"+i["文件"]
            dir.rename(file_str,new_file_str)

## 从内容获得翻译词条
func get_TL_entrys(content):
    var regex = RegEx.new()
    regex.compile("\\{==\\+==\\}\\n(?<source>[\\s\\S]*?)\\n\\{==\\+==\\}\\n(?<translation>[\\s\\S]*?)\\n\\{==\\+==\\}")
    var results = regex.search_all(content)
    var TL_s=[]
    for i in results:
        var tl_entry=TL.new(i.get_string("source"),i.get_string("translation"))
        TL_s.append(tl_entry)
        pass
    return TL_s

## 对字符翻译数组按字符串长度进行一次排序。
func TL_flow_obj_sorting_by_length(_TLL):
    for i in range(_TLL.size()):
        for u in range(i,_TLL.size()):
            if _TLL[u].source_text.length()>_TLL[i].source_text.length():
                var c=_TLL[i]
                _TLL[i]=_TLL[u]
                _TLL[u]=c






