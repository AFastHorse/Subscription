<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PowerManage.aspx.cs" Inherits="BMS.Page.RoleManage.PowerManage" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <title>权限管理</title>
    <meta name="renderer" content="webkit" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <link rel="stylesheet" href="/Scripts/layui/css/layui.css" media="all" />
    <link href="/Content/themes/base/jquery-ui.css" rel="stylesheet" />
    <link href="/Scripts/js/modules/formSelects-v4.css" rel="stylesheet" />
</head>
<body>
    <div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list" style="padding: 20px 30px 0 0;">
        <div class="layui-form-item">
            <label class="layui-form-label">权限</label>
            <div class="layui-input-inline" style="width: 500px;">
                <select id="selMenu" xm-select="selMenu" name="selMenu">
                </select>
            </div>
        </div>
        <div class="layui-form-item layui-hide">
            <input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="确认">
        </div>
    </div>

    <script src="/Scripts/layui/layui.js"></script>
    <script>

        layui.config({
            base: '/Scripts/js/' //静态资源所在路径
        }).extend({
            index: 'lib/index' //主入口模块
            , formSelects: 'formSelects-v4'
        }).use(['index', 'form', 'formSelects'], function () {
            var $ = layui.$,
                form = layui.form,
                formSelects = layui.formSelects;

            $.ajax({
                url: '/Page/MenuManage/MenuHandler.ashx?operation=GetList' + "&r=" + Math.random(),
                async: false,
                dataType: 'json',
                type: 'post',
                success: function (result) {
                    var data = result.data;
                    $('#selMenu').html('');
                    var str = '';
                    if (data.length > 0) {
                        $.each(data, function (index, value) {
                            str += '<option value="' + value.Id + '">' + value.Name + '</option>';
                        });
                    }
                    $('#selMenu').html(str);
                }
            });

            var id = '<%=Request["id"]%>';

            if (id != '') {
                $('#hidId').val(id);
                $.ajax({
                    url: '/Page/RoleManage/RoleHandler.ashx?operation=GetPowerList',
                    dataType: 'json',
                    type: 'Post',
                    data: { id: id },
                    success: function (data) {
                        formSelects.value('selMenu', eval('[' + data + ']'));
                        form.render('select');
                    }
                });
            }
            //监听提交
            form.on('submit(layuiadmin-app-form-submit)', function (data) {

                var field = data.field; //获取提交的字段     
                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引  

                var menuIds = formSelects.value('selMenu', 'valStr');
                var roleId = id;

                //提交 Ajax 成功后，关闭当前弹层并重载表格
                $.ajax({
                    url: '/Page/RoleManage/RoleHandler.ashx?operation=UpdatePower' + "&r=" + Math.random(),
                    dataType: 'json',
                    type: 'Post',
                    data: { menuIds: menuIds, roleId: roleId },
                    success: function (data) {
                        if (data.success == 0) {
                            parent.layer.close(index); //再执行关闭 
                        } else {
                            layer.alert(data.msg);
                        }
                    }
                });

            });

            formSelects.render('selMenu');
        })
    </script>
</body>
</html>
