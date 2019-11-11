<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Add.aspx.cs" Inherits="BMS.Page.PersonalCustomer.Add" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>新增客户</title>
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
                <input type="text" name="Name" id="txtName" lay-verify="required" placeholder="名称" autocomplete="off" class="layui-input">
            </div>
            <label class="layui-form-label">电话</label>
            <div class="layui-input-inline">
                <input type="text" name="MobilePhone" id="txtMobilePhone" placeholder="电话" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">微信</label>
            <div class="layui-input-inline">
                <input type="text" name="WeiXin" id="txtWeiXin" placeholder="微信" autocomplete="off" class="layui-input">
            </div>
            <label class="layui-form-label">QQ</label>
            <div class="layui-input-inline">
                <input type="text" name="QQ" id="txtQQ" placeholder="QQ" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">所在省</label>
            <div class="layui-input-inline" lay-filter="divProvince">
                <select name="Province" id="selProvince" lay-filter="selProvince">
                    <option value="0">请选择</option>
                </select>
            </div>
            <label class="layui-form-label">所在市</label>
            <div class="layui-input-inline" lay-filter="divCity">
                <select name="City" id="selCity" lay-filter="selCity">
                    <option value="0">请选择</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">项目</label>
            <div class="layui-input-inline" id="divItem" style="width: 500px;" lay-filter="lay-divItem">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">状态</label>
            <div class="layui-input-inline" style="width: 500px;">
                <input type="radio" name="Status" value="1" title="新增" lay-skin="primary" checked>
                <input type="radio" name="Status" value="2" title="跟进" lay-skin="primary">
                <input type="radio" name="Status" value="3" title="成交" lay-skin="primary">
                <input type="radio" name="Status" value="4" title="放弃" lay-skin="primary">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">意向</label>
            <div class="layui-input-inline" id="divIntention" style="width: 500px;" lay-filter="lay-divIntention">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">来源</label>
            <div class="layui-input-inline" id="divFrom" style="width: 500px;" lay-filter="lay-divFrom">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">关键词</label>
            <div class="layui-input-inline" style="width: 500px;">
                <input type="text" name="KeyWords" id="txtKeyWords" placeholder="关键词" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">创建时间</label>
            <div class="layui-input-inline">
                <input type="text" name="CreateTime" id="txtCreateTime" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
            <label class="layui-form-label">授课类型</label>
            <div class="layui-input-inline">
                <select name="ClassType" id="selClassType">
                    <option value="1">网授</option>
                    <option value="2">面授</option>
                    <option value="3">网授+面授</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">备注</label>
            <div class="layui-input-inline">
                <input id="txtRemark" type="text" style="width: 500px;" name="Remark" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item layui-hide">
            <input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="确认添加">
        </div>
    </div>

    <script src="/Scripts/layui/layui.js"></script>
    <script>
        function isPhoneNo(phone) {
            var pattern = /^1[3456789]\d{9}$/;
            return pattern.test(phone);
        }
        layui.config({
            base: '/Scripts/js/' //静态资源所在路径
        }).extend({
            index: 'lib/index' //主入口模块
        }).use(['index', 'form', 'laydate'], function () {
            var $ = layui.$, form = layui.form, laydate = layui.laydate;
            laydate.render({
                elem: '#txtCreateTime',
                value: new Date()
            });
            $.ajax({
                url: '/Page/Dictionary/DicHandler.ashx?operation=GetList',
                async: false,
                type: 'post',
                dataType: 'json',
                data: { code: 'Item' },
                success: function (result) {
                    var data = result.data;
                    var str = '';
                    $.each(data, function (index, item) {
                        str += '<input type="checkbox" name="Item" value="' + item.Value + '" title="' + item.Name + '" lay-skin="primary">';
                    });
                    $('#divItem').empty();
                    $('#divItem').html(str);
                    form.render('checkbox');
                }
            });
            $.ajax({
                url: '/Page/Dictionary/DicHandler.ashx?operation=GetList',
                type: 'post',
                async: false,
                dataType: 'json',
                data: { code: 'Intention' },
                success: function (result) {
                    var data = result.data;
                    var str = '';
                    $.each(data, function (index, item) {
                        if (index == 0) {
                            str += '<input type="radio" name="Intention" value="' + item.Value + '" title="' + item.Name + '" lay-skin="primary" checked>';
                        } else {
                            str += '<input type="radio" name="Intention" value="' + item.Value + '" title="' + item.Name + '" lay-skin="primary">';
                        }
                    });
                    $('#divIntention').empty();
                    $('#divIntention').html(str);
                    form.render('radio');
                }
            });
            $.ajax({
                url: '/Page/Dictionary/DicHandler.ashx?operation=GetList',
                type: 'post',
                async: false,
                dataType: 'json',
                data: { code: 'From' },
                success: function (result) {
                    var data = result.data;
                    var str = '';
                    $.each(data, function (index, item) {
                        str += '<input type="radio" name="From" value="' + item.Value + '" title="' + item.Name + '" lay-skin="primary">';
                    });
                    $('#divFrom').empty();
                    $('#divFrom').html(str);
                    form.render('radio');
                }
            });
            var id = '<%=Request["id"]%>';
            var model = '';
            if (id != '') {
                $('#hidId').val(id);
                $.ajax({
                    url: '/Page/PersonalCustomer/CustomerHandler.ashx?operation=GetModel',
                    async: false,
                    dataType: 'json',
                    type: 'Post',
                    data: { id: id },
                    success: function (data) {
                        model = data;
                        model.CreateTime = model.CreateTime.split('T')[0];
                        form.val("form1", data);
                        laydate.render({
                            elem: '#txtCreateTime',
                            value: model.CreateTime
                        });
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
                            }
                        });
                        $("input:radio[name='Intention']").each(function (index, item) {
                            if (model.Intention == $(this).val()) {
                                $(this).prop('checked', true);
                            }
                        });
                        $("input:radio[name='From']").each(function (index, item) {
                            if (model.From == $(this).val()) {
                                $(this).prop('checked', true);
                            }
                        });
                        form.render();
                    }
                });
            }

            $.ajax({
                url: '/Page/Region/RegionHandler.ashx?operation=GetRegion',
                dataType: 'json',
                type: 'Post',
                data: { parentId: 0 },
                success: function (data) {
                    var strProvince = '<option value="0">请选择</option>';
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
                                var str = '<option value="0">请选择</option>';
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

            //监听提交
            form.on('submit(layuiadmin-app-form-submit)', function (data) {
                var field = data.field; //获取提交的字段
                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引  
                if (field.MobilePhone != '' && !isPhoneNo(field.MobilePhone)) {
                    return layer.msg('手机号码格式不正确');
                }
                if (field.MobilePhone == '' && field.WeiXin == '' && field.QQ == '') {
                    return layer.msg('手机号码、微信、QQ有一项必填');
                }
                var arr = new Array();
                $("input:checkbox[name='Item']:checked").each(function (i) {
                    arr[i] = $(this).val();
                });
                field.Item = arr.join(",");

                //提交 Ajax 成功后，关闭当前弹层并重载表格
                $.ajax({
                    url: '/Page/PersonalCustomer/CustomerHandler.ashx?operation=Add',
                    dataType: 'json',
                    type: 'Post',
                    data: { model: JSON.stringify(field) },
                    success: function (data) {
                        if (data.success == 0) {
                            parent.layui.table.reload('LAY-app-content-list'); //重载表格
                            parent.layer.close(index); //再执行关闭 
                            parent.window.clearForm();
                        } else {
                            layer.alert(data.msg);
                        }
                    }
                });

            });
            /* 监听下拉框联动 */
            form.on('select(selProvince)', function (data) {
                $.ajax({
                    url: '/Page/Region/RegionHandler.ashx?operation=GetRegion',
                    dataType: 'json',
                    type: 'Post',
                    data: { parentId: data.value },
                    success: function (data) {
                        var str = '<option value="0">请选择</option>';
                        for (var item in data) {
                            str += '<option value="' + data[item].Id + '">' + data[item].Name + '</option>';
                        }
                        $('#selCity').html(str);
                        form.render('select');
                    }
                });
            });
        })
    </script>
</body>
</html>
