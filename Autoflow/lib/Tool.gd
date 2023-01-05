# 工具脚本
extends Node

## 从文件中计数分割标志的数量
func get_mark_num_from_file(file_path:String,mark="{==+==}")->int:
    var content:String=G.load_file(file_path)
    return content.countn(mark)

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
