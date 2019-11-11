<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Add.aspx.cs" Inherits="BMS.Page.UserManage.Add" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>新增用户</title>
    <meta name="renderer" content="webkit" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <link rel="stylesheet" href="/Scripts/layui/css/layui.css" media="all" />
    <link href="/Content/themes/base/jquery-ui.css" rel="stylesheet" />
</head>
<body>
    <div class="layui-form" lay-filter="form1" id="form1" style="padding: 20px 30px 0 0;">
        <div class="layui-form-item">
            <label class="layui-form-label">账号</label>
            <div class="layui-input-inline">
                <input type="hidden" id="hidId" name="Id" value="0" />
                <input type="text" name="UserName" id="txtUserName" lay-verify="required" placeholder="账号" autocomplete="off" class="layui-input">
            </div>
            <label class="layui-form-label">名称</label>
            <div class="layui-input-inline">
                <input type="text" name="StaffName" id="txtStaffName" lay-verify="required" placeholder="名称" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <%--  <label class="layui-form-label">角色</label>
            <div class="layui-input-inline" lay-filter="divRoleId">
                <select name="RoleId" id="selRoleId" lay-verify="required">
                </select>
            </div>--%>
            <label class="layui-form-label">部门</label>
            <div class="layui-input-inline">
                <select name="DepartId" id="selDeptId" lay-verify="required">
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">员工编号</label>
            <div class="layui-input-inline" style="width: 500px;">
                <input type="text" name="StaffCode" id="txtStaffCode" placeholder="员工编号" autocomplete="off" class="layui-input">
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

            $.ajax({
                url: '/Page/DeptManage/DeptHandler.ashx?operation=GetList&type=GetDropList&r=' + Math.random(),
                async: false,
                dataType: 'json',
                type: 'Post',
                data: {},
                success: function (result) {
                    var data = result.data;

                    str = '<option value="">请选择</option>';
                    $.each(data, function (index, item) {
                        str += '<option value="' + item.Id + '">' + item.DepartName + '</option>';
                    });
                    $('#selDeptId').html(str);
                    form.render('select');
                }
            });


            var id = '<%=Request["id"]%>';
            var model = '';
            if (id != '') {
                $('#hidId').val(id);
                $.ajax({
                    url: '/Page/UserManage/UserManageHandler.ashx?operation=GetModel',
                    async: false,
                    dataType: 'json',
                    type: 'Post',
                    data: { id: id },
                    success: function (data) {
                        model = data;
                        form.val("form1", data);
                        $('#txtUserName').attr("disabled", "disabled");
                        form.render();
                    }
                });
            }

            //监听提交
            form.on('submit(layuiadmin-app-form-submit)', function (data) {
                var field = data.field; //获取提交的字段
                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引  
                if (field.IsManager == "on") {
                    field.IsManager = true;
                } else {
                    field.IsManager = false;
                }
                //提交 Ajax 成功后，关闭当前弹层并重载表格
                $.ajax({
                    url: '/Page/UserManage/UserManageHandler.ashx?operation=Add',
                    dataType: 'json',
                    type: 'Post',
                    data: { model: JSON.stringify(field) },
                    success: function (data) {
                        if (data.success == 0) {
                            parent.layui.table.reload('LAY-app-content-list'); //重载表格
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
