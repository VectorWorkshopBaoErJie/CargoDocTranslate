## 这是对文件的抽象
class_name TFile

## 文件名
var file_name

## 文件路径
var path

func init(_path,_file_name):
    path=_path
    file_name=_file_name

## 获得扩展名
func get_extension():
    return file_name.get_extension()


func _to_string():
    return path+"/"+file_name
