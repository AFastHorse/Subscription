<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="BMS.Register" %>

<!DOCTYPE html>

<html>
<head id="Head1" runat="server">
    <title>注册</title>
    <meta charset="utf-8" />
    <meta name="renderer" content="webkit" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <link rel="stylesheet" href="/Scripts/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="/Scripts/css/admin.css" media="all" />
    <link rel="stylesheet" href="/Scripts/css/login.css" media="all" />
</head>
<body>
    <div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">
        <div class="layadmin-user-login-main">
            <div class="layadmin-user-login-box layadmin-user-login-header">
                <h2>天华教育</h2>
            </div>
            <div class="layadmin-user-login-box layadmin-user-login-body layui-form">
                <div class="layui-form-item">
                    <label class="layadmin-user-login-icon layui-icon layui-icon-cellphone" for="txtCellPhone"></label>
                    <input type="text" name="UserName" id="txtUserName" lay-verify="required" placeholder="账号" class="layui-input" />
                </div>
                <div class="layui-form-item">
                    <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="txtPassword"></label>
                    <input type="password" name="Password" id="txtPassword" lay-verify="required" maxlength="16" placeholder="密码" class="layui-input" />
                </div>
                <div class="layui-form-item">
                    <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="txtRepass"></label>
                    <input type="password" name="repass" id="txtRepass" lay-verify="required" maxlength="16" placeholder="确认密码" class="layui-input" />
                </div>
                <div class="layui-form-item">
                    <label class="layadmin-user-login-icon layui-icon layui-icon-username" for="txtNickName"></label>
                    <input type="text" name="RealName" id="txtRealName" lay-verify="required" maxlength="50" placeholder="真实姓名" class="layui-input" />
                </div>
                <div class="layui-form-item">
                    <label class="layadmin-user-login-icon layui-icon layui-icon-auz" for="selRoleId"></label>
                    <select name="RoleId" id="selRoleId" lay-verify="required">
                    </select>
                </div>
                <div class="layui-form-item">
                    <label class="layadmin-user-login-icon layui-icon layui-icon-auz" for="selRoleId"></label>
                    <select name="DeptId" id="selDeptId" lay-verify="required">
                    </select>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block" style="margin-left: 0;">
                        <input type="checkbox" name="IsManager" id="ckbIsManager" lay-skin="primary" title="是否部门主管">
                    </div>
                </div>
                <div class="layui-form-item">
                    <button class="layui-btn layui-btn-fluid" id="btnRegiste" lay-submit lay-filter="LAY-user-reg-submit">注 册</button>
                </div>
                <div class="layui-trans layui-form-item layadmin-user-login-other">
                    <a href="login.aspx" class="layadmin-user-jump-change layadmin-link layui-hide-xs">用已有帐号登入</a>
                </div>
            </div>
        </div>

        <div class="layui-trans layadmin-user-login-footer">
            <p>© 2018 <a href="http://www.kjjl100.com/" target="_blank">天华教育</a></p>
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
            form.render();

            $(document).keydown(function (event) {
                if (event.keyCode == 13) {
                    $("#btnRegiste").click();
                }
            });

            $.ajax({
                url: '/Page/DeptManage/DeptHandler.ashx?operation=GetList&r=' + Math.random(),
                async: false,
                dataType: 'json',
                type: 'Post',
                data: {},
                success: function (result) {
                    var data = result.data;

                    str = '<option value="">请选择部门</option>';
                    $.each(data, function (index, item) {
                        str += '<option value="' + item.Id + '">' + item.Name + '</option>';
                    });
                    $('#selDeptId').html(str);
                    form.render('select');
                }
            });

            $.ajax({
                url: '/Page/RoleManage/RoleHandler.ashx?operation=GetList&type=Register&r=' + Math.random(),
                async: false,
                dataType: 'json',
                type: 'Post',
                data: {},
                success: function (result) {
                    var data = result.data;
                    str = '<option value="">请选择</option>';
                    $.each(data, function (index, item) {
                        str += '<option value="' + item.Id + '">' + item.Name + '</option>';
                    });
                    $('#selRoleId').html(str);
                    form.render('select');
                }
            });


            //提交
            form.on('submit(LAY-user-reg-submit)', function (obj) {
                var field = obj.field;
                if (field.IsManager == "on") {
                    field.IsManager = true;
                } else {
                    field.IsManager = false;
                }
                //确认密码
                if (field.Password !== field.repass) {
                    return layer.msg('两次密码输入不一致');
                }
                $.post('LoginHandler.ashx?action=Registe', {
                    userName: field.UserName,
                    password: field.Password,
                    realName: field.RealName,
                    roleId: field.RoleId,
                    isManager: field.IsManager
                }, function (data) {
                    if (data.success == 0) {
                        layer.msg(data.msg, {
                            offset: '15px'
                        , icon: 1
                        , time: 1000
                        }, function () {
                            window.location.href = 'Login.aspx'; //跳转到登入页
                        });

                    } else {
                        layer.msg(data.msg);
                    }
                });

                return false;
            });
        });
    </script>
</body>
</html>
