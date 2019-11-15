<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderDetail.aspx.cs" Inherits="BMS.Page.SubscriptionManage.OrderDetail" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>认购详情</title>
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
                </div>
            </div>
            <div class="layui-card-body">
                <table id="LAY-app-content-list" lay-filter="LAY-app-content-list"></table>
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
                url: 'SubscriptionManage.ashx?operation=GetOrderDetail&OrderNo=<%=Request["OrderNo"]%>&r=' + Math.random(),
                    cols: [
                        [
                            { type: 'numbers', title: '序号', width: 80 },
                            { field: "ProductType", width: 100, title: "产品类型" },
                            { field: "SavingProduct", width: 200, title: "产品名称" },
                            { field: "SPMoney", title: "金额", width: 120, align: 'center' },
                            { field: "SPPaymentAge", title: "交保年限", width: 100, align: 'center' },
                            { field: "CreateTime", title: "认购时间", width: 200, align: 'center' }
                        ]
                    ],
                    page: !0,
                    limit: 10,
                    limits: [10, 20, 30]

                });
            });
    </script>
</body>
</html>

