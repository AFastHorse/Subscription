<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="BMS.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>登录</title>
    <meta charset="utf-8" />
    <meta name="renderer" content="webkit" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <link rel="stylesheet" href="/Scripts/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="/Scripts/css/admin.css" media="all" />
    <link rel="stylesheet" href="/Scripts/css/login.css" media="all" />

    <script src="/Scripts/jquery-3.3.1.min.js"></script>
    <script src="/Scripts/jquery.cookie-1.4.1.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $(document).keydown(function (event) {
                if (event.keyCode == 13) {
                    $("#btnLogin").click();
                }
            });
            var cookie = $.cookie('bms');
            if (cookie != undefined && cookie != "null") {
                var userName = cookie.split('|')[0];
                var password = cookie.split('|')[1];
                $('#txtName').val(userName);
                $('#txtPwd').val(password);
                $('#ckbRemember').attr('checked', true);
            }
        });
        function submitForm() {
            if ($.trim($('#txtName').val()) == '') {
                layer.alert("请输入用户名！");
                return false;
            }
            var userName = $('#txtName').val();
            var password = $('#txtPwd').val();
            $.ajax({
                url: '/LoginHandler.ashx?action=Login',
                async: false,
                beforeSend: function () {
                    $('#txtPwd').val('');
                },
                complete: function () { },
                data: {
                    userName: userName,
                    password: password
                },
                dataType: 'json',
                error: function (err) {
                    alert(err);
                },
                success: function (data) {
                    if (data.success == 0) {
                        if ($('#ckbRemember').prop('checked')) {
                            $.cookie('bms', userName + "|" + password, { expires: 30 });
                        } else {
                            if ($.cookie('bms') != undefined && $.cookie('bms') != 'null') {
                                $.cookie('bms', null);
                            }
                        }
                        window.location.href = "/Page/Main.aspx";
                    } else {
                        layer.alert(data.result);
                    }
                },
                type: 'post',
                timeout: 60000
            });
        }
        function clearForm() {
            $('#txtName').val('');
            $('#txtPwd').val('');
        }
    </script>
</head>
<body>
    <div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">

        <div class="layadmin-user-login-main">
            <div class="layadmin-user-login-box layadmin-user-login-header">
                <h2>认购平台管理</h2>
            </div>
            <div class="layadmin-user-login-box layadmin-user-login-body layui-form">
                <div class="layui-form-item">
                    <label class="layadmin-user-login-icon layui-icon layui-icon-username" for="txtName"></label>
                    <input type="text" name="txtName" id="txtName" placeholder="账号" class="layui-input" />
                </div>
                <div class="layui-form-item">
                    <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="txtPwd"></label>
                    <input type="password" name="txtPwd" id="txtPwd" placeholder="密码" class="layui-input" />
                </div>
                <div class="layui-form-item" style="margin-bottom: 20px;">
                    <input type="checkbox" name="ckbRemember" id="ckbRemember" title="记住密码" />
                </div>
                <div class="layui-form-item">
                    <button class="layui-btn layui-btn-fluid" lay-filter="layuiadmin-app-form-submit" onclick="submitForm();" id="btnLogin">登 入</button>
                </div>
            </div>
        </div>

        <div class="layui-trans layadmin-user-login-footer">
            <p>© 2018 <a href="#" target="_blank">认购平台管理</a></p>
        </div>
    </div>

    <script src="/Scripts/layui/layui.js?r=3"></script>
    <script>
        layui.config({
            base: '/Scripts/js/' //静态资源所在路径
        }).extend({
            index: 'lib/index' //主入口模块
        }).use(['index', 'form', 'commonFun'], function () {
            var form = layui.form,
                commonFun = layui.commonFun;
            commonFun.init();
            form.render('checkbox');
        });
    </script>
</body>
</html>
