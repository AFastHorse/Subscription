<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="BMS.Page.SubscriptionManage.Index" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>认购管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="../../Scripts/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="../../Scripts/css/admin.css" media="all">
</head>
<body>
    <div class="layui-fluid">
        <div class="layui-card">
            <div class="layui-form layui-card-header layuiadmin-card-header-auto">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">名称</label>
                        <div class="layui-input-inline">
                            <input type="text" name="txtName" id="txtName" placeholder="名称" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-contlist-search">
                            <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                        </button>
                        <button class="layui-btn layuiadmin-btn-list" data-type="export">导出</button>
                    </div>
                </div>
            </div>

            <div class="layui-card-body">
                <table id="LAY-app-content-list" lay-filter="LAY-app-content-list"></table>
                <script type="text/html" id="table-content-list">
                    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>
                    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>
                </script>
            </div>
        </div>
    </div>

    <script src="../../Scripts/layui/layui.js"></script>
    <script>
        layui.config({
            base: '../../Scripts/js/' //静态资源所在路径
        }).extend({
            index: 'lib/index' //主入口模块
        }).use(['index', 'form', 'table'], function () {
            var table = layui.table,
                form = layui.form,
                $ = layui.$;


            table.render({
                elem: "#LAY-app-content-list",
                url: 'SubscriptionManage.ashx?operation=GetList&r=' + Math.random(),
                cols: [
                    [
                        { type: 'numbers', title: '序号', width: 100 },
                        { field: "UserName", width: 100, title: "名称" },
                        { field: "Sex", width: 80, title: "性别" },
                        { field: "API", title: "API", width: 200, align: 'center' },
                        { field: "TotalMoney", title: "总金额", width: 200, align: 'center' },
                        { field: "Destination", title: "旅游方案", width: 300, align: 'center' },
                        { field: "FMX_Money", title: "福满星保费", width: 100, align: 'center' },
                        { field: "FMX_Count", title: "福满星件数", width: 100, align: 'center' },
                        { field: "CreateTime", title: "认购时间", width: 300, align: 'center' }
                    ]
                ],
                page: !0,
                limit: 10,
                limits: [10, 20, 30]

            });
            table.on('row(LAY-app-content-list)', function (obj) {
                var data = obj.data;
                layer.open({
                    type: 2
                    , title: '目标详情'
                    , content: 'OrderDetail.aspx?OrderNo=' + data.OrderNo
                    , maxmin: true
                    , area: ['1060px', '600px']
                });

                //标注选中样式
                obj.tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
            });

            //监听搜索
            form.on('submit(LAY-app-contlist-search)', function (data) {
                var field = data.field;
                //执行重载
                table.reload('LAY-app-content-list', {
                    where: field
                });
            });

            var active = {
                export: function () {
                    window.location.href = 'SubscriptionManage.ashx?operation=ExportData&UserName=' + $('#txtName').val() + '&r=' + Math.random();
                }
            };

            $('.layui-btn.layuiadmin-btn-list').on('click', function () {
                var type = $(this).data('type');
                active[type] ? active[type].call(this) : '';
            });

        });
    </script>
</body>
</html>

