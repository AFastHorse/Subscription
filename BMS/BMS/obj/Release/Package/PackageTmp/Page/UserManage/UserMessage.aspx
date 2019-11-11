<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserMessage.aspx.cs" Inherits="BMS.Page.UserManage.UserMessage" %>

<!DOCTYPE html>

<html>
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>修改资料</title>
    <meta name="renderer" content="webkit" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <link rel="stylesheet" href="/Scripts/layui/css/layui.css" media="all" />
    <link href="/Content/themes/base/jquery-ui.css" rel="stylesheet" />
</head>
<body>
    <div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list" style="padding: 20px 30px 0 0;">
        <div class="layui-form-item">
            <label class="layui-form-label">真实姓名</label>
            <div class="layui-input-inline" style="width: 265px;">
                <input type="text" name="RealName" id="txtRealName" placeholder="真实姓名" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item layui-hide">
            <input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="保存">
        </div>
    </div>

    <script src="/Scripts/layui/layui.js"></script>

    <script>
        layui.config({
            base: '/Scripts/js/' //静态资源所在路径
        }).extend({
            index: 'lib/index' //主入口模块
        }).use(['index', 'form'], function () {
            var $ = layui.$
            , form = layui.form;

            $.ajax({
                url: '/Page/UserManage/UserManageHandler.ashx?operation=GetModel',
                dataType: 'json',
                type: 'Post',
                data: { parentId: 0 },
                success: function (data) {
                    if (data != null) {
                        $('#txtRealName').val(data.RealName);
                    }
                }
            });

            //监听提交
            form.on('submit(layuiadmin-app-form-submit)', function (data) {
                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引                

                //提交 Ajax 成功后，关闭当前弹层并重载表格
                $.ajax({
                    url: '/Page/UserManage/UserManageHandler.ashx?operation=UpdateUserMsg',
                    dataType: 'json',
                    type: 'Post',
                    data: {
                        realName: $('#txtRealName').val(),
                    },
                    success: function (data) {
                        if (data.success == 0) {
                            layer.alert(data.msg, function () {
                                parent.layer.close(index); //再执行关闭
                            });
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
