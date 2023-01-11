extends Node

## 遍历目录，获得文件列表
func dir_contents(path,files:Array):
    var dir = Directory.new()
    if dir.open(path) == OK:
        dir.list_dir_begin()
        var file_name = dir.get_next()
        while file_name != "":
            if file_name=="." or file_name=="..":
                file_name = dir.get_next()
                continue;
            if dir.current_is_dir() :
                # print("发现目录:" + file_name)
                dir_contents(path+"/"+file_name,files)
            else:
                #files.append({"目录":path,"文件":file_name})
                var t=TFile.new()
                t.init(path,file_name)
                files.append(t)
                # print("发现文件:" + file_name)
            file_name = dir.get_next()
    else:
        print("尝试访问路径时出错。")

## 获得当前项目的父级目录
func dir_current_parent():
    var pathA=ProjectSettings.globalize_path("res://")
    var pathB=pathA.split("/")
    var new_path=""
    if pathB.size()>2:
        for i in range(0,pathB.size()-2):
            new_path+=pathB[i]+"/";
    return new_path
    

func load_file(path):
    var file = File.new()
    file.open(path, File.READ)
    var content = file.get_as_text()
    file.close()
    return content


func save_file(content,path):
    var file = File.new()
    file.open(path, File.WRITE)
    file.store_string(content)
    file.close()
