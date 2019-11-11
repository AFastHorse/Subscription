<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="BMS.Page.PublicCustomer.Index" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>公开客户</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/Scripts/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="/Scripts/css/admin.css" media="all">
</head>
<body>
    <div class="layui-fluid">
        <div class="layui-card">
            <div class="layui-card-body">
                <table id="LAY-app-content-list" lay-filter="LAY-app-content-list"></table>
                <script type="text/html" id="table-content-list">
                    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="view"><i class="layui-icon layui-icon-edit"></i>查看</a>
                </script>
            </div>
        </div>
    </div>

    <script src="/Scripts/layui/layui.js"></script>
    <script>
        var flag = false;
        layui.config({
            base: '/Scripts/js/' //静态资源所在路径
        }).extend({
            index: 'lib/index' //主入口模块
        }).use(['index', 'form', 'table'], function () {
            var table = layui.table,
                form = layui.form,
                $ = layui.$;
            table.render({
                elem: "#LAY-app-content-list",
                url: '/Page/PersonalCustomer/CustomerHandler.ashx?operation=GetListForPublic&r=' + Math.random(),
                cols: [
                    [
                        { type: "numbers", fixed: "center" },
                        { field: "Name", width: 120, title: "名称" },
                        { field: "ItemExt", title: "项目", width: 150, align: 'center' },
                        {
                            field: 'Status', title: '状态', width: 100, align: 'center', templet: function (d) {
                                // 跟进状态:1、新增；2、跟进；3、成交；4、放弃；
                                switch (d.Status) {
                                    case 1:
                                        return "新增";
                                    case 2:
                                        return "跟进";
                                    case 3:
                                        return "成交";
                                    case 4:
                                        return "放弃";
                                }
                            }
                        },
                        {
                            field: "MobilePhone", width: 120, title: "电话", align: 'center', templet: function (d) {
                                var str = d.MobilePhone;
                                if (str != "" && flag) { flag = false; return d.MobilePhone; }
                                if (str != '') {
                                    return str.substr(0, 3) + "****" + str.substr(7, 4);
                                } else {
                                    return "";
                                }
                            }
                        },
                        {
                            field: "WeiXin", width: 120, title: "微信", align: 'center', templet: function (d) {
                                var str = d.WeiXin;
                                if (str != '') {
                                    return str.substr(0, 2) + "****" + str.substr(str.length - 2, 2);
                                } else {
                                    return "";
                                }
                            }
                        },
                        {
                            field: "QQ", width: 120, title: "QQ", align: 'center', templet: function (d) {
                                var str = d.QQ;
                                if (str != '') {
                                    return str.substr(0, 2) + "****" + str.substr(str.length - 2, 2);
                                } else {
                                    return "";
                                }
                            }
                        },
                        { field: "IntentionExt", title: "意向", width: 100, align: 'center' },
                        { field: "FromExt", title: "来源", width: 100, align: 'center' },
                        { field: "CreateUserName", title: "录入人", align: 'center', width: 100 },
                        { field: "CreateTime", title: "录入时间", align: 'center', width: 120 },
                        { field: "Remark", title: "备注", align: "center", width: 300 },
                        { title: "操作", minWidth: 150, align: "center", fixed: "right", toolbar: "#table-content-list" }
                    ]
                ],
                height: 800,
                page: !0,
                limit: 10,
                limits: [10, 20, 30]

            });

            table.on("tool(LAY-app-content-list)", function (obj) {
                var row = obj.data;
                if (obj.event == "view") {
                    $.ajax({
                        url: '/Page/PersonalCustomer/CustomerHandler.ashx?operation=ChangeState',
                        dataType: 'json',
                        type: 'Post',
                        data: { id: obj.data.Id },
                        success: function (data) {
                            if (data.success == "0") {
                                flag = true;
                                obj.update({
                                    MobilePhone: row.MobilePhone
                                });
                                layer.msg("已转到我的客户");
                            } else {
                                layer.alert(data.msg);
                            }
                        }
                    });
                }
            });

        });
    </script>
</body>
</html>

