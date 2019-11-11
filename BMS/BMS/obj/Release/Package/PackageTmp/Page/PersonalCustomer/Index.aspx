<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="BMS.Page.PersonalCustomer.Index" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>我的客户</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/Scripts/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="/Scripts/css/admin.css" media="all">
    <style>
        .layui-select-disabled .layui-disabled {
            color: #000!important;
        }

        .layui-radio-disbaled > i {
            color: #5fb878!important;
        }
    </style>
</head>
<body>
    <div class="layui-fluid">
        <div class="layui-card">
            <div class="layui-form layui-card-header layuiadmin-card-header-auto">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">部门</label>
                        <div class="layui-input-inline">
                            <select name="selDeptId" id="selDeptId" lay-filter="selDeptId"></select>
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">员工</label>
                        <div class="layui-input-inline">
                            <select name="selUserId" id="selUserId"></select>
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">名称</label>
                        <div class="layui-input-inline">
                            <input type="text" name="txtName" placeholder="客户名称或电话" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-contlist-search">
                            <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                        </button>
                        <%if (RoleId == 1)
                          { %>
                        <button class="layui-btn layuiadmin-btn-list" data-type="batchdel">删除</button>
                        <%} %>
                        <button class="layui-btn layuiadmin-btn-list" data-type="add">添加</button>
                        <button class="layui-btn layuiadmin-btn-list" data-type="importData">导入</button>
                    </div>
                </div>
            </div>

            <div class="layui-card-body">
                <table id="LAY-app-content-list" lay-filter="LAY-app-content-list"></table>
                <script type="text/html" id="table-content-list">
                    <%if (RoleId == 1)
                      { %>
                    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>
                    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>
                    <%} %>
                    <%else
                      { %>
                    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="none">无操作</a>
                    <%} %>
                </script>
            </div>
            <div class="layui-tab">
                <ul class="layui-tab-title">
                    <li class="layui-this">客户详情</li>
                    <li>跟进记录</li>
                    <li>新增跟进记录</li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <div class="layui-card-body" id="divDetail" style="border-top: 1px solid #6ba5e2;">
                            <div class="layui-form" lay-filter="form1" id="form1" style="padding: 20px 30px 0 0;">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">名称：</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="Name" disabled="disabled" id="txtName" class="layui-input">
                                    </div>
                                    <label class="layui-form-label">电话：</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="MobilePhone" disabled="disabled" id="txtMobilePhone" class="layui-input">
                                    </div>
                                    <label class="layui-form-label">微信：</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="WeiXin" id="txtWeiXin" disabled="disabled" class="layui-input">
                                    </div>
                                    <label class="layui-form-label">QQ：</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="QQ" id="txtQQ" disabled="disabled" class="layui-input">
                                    </div>
                                    <label class="layui-form-label">授课类型：</label>
                                    <div class="layui-input-inline">
                                        <select name="ClassType" id="selClassType" disabled="disabled">
                                            <option value="1">网授</option>
                                            <option value="2">面授</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="layui-form-item">
                                    <label class="layui-form-label">所在省：</label>
                                    <div class="layui-input-inline" lay-filter="divProvince">
                                        <select name="Province" id="selProvince" disabled="disabled">
                                            <option value="">请选择</option>
                                        </select>
                                    </div>
                                    <label class="layui-form-label">所在市：</label>
                                    <div class="layui-input-inline" lay-filter="divCity">
                                        <select name="City" id="selCity" disabled="disabled">
                                            <option value="">请选择</option>
                                        </select>
                                    </div>
                                    <label class="layui-form-label">关键词：</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="KeyWords" id="txtKeyWords" disabled="disabled" class="layui-input">
                                    </div>
                                    <label class="layui-form-label">创建时间：</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="CreateTime" id="txtCreateTime" disabled="disabled" class="layui-input">
                                    </div>

                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">项目：</label>
                                    <div class="layui-input-inline" id="divItem" style="width: 500px;">
                                    </div>
                                    <label class="layui-form-label">状态</label>
                                    <div class="layui-input-inline" style="width: 500px;">
                                        <input type="radio" name="Status" value="1" title="新增" lay-filter="lay-Status" lay-skin="primary" <%=RoleId==3?"disabled":"" %>>
                                        <input type="radio" name="Status" value="2" title="跟进" lay-filter="lay-Status" lay-skin="primary" <%=RoleId==3?"disabled":"" %>>
                                        <input type="radio" name="Status" value="3" title="成交" lay-filter="lay-Status" lay-skin="primary" <%=RoleId==3?"disabled":"" %>>
                                        <input type="radio" name="Status" value="4" title="放弃" lay-filter="lay-Status" lay-skin="primary" <%=RoleId==3?"disabled":"" %>>
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">意向：</label>
                                    <div class="layui-input-inline" id="divIntention" style="width: 500px;">
                                    </div>
                                    <label class="layui-form-label">来源：</label>
                                    <div class="layui-input-inline" id="divFrom" style="width: 500px;">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">备注：</label>
                                    <div class="layui-input-inline">
                                        <input id="txtRemark" type="text" style="width: 500px;" name="Remark" disabled="disabled" class="layui-input">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-tab-item">
                        <div class="layui-card-body">
                            <table id="tbFollowUp" lay-filter="tbFollowUp"></table>
                        </div>
                    </div>
                    <div class="layui-tab-item">
                        <div class="layui-card-body" id="divFollowUp" style="border-top: 1px solid #6ba5e2;">
                            <div class="layui-form" lay-filter="frmFollowUp" id="frmFollowUp" style="padding: 20px 30px 0 0;">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">跟踪记录：</label>
                                    <div class="layui-input-inline">
                                        <textarea id="txtFollowUpRemark" style="width: 500px; height: 100px; resize: none;"></textarea>
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <div class="layui-form-inline">
                                        <button class="layui-btn layuiadmin-btn-list" style="position: relative; left: 492px;" data-type="addFollowUp">
                                            添加跟进记录</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script src="/Scripts/layui/layui.js"></script>
    <script>
        var clearForm = "";
        var curMsgId = '';
        layui.config({
            base: '/Scripts/js/' //静态资源所在路径
        }).extend({
            index: 'lib/index' //主入口模块
        }).use(['index', 'form', 'table', 'element'], function () {
            var table = layui.table,
                form = layui.form,
                $ = layui.$, element = layui.element;
            clearForm = function () {
                $('#txtName').val('');
                $('#txtMobilePhone').val('');
                $('#txtWeiXin').val('');
                $('#txtQQ').val('');
                $('#selClassType').val(1);
                $('#txtKeyWords').val('');
                $('#txtCreateTime').val('');
                $('#txtRemark').val('');
                var model = new Object();
                model.Item = "";
                model.Status = "";
                model.Intention = "";
                model.From = "";
                initVal(model);
            }
            function initVal(model) {
                $("input:checkbox[name='Item']").each(function (index, item) {
                    if (("," + model.Item + ",").indexOf($(this).val()) > -1) {
                        $(this).prop('checked', true);
                    } else {
                        $(this).prop('checked', false);
                    }
                });
                $("input:radio[name='Status']").each(function (index, item) {
                    if (model.Status == $(this).val()) {
                        $(this).prop('checked', true);
                    } else {
                        $(this).prop('checked', false);
                    }
                });
                $("input:radio[name='Intention']").each(function (index, item) {
                    if (model.Intention == $(this).val()) {
                        $(this).prop('checked', true);
                    } else {
                        $(this).prop('checked', false);
                    }
                });
                $("input:radio[name='From']").each(function (index, item) {
                    if (model.From == $(this).val()) {
                        $(this).prop('checked', true);
                    } else {
                        $(this).prop('checked', false);
                    }
                });
                $.ajax({
                    url: '/Page/Region/RegionHandler.ashx?operation=GetRegion',
                    dataType: 'json',
                    type: 'Post',
                    data: { parentId: 0 },
                    success: function (data) {
                        var strProvince = '<option value="">请选择</option>';
                        for (var i = 0; i < data.length; i++) {
                            strProvince += '<option value="' + data[i].Id + '">' + data[i].Name + '</option>';
                        }
                        $('#selProvince').html(strProvince);
                        if (model && model.Province != '') {
                            $('#selProvince').val(model.Province);
                            $.ajax({
                                url: '/Page/Region/RegionHandler.ashx?operation=GetRegion',
                                async: false,
                                dataType: 'json',
                                type: 'Post',
                                "data": { parentId: model.Province },
                                success: function (data) {
                                    var str = '<option value="">请选择</option>';
                                    for (var item in data) {
                                        str += '<option value="' + data[item].Id + '">' + data[item].Name + '</option>';
                                    }
                                    $('#selCity').html(str);
                                    if (model.City && model.City != '') {
                                        $('#selCity').val(model.City);
                                    }
                                }
                            });
                        }
                        form.render('select');
                    }
                });
                form.on('radio(lay-Status)', function (data) {
                    if (curMsgId == '') {
                        return false;
                    }
                    $.ajax({
                        url: '/Page/PersonalCustomer/CustomerHandler.ashx?operation=ChangeValue',
                        dataType: 'json',
                        type: 'post',
                        data: { id: curMsgId, field: 'Status', value: data.value },
                        success: function (result) {
                            table.reload('LAY-app-content-list');
                        }
                    });
                    console.log(data.value); //被点击的radio的value值
                });
                form.render(null, 'form1'); //更新 lay-filter="test1" 所在容器内的全部表单状态
            }
            $.ajax({
                url: '/Page/DeptManage/DeptHandler.ashx?operation=GetList&fromPage=personalCustomer&r=' + Math.random(),
                dataType: 'json',
                type: 'post',
                success: function (result) {
                    var data = result.data;

                    str = '<option value="">全部</option>';
                    $.each(data, function (index, item) {
                        str += '<option value="' + item.Id + '">' + item.Name + '</option>';
                    });
                    $('#selDeptId').html(str);
                    form.render('select');
                }
            });

            $.ajax({
                url: '/Page/UserManage/UserManageHandler.ashx?operation=GetListForMsgUsers&r=' + Math.random(),
                dataType: 'json',
                type: 'post',
                success: function (result) {
                    var data = result.data;
                    str = '<option value="">全部</option>';
                    $.each(data, function (index, item) {
                        str += '<option value="' + item.Id + '">' + item.RealName + '</option>';
                    });
                    $('#selUserId').html(str);
                    form.render('select');
                }
            });

            /* 监听下拉框联动 */
            form.on('select(selDeptId)', function (data) {
                $.ajax({
                    url: '/Page/UserManage/UserManageHandler.ashx?operation=GetListForMsgUsers&r=' + Math.random(),
                    dataType: 'json',
                    type: 'Post',
                    data: { deptId: $('#selDeptId').val() },
                    success: function (result) {
                        var data = result.data;
                        str = '<option value="">全部</option>';
                        $.each(data, function (index, item) {
                            str += '<option value="' + item.Id + '">' + item.RealName + '</option>';
                        });
                        $('#selUserId').html(str);
                        form.render('select');
                    }
                });
            });

            $.ajax({
                url: '/Page/Dictionary/DicHandler.ashx?operation=GetList',
                type: 'post',
                dataType: 'json',
                data: { code: 'Item' },
                success: function (result) {
                    var data = result.data;
                    var str = '';
                    $.each(data, function (index, item) {
                        str += '<input type="checkbox" name="Item" value="' + item.Value + '" title="' + item.Name + '" lay-skin="primary" disabled="disabled" >';
                    });
                    $('#divItem').empty();
                    $('#divItem').html(str);
                    form.render('checkbox');
                }
            });
            $.ajax({
                url: '/Page/Dictionary/DicHandler.ashx?operation=GetList',
                type: 'post',
                dataType: 'json',
                data: { code: 'Intention' },
                success: function (result) {
                    var data = result.data;
                    var str = '';
                    $.each(data, function (index, item) {
                        str += '<input type="radio" name="Intention" value="' + item.Value + '" title="' + item.Name + '" lay-skin="primary" disabled="disabled" >';
                    });
                    $('#divIntention').empty();
                    $('#divIntention').html(str);
                    form.render('radio');
                }
            });
            $.ajax({
                url: '/Page/Dictionary/DicHandler.ashx?operation=GetList',
                type: 'post',
                dataType: 'json',
                data: { code: 'From' },
                success: function (result) {
                    var data = result.data;
                    var str = '';
                    $.each(data, function (index, item) {
                        str += '<input type="radio" name="From" value="' + item.Value + '" title="' + item.Name + '" lay-skin="primary" disabled="disabled" >';
                    });
                    $('#divFrom').empty();
                    $('#divFrom').html(str);
                    form.render('radio');
                }
            });
            table.render({
                elem: "#LAY-app-content-list",
                url: '/Page/PersonalCustomer/CustomerHandler.ashx?operation=GetListForPrivate&r=' + Math.random(),
                cols: [
                    [
                        { type: "checkbox", fixed: "left" },
                        { field: "Name", width: 200, title: "名称", edit: 'text' },
                        { field: "MobilePhone", width: 120, title: "电话", align: 'center' },
                        { field: "ItemExt", title: "项目", width: 200, align: 'center' },
                        { field: "IntentionExt", title: "意向", width: 120, align: 'center' },
                        { field: "FromExt", title: "来源", align: 'center', width: 120 },
                        {
                            field: 'Status', title: '状态', width: 120, align: 'center', templet: function (d) {
                                // 跟进状态:1、新增；2、跟进；3、成交；4、放弃；
                                switch (d.Status) {
                                    case 1:
                                        return "新增";
                                    case 2:
                                        return "跟进";
                                    case 3:
                                        return "成交";
                                    case 4:
                                        return "放弃";
                                    default:
                                        return "";
                                }
                            }
                        },
                        { field: "CreateUserName", title: "录入人", align: 'center' },
                        { field: "CreateTime", title: "录入时间", align: 'center' },
                        { field: "FollowUpTime", title: "跟进时间", align: 'center' },
                        { field: "Remark", title: "备注", minWidth: 80, align: "center", edit: 'text' },
                        { title: "操作", minWidth: 150, align: "center", fixed: "right", toolbar: "#table-content-list" }
                    ]
                ],
                toolbar: true,
                defaultToolbar: ['filter'],
                height: 490,
                page: !0,
                limit: 10,
                limits: [10, 20, 30]

            });
            table.on("tool(LAY-app-content-list)", function (t) {
                var row = t.data;
                "del" === t.event ? layer.confirm("确定删除吗？", {
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
                        url: '/Page/PersonalCustomer/CustomerHandler.ashx?operation=Delete',
                        dataType: 'json',
                        type: 'Post',
                        data: { id: row.Id, name: row.Name },
                        success: function (data) {
                            if (data.success == "0") {
                                layer.close(e);
                                layui.table.reload('LAY-app-content-list');
                            } else {
                                layer.alert(data.msg);
                            }
                        }
                    });
                }) : "edit" === t.event && layer.open({
                    type: 2,
                    title: "编辑客户",
                    content: "/Page/PersonalCustomer/Add.aspx?id=" + row.Id,
                    maxmin: true,
                    area: ["700px", "650px"],
                    btn: ["确定", "取消"],
                    yes: function (index, layero) {
                        var submit = layero.find('iframe').contents().find("#layuiadmin-app-form-submit");
                        submit.click();
                    }
                });
            });
            //监听单元格编辑
            table.on('edit(LAY-app-content-list)', function (obj) {
                var value = obj.value //得到修改后的值
                , data = obj.data //得到所在行所有键值
                , field = obj.field; //得到字段
                $.ajax({
                    url: '/Page/PersonalCustomer/CustomerHandler.ashx?operation=ChangeValue',
                    dataType: 'json',
                    type: 'post',
                    data: { id: data.Id, field: field, value: value },
                    success: function (result) {
                        layer.msg('修改成功');
                    }
                });

            });
            table.on("row(LAY-app-content-list)", function (obj) {
                //标注选中样式
                obj.tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
                var model = obj.data;
                form.val("form1", model);
                initVal(model);
                loadFollowUp(model.Id);
                curMsgId = model.Id;
            });
            //监听搜索
            form.on('submit(LAY-app-contlist-search)', function (data) {
                var field = data.field;
                //执行重载
                table.reload('LAY-app-content-list', {
                    where: field
                });
                clearForm();
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
                            url: "/Page/PersonalCustomer/CustomerHandler.ashx?operation=BatchDelete",
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
                      , title: '新建客户'
                      , content: '/Page/PersonalCustomer/Add.aspx'
                      , maxmin: true
                      , area: ['700px', '650px']
                      , btn: ['确定', '取消']
                      , yes: function (index, layero) {
                          var submit = layero.find('iframe').contents().find("#layuiadmin-app-form-submit");
                          submit.click();
                      }
                    });
                },
                importData: function () {
                    layer.open({
                        type: 2
                        , title: '导入'
                        , content: '/Page/PersonalCustomer/ImportCustomer.aspx'
                        , maxmin: false
                        , area: ['400px', '300px']
                        , btn: ['关闭']
                    });
                },
                addFollowUp: function () {
                    if (curMsgId == '') {
                        layer.alert("请先选择客户");
                        return false;
                    }
                    $.ajax({
                        url: '/Page/FollowUp/FollowUpHandler.ashx?operation=Add',
                        dataType: 'json',
                        type: 'post',
                        data: { remark: $('#txtFollowUpRemark').val(), msgId: curMsgId },
                        success: function (result) {
                            if (result.success == 0) {
                                loadFollowUp(curMsgId);
                                $('#txtFollowUpRemark').val('');
                            } else {
                                layer.alert(result.msg);
                            }
                        }
                    });
                }
            };

            $('.layui-btn.layuiadmin-btn-list').on('click', function () {
                var type = $(this).data('type');
                active[type] ? active[type].call(this) : '';
            });

            function loadFollowUp(msgId) {
                table.render({
                    elem: "#tbFollowUp",
                    url: '/Page/FollowUp/FollowUpHandler.ashx?operation=GetList' + "&r=" + Math.random() + "&msgId=" + msgId,
                    cols: [
                        [
                            { type: "numbers", fixed: "center" },
                            { field: "CreateUserName", width: 120, title: "跟进人", align: 'center' },
                            { field: "CreateTime", title: "跟进时间", width: 200, align: 'center' },
                            { field: "Remark", title: "跟进内容", width: 500, }
                        ]
                    ],
                    height: 490,
                    page: !0,
                    limit: 10,
                    limits: [10, 20, 30]
                });
            }
        });
    </script>
</body>
</html>

