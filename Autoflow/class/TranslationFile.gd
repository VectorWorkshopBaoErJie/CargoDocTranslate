class_name TF extends TFile

## 文本内容
var content:String

## 从内容获得翻译词条
func get_TL_entrys():
	var regex = RegEx.new()
	regex.compile("\\{==\\+==\\}\\n(?<source>[\\s\\S]*?)\\n\\{==\\+==\\}\\n(?<translation>[\\s\\S]*?)\\{==\\+==\\}")
	var results = regex.search_all(content)
	var TL_s=[]
	for i in results:
		var tl_entry=TL.new(i.get_string("source"),i.get_string("translation"))
		TL_s.append(tl_entry)
		
	TL_flow_obj_sorting_by_length(TL_s)
	return TL_s

## 对字符翻译数组按字符串长度进行一次排序。
func TL_flow_obj_sorting_by_length(_TLL):
	for i in range(_TLL.size()):
		for u in range(i,_TLL.size()):
			if _TLL[u].source_text.length()>_TLL[i].source_text.length():
				var c=_TLL[i]
				_TLL[i]=_TLL[u]
				_TLL[u]=c
