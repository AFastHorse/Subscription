<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ImportCustomer.aspx.cs" Inherits="BMS.Page.PersonalCustomer.ImportCustomer" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <title>导入</title>
    <meta name="renderer" content="webkit" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <link rel="stylesheet" href="/Scripts/layui/css/layui.css" media="all" />
    <link href="/Content/themes/base/jquery-ui.css" rel="stylesheet" />
</head>
<body>
    <div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list" style="padding: 20px 30px 0 0;">
        <div class="layui-form-item" style="padding-left: 30px;">
            <button type="button" class="layui-btn layuiadmin-btn-list" id="uploadExcel">选择文件</button>
        </div>
        <div class="layui-form-item" style="padding-left: 30px;">
            <button type="button" class="layui-btn layuiadmin-btn-list" id="btnUpload">导入</button>
        </div>
        <div class="layui-form-item" style="padding-left: 30px;">
            <a href="#" id="templateFile" style="color: #1599e8;">模板下载</a>
        </div>
    </div>

    <script src="/Scripts/layui/layui.js"></script>

    <script>

        //获取url中的参数
        function getUrlParam(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
            var r = window.location.search.substr(1).match(reg);  //匹配目标参数
            if (r != null) return unescape(r[2]); return null; //返回参数值
        }

        layui.config({
            base: '/Scripts/js/' //静态资源所在路径
        }).extend({
            index: 'lib/index' //主入口模块
        }).use(['index', 'form', 'element', 'upload'], function () {
            var $ = layui.$
            , form = layui.form
            , element = layui.element
            , upload = layui.upload;

            var tableId = getUrlParam('tableId');
            var url = '/Page/PersonalCustomer/CustomerHandler.ashx?operation=ImportData';
            var downloadUrl = '/Page/PersonalCustomer/CustomerHandler.ashx?operation=DownloadTemplate';
            $('#templateFile').attr('href', downloadUrl + "&fileName=客户信息.xls");

            var uploader = upload.render({
                elem: '#uploadExcel',
                url: url,
                before: function (obj) {
                    layer.load();
                },
                done: function (res, index, upload) {
                    if (res.code == 0) {
                        alert(res.msg);
                        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引  
                        parent.layui.table.reload('LAY-app-content-list');
                        parent.layer.close(index); //再执行关闭 
                    }
                    layer.closeAll('loading');
                },
                error: function () {
                    layer.alert("导入失败");
                    layer.closeAll('loading');
                },
                accept: 'file',
                // acceptMime: 'image/jpg,image/png',
                acceptMime: 'application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                //exts: 'xls|xlsx',
                size: 1024000,
                auto: false,
                bindAction: '#btnUpload'
            });
        })
    </script>
</body>
</html>

