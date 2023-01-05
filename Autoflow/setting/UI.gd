extends CanvasLayer


func show_text(text):
    $Control/RichTextLabel.text=text

func get_text():
    return $Control/RichTextLabel.text

func _ready():
    $Control/ButtonA.connect("pressed",self,"__on_merge_button_down")
    
    
## 文档合并按钮按下后，开始执行合并操作。
func __on_merge_button_down():
    print("执行合并操作：")
    if Data.is_err: ## 只有检测无错误时，才能合并。
        return
    
#    ## 遍历所有文件
#    print("开始执行合并：")
#    var dir = Directory.new()
#    for i in Data.DOC_files:
#        var file_str=i["目录"]+"/"+i["文件"]
#        var new_dir_str=i["目录"].replace("/Cargo_doc","/Cargo_doc_merge")
#        dir.make_dir_recursive(new_dir_str)
#        if i.has("翻译"):
#            var content=G.load_file(i["翻译"][0]) ##  目前排除补充翻译的情况
#            var TL_s
#
#            for it in TL_s: 
#                pass
#
#            var original_text=G.load_file(file_str)
#
#
#            for it in TL_s:
#                if original_text.find(it.source_text)==-1:  ## 验证原文不存在的情况
#                    print("此翻译文本未找到,","在",i["文件"])
#                    print(it.source_text)
#                    continue
#                original_text=original_text.replace(it.source_text,it.translation_text)
#
#            if TL_s.size()>0:
#                print(file_str,"文件已进行合并。")
#            G.save_file(original_text,new_dir_str+"/"+i["文件"])
#        else: ## 说明些文件没有对应的翻译,则直接进行移动操作
#            pass
#            var new_file_str=new_dir_str+"/"+i["文件"]
#            dir.copy(file_str,new_file_str)
#
#    print("执行合并完成：")
    

