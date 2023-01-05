## 这是项目的数据库，这里进行了简化，将项目配置也归并到这里了。
extends Node

var is_err=false

## 待翻译的原文件 组
var SF_files=[]

## 翻译库文件 组
var TF_files=[]

## 以下是项目的配置
var DOC_path=G.dir_current_parent()+"Cargo_doc"
var DOC_cn_path=G.dir_current_parent()+"Cargo_doc_cn"


## 待翻译的文件类型
var tr_type=["md"]
var mark="{==+==}"


func find_SF(tf:TF):
    for it in Data.SF_files:
        var na1=tf.file_name.replace("_cn.md",".md")
        var na2=tf.path.replace("Cargo_doc_cn","Cargo_doc")
        if it.file_name==na1 and it.path==na2:
            return it
    return null



