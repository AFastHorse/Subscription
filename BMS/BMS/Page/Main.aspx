<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="BMS.Pages.Main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <title>认购平台管理</title>
    <meta name="renderer" content="webkit" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <link rel="stylesheet" href="/Scripts/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="/Scripts/css/admin.css" media="all" />
    <style>
        .noClick {
            pointer-events: none;
        }
    </style>
    <script src="/Scripts/jquery-3.3.1.min.js"></script>
    <script>
        function signOut() {
            $.ajax({
                url: '/LoginHandler.ashx?action=LogOut',
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    if (data.success == 0) {
                        window.location.href = '/Login.aspx';
                    }
                }
            });
        }
        function updateUserMsg() {
            layer.open({
                type: 2
              , title: '修改资料'
              , content: '/Page/UserManage/UserMessage.aspx'
              , maxmin: false
              , area: ['460px', '280px']
              , btn: ['保存', '取消']
              , yes: function (index, layero) {
                  var submit = layero.find('iframe').contents().find("#layuiadmin-app-form-submit");
                  submit.click();
              }
            });
        }
        function changePassword() {
            layer.open({
                type: 2
              , title: '修改密码'
              , content: '/Page/UserManage/ChangePwd.aspx'
              , maxmin: false
              , area: ['460px', '300px']
              , btn: ['确定', '取消']
              , yes: function (index, layero) {
                  var submit = layero.find('iframe').contents().find("#layuiadmin-app-form-submit");
                  submit.click();
              }
            });
        }
    </script>
</head>
<body class="layui-layout-body">
    <div id="LAY_app">
        <div class="layui-layout layui-layout-admin">
            <div class="layui-header" style="line-height: 40px; height: 40px; width: 220px; right: 0px;">
                <!-- 头部区域 -->
                <ul class="layui-nav layui-layout-left" style="height: 40px; margin-left: 0px; left: 0px;">
                    <li class="layui-nav-item layadmin-flexible" lay-unselect style="height: 40px; line-height: 40px;">
                        <a href="javascript:;" layadmin-event="flexible" title="侧边伸缩">
                            <i class="layui-icon layui-icon-shrink-right" id="LAY_app_flexible"></i>
                        </a>
                    </li>
                    <li class="layui-nav-item" lay-unselect style="height: 40px; line-height: 40px;">
                        <a href="javascript:;" layadmin-event="refresh" title="刷新">
                            <i class="layui-icon layui-icon-refresh-3"></i>
                        </a>
                    </li>
                </ul>
                <ul class="layui-nav layui-layout-right" lay-filter="layadmin-layout-right" style="right: 15px;">
                    <li class="layui-nav-item" lay-unselect style="height: 40px; line-height: 40px;">
                        <a href="javascript:;">
                            <cite><%=UserName %></cite>
                        </a>
                        <dl class="layui-nav-child" <%=(IsLogin?"":"style=\"display:none;\"") %>>
                            <dd><a href="javascript:void(0);" onclick="updateUserMsg();">基本资料</a></dd>
                            <dd><a href="javascript:void(0);" onclick="changePassword();">修改密码</a></dd>
                            <hr>
                            <dd style="text-align: center; cursor: pointer;" onclick="signOut();"><a>退出</a></dd>
                        </dl>
                    </li>
                </ul>
            </div>

            <!-- 侧边菜单 -->
            <div class="layui-side layui-side-menu">
                <div class="layui-side-scroll">
                    <div class="layui-logo" lay-href="/Page/MenuManage/Index.aspx">
                        <span>认购平台管理</span>
                    </div>

                    <ul class="layui-nav layui-nav-tree" lay-shrink="all" id="LAY-system-side-menu" lay-filter="layadmin-system-side-menu">
                    </ul>
                </div>
            </div>

            <!-- 页面标签 -->
            <div class="layadmin-pagetabs" id="LAY_app_tabs" style="top: 0;">
                <div class="layui-icon layadmin-tabs-control layui-icon-prev" layadmin-event="leftPage"></div>
                <div class="layui-icon layadmin-tabs-control layui-icon-next" layadmin-event="rightPage" style="z-index: 100;"></div>
                <div class="layui-icon layadmin-tabs-control layui-icon-down" style="z-index: 100;">
                    <ul class="layui-nav layadmin-tabs-select" lay-filter="layadmin-pagetabs-nav">
                        <li class="layui-nav-item" lay-unselect>
                            <a href="javascript:;"></a>
                            <dl class="layui-nav-child layui-anim-fadein">
                                <dd layadmin-event="closeThisTabs"><a href="javascript:;">关闭当前标签页</a></dd>
                                <dd layadmin-event="closeOtherTabs"><a href="javascript:;">关闭其它标签页</a></dd>
                                <dd layadmin-event="closeAllTabs"><a href="javascript:;">关闭全部标签页</a></dd>
                            </dl>
                        </li>
                    </ul>
                </div>
                <div class="layui-tab" lay-unauto lay-allowclose="true" lay-filter="layadmin-layout-tabs">
                    <ul class="layui-tab-title" id="LAY_app_tabsheader">
                        <li id="liindexPage" lay-id="/Page/UserManage/Index.aspx" lay-attr="/Page/UserManage/Index.aspx" class="layui-this">认购管理</li>
                    </ul>
                </div>
            </div>


            <!-- 主体内容 -->
            <div class="layui-body" id="LAY_app_body" style="top: 40px;">
                <div class="layadmin-tabsbody-item layui-show">
                    <iframe id="ifmMain" src="/Page/UserManage/Index.aspx" frameborder="0" class="layadmin-iframe"></iframe>
                </div>
            </div>

            <!-- 辅助元素，一般用于移动设备下遮罩 -->
            <div class="layadmin-body-shade" layadmin-event="shade"></div>
        </div>
    </div>
    <script id="menuTemplate" type="text/html">
        {{#  layui.each(d, function(index, item){ }}                 
         <li data-name="home" class="layui-nav-item layui-nav-itemed">
             <a lay-href="{{item.Url}}" lay-tips="{{item.Name}}" lay-direction="2">
                 <%--<i class="{{item.CssTheme}}"></i>--%>
                 <cite>{{item.Name}}</cite>
             </a>
         </li>
        {{#  }); }}        
    </script>
    <script src="/Scripts/layui/layui.js"></script>
    <script>
        layui.config({
            base: '/Scripts/js/' //静态资源所在路径
        }).extend({
            index: 'lib/index' //主入口模块
        }).use(['index', 'form'], function () {
            var form = layui.form, $ = layui.$;
            $.ajax({
                url: '/Page/MenuManage/MenuHandler.ashx?operation=GetMenuListForMain',
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    var getTpl = $('#menuTemplate').html();
                    layui.laytpl(getTpl).render(data, function (html) {
                        $('#LAY-system-side-menu').append(html);
                    });
                }
            });
        });
    </script>
</body>
</html>


