<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="BMS.Page.DeptManage.Index" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>部门管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="../../Scripts/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="../../Scripts/css/admin.css" media="all">
    <style>
        .layui-icon-layer:before {
            content: "\e656";
        }

        .layui-icon-file:before {
            content: "\e638";
        }
    </style>
</head>
<body>
    <div class="layui-fluid">
        <div class="layui-card">
            <div class="layui-form layui-card-header layuiadmin-card-header-auto">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <button class="layui-btn layuiadmin-btn-list" data-type="expandAll">全部展开</button>
                        <button class="layui-btn layuiadmin-btn-list" data-type="foldAll">全部折叠</button>
                        <button class="layui-btn layuiadmin-btn-list" data-type="add">新增部门</button>
                    </div>
                </div>
            </div>

            <div class="layui-card-body">
                <table id="LAY-app-content-list" class="layui-table" lay-filter="LAY-app-content-list"></table>
                <script type="text/html" id="table-content-list">
                    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="add"><i class="layui-icon layui-icon-edit"></i>新增下级</a>
                    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>
                    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>
                </script>
            </div>
        </div>
    </div>
    <script src="../../Scripts/jquery-3.3.1.min.js"></script>
    <script src="../../Scripts/layui/layui.js"></script>
    <script>
        var renderTable = '';
        function addChild(id) {
            layer.open({
                type: 2
                , title: '新增部门'
                , content: 'Add.aspx?parentId=' + id
                , maxmin: true
                , area: ['700px', '350px']
                , btn: ['确定', '取消']
                , yes: function (index, layero) {
                    var submit = layero.find('iframe').contents().find("#layuiadmin-app-form-submit");
                    submit.click();
                }
            });
        }
        function edit(id) {
            layer.open({
                type: 2,
                title: "编辑部门",
                content: "Add.aspx?id=" + id,
                maxmin: true,
                area: ["700px", "350px"],
                btn: ["确定", "取消"],
                yes: function (index, layero) {
                    var submit = layero.find('iframe').contents().find("#layuiadmin-app-form-submit");
                    submit.click();
                }
            });
        }
        function deleteDept(id, name) {
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
                    url: 'DeptHandler.ashx?operation=Delete',
                    dataType: 'json',
                    type: 'Post',
                    data: { id: id, name: name },
                    success: function (data) {
                        if (data.success == "0") {
                            layer.close(e);
                            renderTable();
                        } else {
                            layer.alert(data.msg);
                        }
                    }
                });
            });
        }
        layui.config({
            base: '../../Scripts/js/' //静态资源所在路径
        }).extend({
            index: 'lib/index' //主入口模块
        }).use(['index', 'form', 'table', 'treetable'], function () {
            var table = layui.table,
                form = layui.form,
                $ = layui.$,
                treetable = layui.treetable;

            renderTable = function () {
                // 渲染表格               
                treetable.render({
                    treeColIndex: 2,
                    treeSpid: -1,
                    treeIdName: 'Id',
                    treePidName: 'ParentId',
                    treeDefaultClose: false,
                    elem: '#LAY-app-content-list',
                    url: 'DeptHandler.ashx?operation=GetList&r=' + Math.random(),
                    cols: [
                          [
                              { type: 'checkbox', width: 80 },
                              { type: 'numbers', title: '序号', width: 100 },
                              { field: "DepartName", width: 200, title: "名称", align: 'center' },
                              { field: "OrderNum", width: 80, title: "排序号", align: "center" },
                              { field: "Remark", width: 200, title: "备注", align: 'left' },
                              {
                                  title: "操作", minWidth: 150, align: "center", fixed: "right", templet: function (d) {
                                      var addStr = '<a class="layui-btn layui-btn-normal layui-btn-xs" onclick="addChild(\'' + d.Id
                                          + '\');"><i class="layui-icon layui-icon-edit"></i>新增下级</a>';
                                      var editStr = '<a class="layui-btn layui-btn-normal layui-btn-xs" onclick="edit(\'' + d.Id
                                          + '\');"><i class="layui-icon layui-icon-edit"></i>编辑</a>';
                                      var delStr = '<a class="layui-btn layui-btn-danger layui-btn-xs" onclick="deleteDept(\'' + d.Id
                                          + '\',\'' + d.DepartName + '\');"><i class="layui-icon layui-icon-delete"></i>删除</a>';
                                      if (d.Id == 0) {
                                          return addStr;
                                      } else {
                                          return addStr + editStr + delStr;
                                      }
                                  }
                              }
                          ]
                    ]
                });
            };

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
                        names += checkData[i].Name + ",";
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
                            url: "/Page/DeptManage/DeptHandler.ashx?operation=BatchDelete",
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
                      , title: '新增部门'
                      , content: '/Page/DeptManage/Add.aspx'
                      , maxmin: true
                      , area: ['700px', '350px']
                      , btn: ['确定', '取消']
                      , yes: function (index, layero) {
                          var submit = layero.find('iframe').contents().find("#layuiadmin-app-form-submit");
                          submit.click();
                      }
                    });
                },
                expandAll: function () {
                    treetable.expandAll('#LAY-app-content-list');
                },
                foldAll: function () {
                    treetable.foldAll('#LAY-app-content-list');
                }
            };

            $('.layui-btn.layuiadmin-btn-list').on('click', function () {
                var type = $(this).data('type');
                active[type] ? active[type].call(this) : '';
            });

            renderTable();
        });
    </script>
</body>
</html>

