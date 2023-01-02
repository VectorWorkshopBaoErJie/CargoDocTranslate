extends Control

## 待翻译的文件路径列表 其每一个文件为一个字典，{文件:git-authentication.md, 目录:E:/develop/CargoDocTranslate/Cargo_doc/appendix },
var DOC_files=[]            

var Cargo_doc_path=G.dir_current_parent()+"Cargo_doc"
var Cargo_doc_cn_path=G.dir_current_parent()+"Cargo_doc_cn"

var is_test=true

func _ready():
    ##---> 做一些初化化工作
    print("当前项目路径：",G.dir_current_parent())
    $ButtonA.connect("pressed",self,"__on_merge_button_down")
    
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
    print("开始执行合并：")
    var dir = Directory.new()
    for i in DOC_files:
        var file_str=i["目录"]+"/"+i["文件"]
        var new_dir_str=i["目录"].replace("/Cargo_doc","/Cargo_doc_merge")
        dir.make_dir_recursive(new_dir_str)
        if i.has("翻译"):
            var content=G.load_file(i["翻译"][0]) ##  目前排除补充翻译的情况
            var TL_s=get_TL_entrys(content)
            TL_flow_obj_sorting_by_length(TL_s)  ##  对字符翻译数组按字符串长度进行一次排序。
            
            
            var original_text=G.load_file(file_str)
            
            if !TL_flow_obj_in_test(TL_s): ## 反包含验证
                print("上面反包含的文件是：",i["文件"])
                return ## 反向包含将退出
            
            for it in TL_s:
                if original_text.find(it.source_text)==-1:  ## 验证原文不存在的情况
                    print("此翻译文本未找到,","在",i["文件"])
                    print(it.source_text)
                    continue
                original_text=original_text.replace(it.source_text,it.translation_text)
            
            if TL_s.size()>0:
                print(file_str,"文件已进行合并。")
            G.save_file(original_text,new_dir_str+"/"+i["文件"])
        else: ## 说明些文件没有对应的翻译,则直接进行移动操作
            pass
            var new_file_str=new_dir_str+"/"+i["文件"]
            dir.copy(file_str,new_file_str)
            
    print("执行合并完成：")
    
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

## 验证词条的反包含性,即验证较短词条是否重复替代较长词条翻译后的结果。
func TL_flow_obj_in_test(_TLL):
    var length=_TLL.size()-1
    if length==-1:
        return true
        
    var is_pass=true
    while length>=0:
        for u in range(length):
            if _TLL[u].translation_text.find(_TLL[length].source_text)!=-1:
                is_pass=false
                print("该词条反包含：\n",_TLL[length].source_text)
            pass
        length-=1
    return is_pass



