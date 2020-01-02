<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" pageEncoding="UTF-8" language="java" %>
<c:set var="app" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>Title</title>
    <!--引入jqgrid中核心css-->
    <!--引入jqgrid中国际化语言文件-->
    <!--引入jqgrid中核心js文件-->
    <link rel="stylesheet" href="${app}/css/bootstrap.css">
    <%--引入jqgrid中主题css--%>
    <link rel="stylesheet" href="${app}/jqgrid/css/css/cupertino/jquery-ui-1.8.16.custom.css">
    <link rel="stylesheet" href="${app}/jqgrid/css/ui.jqgrid.css">

    <style>
        #tou{
            margin-top: -20px;
        }
    </style>

    <%--引入js文件--%>
    <script src="${app}/js/jquery-3.3.1.js"></script>
    <script src="${app}/js/bootstrap.js"></script>
    <script src="${app}/jqgrid/js/i18n/grid.locale-cn.js"></script>
    <script src="${app}/jqgrid/js/jquery.jqGrid.src.js"></script>
    <script type="text/javascript">
        $(function ()
        {
            //初始化表格
            $("#tb").jqGrid({
                url:"${app}/user/select",     //访问的位置加载数据
                editurl:"${app}/user/cdp",             //修改删除添加是的url
                datatype:"json",    //数据的类型
                colNames:["id","姓名","密码","生日","手机","状态"],   //表格头
                autowidth:true,         //自适应父容器
                caption:"用户列表",     //表格标题
                pager:"#fenye",         //开启分页展示
                rowNum:3,               //指定当前显示的条数
                page:1,                 //设置起始页码
                align:true,             //开启表格编辑
                viewrecords:['true','both'],       //是否显示总条数
                toolbar:true,           //开启页面工具栏
                rowList:["3","5","10"],   //设置每页显示的数据
                closeAfterEdit:true,
                colModel:[
                    {name:"id",align:"center",editable:true},
                    {name:"name",align:"center",editable:true}, //name 的值就是对应的内容 editable:true 开启可编辑 用于添加和修改等  align:"center"据中
                    {name:"password",align:"center",editable:true},
                    {name:"birthday",align:"center",editable:true},
                    {name:"cellphone",align:"center",editable:true},
                    {name:"state",align:"center",edittype:"select",editable:true,editoptions:{
                        value:"激活:激活;不激活:不激活"
                        }
                    }
                    ]

            })
                .jqGrid("navGrid","#fenye",{

                },{ reloadAfterSubmit:false,closeAfterEdit:true}
                ,{closeAfterAdd:true}
                ,{closeAfterDel:true})  //工具栏展示 #fenye 展示地方的id
            $("#mohucha").click(function () {
                //发送ajax
                $.ajax({
                    url:"${pageContext.request.contextPath}/user/gaoliang?name="+$("#shuru").val(),
                    datatype:"json",
                    success:function (dates)
                    {
                        //处理时数据获取模态框
                        console.log("数据长度1"+dates.length);
                        //处理查询结果
                        //接收到服务器的数据
                        //获取到表格体
                        var tbody = $("#gao");
                        //先清空内容
                        tbody.empty();
                        //遍历集合
                        for (var i=0;i<dates.length;++i)
                        {
                            console.log(dates[i]+"高亮数据")
                            //创建一个tr
                            var tr = $("<tr></tr>");
                            //创建td
                            var tid=$("<td>"+dates[i].id+"</td>");
                            var tname=$("<td>"+dates[i].name+"</td>");
                            var tpassword=$("<td>"+dates[i].password+"</td>");
                            var tbirthday=$("<td>"+dates[i].birthday+"</td>");
                            var tcellphone=$("<td>"+dates[i].cellphone+"</td>");
                            var tstate=$("<td>"+dates[i].state+"</td>");
                            //将td添加到tr中
                            //修改和删除的td
                            var tupdate=$("<td></td>");

                            //创建按钮(修改)
                            var updatebutton=$("<a href='javascript:void(0);' onclick='updates("+dates[i].id+")' class='btn btn-primary' data-target='#updateuser' data-toggle='modal'>修改</a>");
                            //将按钮添加到td中
                            tupdate.append(updatebutton);

                            //创建按钮(删除)
                            var deletebutton=$("<a href='javascript:void(0);' onclick='deletes("+dates[i].id+")' class='btn btn-primary'  data-toggle='modal'>删除</a>");
                            //将按钮添加到td中
                            tupdate.append(deletebutton);

                            //将td添加到tr中
                            tr.append(tid).append(tname).append(tpassword).append(tbirthday).append(tcellphone).append(tstate).append(tupdate);
                            tbody.append(tr);
                        }
                    }
                })
            })
        })
    </script>
</head>
<body>






<%--模态框--%>
<div class="modal fade" tabindex="-1" id="myModal" data-backdrop="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" data-target="#myModal">
                    <span>&times;</span>
                </button>
                <h4 class="modal-title">根据name查询的高亮信息</h4>
            </div>

            <div class="modal-body">
                <!--斑马线样式 有边框先-->
                <table class="table table-bordered table-striped ">
                    <!--定义表格体-->
                    <thead id="">
                    <!--表格标题-->
                    <th>id</th>
                    <th>姓名</th>
                    <th>密码</th>
                    <th>生日</th>
                    <th>手机</th>
                    <th>状态</th>
                    <th>操作</th>
                    </thead>
                    <!--表格体-->
                    <tbody id="gao">
                    </tbody>
                </table>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="myInsert">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="removeadd()">关闭</button>
            </div>
        </div>
    </div>
</div>





    <!--左边的页面-->
    <div class="col-md-12" >
        <div class="page-header" id="tou">
            <h3>用户管理</h3>
        </div>

        <!--下面的页面标签页-->

        <div class="bs-docs-section">
            <div class="bs-example bs-example-tabs" data-example-id="togglable-tabs">
                <div id="myTabContent" class="tab-content">
                    <div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
                        <!--用户列表的头部面板-->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <center>
                                    <form id="mohuform"  class="form-inline">
                                        <div class="form-group">
                                            <%--使用laberl标签--%>
                                            <lable>姓名</lable>
                                            <input id="shuru" name="name" type="text" class="form-control">
                                        </div>

                                        <%--<div class="form-group">--%>
                                            <%--<!--输入框-->--%>
                                            <%--<!--使用label标签-->--%>
                                            <%--<lable>姓名</lable>--%>
                                            <%--<input name="name" type="text" class="form-control">--%>
                                        <%--</div>--%>

                                        <%--<!--输入框-->--%>
                                        <%--<div class="form-group">--%>
                                            <%--<!--使用label标签-->--%>
                                            <%--<lable>手机</lable>--%>
                                            <%--<input name="cellphone" type="text" class="form-control">--%>
                                        <%--</div>--%>


                                        <%--&lt;%&ndash;下拉框&ndash;%&gt;--%>
                                        <%--<div class="form-group">--%>
                                            <%--<!--使用label标签-->--%>
                                            <%--<lable>激活状态</lable>--%>
                                            <%--<select name="state" class="form-control">--%>
                                                <%--<option class="form-control" value="激活">激活</option>--%>
                                                <%--<option class="form-control" value="未激活">未激活</option>--%>
                                            <%--</select>--%>
                                        <%--</div>--%>
                                        <%--<div class="btn-group">--%>

                                        <%--&lt;%&ndash;<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">&ndash;%&gt;--%>
                                        <%--&lt;%&ndash;---请选择---<span class="caret"></span>&ndash;%&gt;--%>
                                        <%--&lt;%&ndash;</button>&ndash;%&gt;--%>


                                        <%--<!--下拉列表的内容-->--%>
                                        <%--<ul class="dropdown-menu">--%>
                                        <%--<li><a href="#">Action</a></li>--%>
                                        <%--<li><a href="#">Another action</a></li>--%>
                                        <%--<li><a href="#">Something else here</a></li>--%>
                                        <%--<li role="separator" class="divider"></li>--%>
                                        <%--<li><a href="#">Separated link</a></li>--%>
                                        <%--</ul>--%>
                                        <%--</div>--%>

                                        <!--用户列表中的查询按钮-->
                                        <button  data-target="#myModal" id="mohucha" type="button" class="btn btn-primary" data-toggle="modal" aria-pressed="false" autocomplete="off">
                                            查询
                                        </button>
                                    </form>
                                </center>
                            </div>

                            <%--表格--%>
                            <%--创建一个表格--%>
                            <table id="tb"></table>
                            <%--分页工具--%>
                            <div id="fenye"></div>

                            </div>
                        </div>
                    </div>
                </div>
            </div><!-- /example -->


        </div>
    </div>
    </div>
</body>
</html>
