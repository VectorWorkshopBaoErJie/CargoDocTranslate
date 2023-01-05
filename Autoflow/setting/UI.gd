extends CanvasLayer


func show_text(text):
    $Control/RichTextLabel.text=text

func get_text():
    return $Control/RichTextLabel.text

func add_test(text):
    $Control/RichTextLabel.text+=text

func _ready():
    $Control/ButtonA.connect("pressed",self,"__on_merge_button_down")
    
## 文档合并按钮按下后，开始执行合并操作。
func __on_merge_button_down():
    
    if Data.is_err: ## 只有检测无错误时，才能合并。
        add_test("项目有错误，无法合并，请修正错误后，尝试：\n")
        return
    else:
        add_test("开始执行合并：\n")
    
    var dir = Directory.new()
    
    for it in Data.SF_files:
        var file_str=it.path+"/"+it.file_name
        var new_dir_str=it.path.replace("/Cargo_doc","/Cargo_doc_merge")
        dir.make_dir_recursive(new_dir_str)
        if it.is_type==false:
            dir.copy(file_str,new_dir_str+"/"+it.file_name)
        else:
            var tf=Data.find_TF(it)
            if tf==null:
                continue ## 没有找到文件，就不合并
            var TL_S=tf.get_TL_entrys()
            
            for op in TL_S:
                if op.translation_text=="":
                    op.translation_text=op.source_text

            for op in TL_S:
                it.content=it.content.replace(op.source_text,op.translation_text)
            G.save_file(it.content,new_dir_str+"/"+it.file_name)
            
    add_test("合并完毕：\n")
