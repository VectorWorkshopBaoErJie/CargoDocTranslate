class_name LoadController extends Node

## 扫描待翻译文件列表
func load_all_SF():
    var files=[]
    G.dir_contents(Data.DOC_path,files)

    for it in files:
        var tr=SF.new()
        tr.path=it.path
        tr.file_name=it.file_name
        if Data.tr_type.has(it.get_extension()):
            tr.is_type=true
            tr.content=G.load_file(tr.path+"/"+tr.file_name)
        Data.SF_files.append(tr)
    

func load_all_TF():
    
    
    pass


