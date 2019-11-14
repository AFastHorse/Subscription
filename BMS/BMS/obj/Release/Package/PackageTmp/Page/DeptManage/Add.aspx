<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Add.aspx.cs" Inherits="BMS.Page.DeptManage.Add" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>新增部门</title>
    <meta name="renderer" content="webkit" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <link rel="stylesheet" href="/Scripts/layui/css/layui.css" media="all" />
    <link href="/Content/themes/base/jquery-ui.css" rel="stylesheet" />
</head>
<body>
    <div class="layui-form" lay-filter="form1" id="form1" style="padding: 20px 30px 0 0;">
        <div class="layui-form-item">
            <label class="layui-form-label">名称</label>
            <div class="layui-input-inline">
                <input type="hidden" id="hidId" name="Id" value="0" />
                <input type="text" name="DepartName" id="txtName" lay-verify="required" placeholder="名称" autocomplete="off" class="layui-input">
            </div>
            <label class="layui-form-label">上级部门</label>
            <div class="layui-input-inline">
                <input type="hidden" id="hidParentId" name="ParentId" />
                <input type="text" readonly name="ParentName" id="txtParentName" class="layui-input" />
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">排序号</label>
            <div class="layui-input-inline">
                <input type="text" name="OrderNum" id="txtOrderNum" placeholder="排序号" autocomplete="off" class="layui-input">
            </div>
            <label class="layui-form-label">备注</label>
            <div class="layui-input-inline">
                <input type="text" name="Remark" id="txtRemark" placeholder="备注" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item layui-hide">
            <input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="确认添加">
        </div>
    </div>

    <script src="/Scripts/layui/layui.js"></script>

    <script>
        layui.config({
            base: '/Scripts/js/' //静态资源所在路径
        }).extend({
            index: 'lib/index' //主入口模块
        }).use(['index', 'form'], function () {
            var $ = layui.$, form = layui.form;
            var id = '<%=Request["id"]%>';
            var model = '';
            if (id != '') {
                $('#hidId').val(id);
                $.ajax({
                    url: '/Page/DeptManage/DeptHandler.ashx?operation=GetModel',
                    async: false,
                    dataType: 'json',
                    type: 'Post',
                    data: { id: id },
                    success: function (data) {
                        model = data;
                        form.val("form1", data);
                        form.render();
                    }
                });
            } else {
                var parentId = '<%=Request["parentId"]%>';
                $.ajax({
                    url: '/Page/DeptManage/DeptHandler.ashx?operation=GetMaxCode&parentId=' + parentId,
                    async: false,
                    dataType: 'json',
                    type: 'Post',
                    data: { parentId: parentId },
                    success: function (data) {
                        $('#hidParentId').val(data.Id);
                        $('#txtParentName').val(data.DepartName);
                        $('#txtOrderNum').val(data.OrderNum);
                        form.render();
                    }
                });
            }

            //监听提交
            form.on('submit(layuiadmin-app-form-submit)', function (data) {
                var field = data.field; //获取提交的字段
                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引  

                //提交 Ajax 成功后，关闭当前弹层并重载表格
                $.ajax({
                    url: '/Page/DeptManage/DeptHandler.ashx?operation=Add',
                    dataType: 'json',
                    type: 'Post',
                    data: { model: JSON.stringify(field) },
                    success: function (data) {
                        if (data.success == 0) {
                            parent.renderTable(); //重载表格
                            parent.layer.close(index); //再执行关闭 
                        } else {
                            layer.alert(data.msg);
                        }
                    }
                });

            });
        })
    </script>
</body>
</html>

