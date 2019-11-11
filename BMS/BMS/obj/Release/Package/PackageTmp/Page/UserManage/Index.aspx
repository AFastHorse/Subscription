<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="BMS.Page.UserManage.Index" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/Scripts/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="/Scripts/css/admin.css" media="all">
</head>
<body>
    <div class="layui-fluid">
        <div class="layui-card">
            <div class="layui-form layui-card-header layuiadmin-card-header-auto">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">名称</label>
                        <div class="layui-input-inline">
                            <input type="text" name="txtName" placeholder="名称" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-contlist-search">
                            <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                        </button>
                        <button class="layui-btn layuiadmin-btn-list" data-type="add">添加</button>
                        <button class="layui-btn layuiadmin-btn-list" data-type="batchdel">批量删除</button>
                    </div>
                </div>
            </div>

            <div class="layui-card-body">
                <table id="LAY-app-content-list" lay-filter="LAY-app-content-list"></table>
                <script type="text/html" id="table-content-list">
                    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="resetPwd"><i class="layui-icon layui-icon-edit"></i>密码重置</a>
                    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>
                    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>
                </script>
            </div>
        </div>
    </div>

    <script src="/Scripts/layui/layui.js"></script>
    <script>
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
                url: '/Page/UserManage/UserManageHandler.ashx?operation=GetList&r=' + Math.random(),
                cols: [
                    [
                        { type: "checkbox", fixed: "left" },
                        { field: "UserName", width: 150, title: "账号", align: 'center' },
                        { field: "RealName", title: "实际名称", width: 150, align: 'center' },
                        { field: "DeptName", title: "部门名称", minWidth: 80, align: "center" },
                        {
                            field: "IsManager", title: "是否部门主管", minWidth: 100, align: "center", templet: function (d) {                                
                                if (d.IsManager) {
                                    return "是";
                                }
                                return "否";
                            }
                        },
                        { field: "RoleName", title: "角色名称", minWidth: 80, align: "center" },
                        { field: "CreateTime", title: "创建时间", width: 120, align: 'center' },
                        { field: "Remark", title: "备注", minWidth: 80, align: "center" },
                        { title: "操作", minWidth: 150, align: "center", fixed: "right", toolbar: "#table-content-list" }
                    ]
                ],
                page: !0,
                limit: 10,
                limits: [10, 20, 30]

            });
            table.on("tool(LAY-app-content-list)", function (t) {
                var row = t.data;
                switch (t.event) {
                    case "del":
                        layer.confirm("确定删除吗？", {
                            btn: ['确认', '取消'],
                            success: function () {
                                this.enterEsc = function (event) {
                                    if (event.keyCode === 13) {
                                        $(".layui-layer-btn0").click();
                                        return false; //阻止系统默认回车事件
                                    } else if (event.keyCode == 27) {
                                        $(".layui-layer-btn1").click();
                                        return false;
                                    }
                                };
                                $(document).on('keydown', this.enterEsc); //监听键盘事件，关闭层
                            },
                            end: function () {
                                $(document).off('keydown', this.enterEsc); //解除键盘关闭事件
                            }
                        }, function (e) {
                            $.ajax({
                                url: '/Page/UserManage/UserManageHandler.ashx?operation=Delete',
                                dataType: 'json',
                                type: 'Post',
                                data: { id: row.Id, name: row.UserName, realName: row.RealName },
                                success: function (data) {
                                    if (data.success == "0") {
                                        layer.close(e);
                                        layui.table.reload('LAY-app-content-list');
                                    } else {
                                        layer.alert(data.msg);
                                    }
                                }
                            });
                        });
                        break;
                    case "edit":
                        layer.open({
                            type: 2,
                            title: "编辑用户",
                            content: "/Page/UserManage/Add.aspx?id=" + row.Id,
                            maxmin: true,
                            area: ["700px", "550px"],
                            btn: ["确定", "取消"],
                            yes: function (index, layero) {
                                var submit = layero.find('iframe').contents().find("#layuiadmin-app-form-submit");
                                submit.click();
                            }
                        });
                        break;
                    case "resetPwd":
                        layer.confirm("确定要重置吗？", {
                            btn: ['确认', '取消'],
                            success: function () {
                                this.enterEsc = function (event) {
                                    if (event.keyCode === 13) {
                                        $(".layui-layer-btn0").click();
                                        return false; //阻止系统默认回车事件
                                    } else if (event.keyCode == 27) {
                                        $(".layui-layer-btn1").click();
                                        return false;
                                    }
                                };
                                $(document).on('keydown', this.enterEsc); //监听键盘事件，关闭层
                            },
                            end: function () {
                                $(document).off('keydown', this.enterEsc); //解除键盘关闭事件
                            }
                        }, function (e) {
                            $.ajax({
                                url: '/Page/UserManage/UserManageHandler.ashx?operation=ResetPwd',
                                dataType: 'json',
                                type: 'Post',
                                data: { id: row.Id },
                                success: function (data) {
                                    if (data.success == "0") {
                                        layer.close(e);
                                        layui.table.reload('LAY-app-content-list');
                                    } else {
                                        layer.alert(data.msg);
                                    }
                                }
                            });
                        });
                        break;
                }
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
                batchdel: function () {
                    var checkStatus = table.checkStatus('LAY-app-content-list')
                    , checkData = checkStatus.data; //得到选中的数据

                    if (checkData.length === 0) {
                        return layer.msg('请选择数据');
                    }
                    var ids = '';
                    var names = '';
                    for (var i = 0; i < checkData.length; i++) {
                        ids += checkData[i].Id + ",";
                        names += checkData[i].UserName + ",";
                    }
                    if (ids.length > 0) {
                        ids = ids.substr(0, ids.length - 1);
                        names = names.substr(0, names.length - 1);
                    }
                    layer.confirm('确定删除吗？', {
                        btn: ['确认', '取消'],
                        success: function () {
                            this.enterEsc = function (event) {
                                if (event.keyCode === 13) {
                                    $(".layui-layer-btn0").click();
                                    return false; //阻止系统默认回车事件
                                } else if (event.keyCode == 27) {
                                    $(".layui-layer-btn1").click();
                                    return false;
                                }
                            };
                            $(document).on('keydown', this.enterEsc); //监听键盘事件，关闭层
                        },
                        end: function () {
                            $(document).off('keydown', this.enterEsc); //解除键盘关闭事件
                        }
                    }, function (index) {
                        $.ajax({
                            url: "/Page/UserManage/UserManageHandler.ashx?operation=BatchDelete",
                            dataType: 'json',
                            type: 'Post',
                            data: { ids: ids, names: names },
                            success: function (data) {
                                if (data.success == "0") {
                                    table.reload('LAY-app-content-list');
                                    layer.msg('已删除');
                                } else {
                                    layer.alert(data.msg);
                                }
                            }
                        });

                    });
                },
                add: function () {
                    layer.open({
                        type: 2
                      , title: '新增用户'
                      , content: '/Page/UserManage/Add.aspx'
                      , maxmin: true
                      , area: ['700px', '550px']
                      , btn: ['确定', '取消']
                      , yes: function (index, layero) {
                          var submit = layero.find('iframe').contents().find("#layuiadmin-app-form-submit");
                          submit.click();
                      }
                    });
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

