<%--
  Created by IntelliJ IDEA.
  User: 曾健林
  Date: 2019/11/28
  Time: 10:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <style>
        #tou{
            margin-top: -20px;
        }
    </style>

    <script type="text/javascript">
        <%--当页面加载完成后使用ajax发送请求--%>
        function aj() {

            $.ajax({
                url:"${pageContext.request.contextPath}/user/select",
                datatype:"json",
                success:function (dates)
                {
                    //接收到服务器的数据
                    //获取到表格体
                    var tbody = $("#mybody");
                    //先清空内容
                    tbody.empty();
                    //遍历集合
                    for (var i=0;i<dates.length;++i)
                    {
                        //创建一个tr
                        var tr = $("<tr></tr>");
                        //创建td
                        var tid=$("<td>"+dates[i].id+"</td>");
                        var tname=$("<td>"+dates[i].name+"</td>");
                        var tpassword=$("<td>"+dates[i].password+"</td>");
                        var tbirthday=$("<td>"+dates[i].birthday+"</td>");
                        var tcellphone=$("<td>"+dates[i].cellphone+"</td>");
                        var tstate=$("<td>"+dates[i].state+"</td>");

                        //修改和删除的td
                        var tupdate=$("<td></td>");

                        //创建按钮(修改)
                        var updatebutton=$("<a href='javascript:void(0);' onclick='updates("+dates[i].id+")' class='btn btn-primary' data-target='#updateuser' data-toggle='modal'>修改</a>");
                        //将按钮添加到td中
                        tupdate.append(updatebutton);

                        //创建按钮(修改)
                        var deletebutton=$("<a href='javascript:void(0);' onclick='deletes("+dates[i].id+")' class='btn btn-primary'  data-toggle='modal'>删除</a>");
                        //将按钮添加到td中
                        tupdate.append(deletebutton);

                        //将td添加到tr中
                        tr.append(tid).append(tname).append(tpassword).append(tbirthday).append(tcellphone).append(tstate).append(tupdate);
                        //将tr添加到表格体中
                        tbody.append(tr);
                    }

                }
            })
        }
        $(function(){

                aj();

                //添加用户 为按钮添加一个单击事件
                $("#baocun").click(function () {
                    $.ajax({
                        url:"${pageContext.request.contextPath}/user/insert",
                        datatype:"json",
                        data:$("#inserform").serialize(),           //使用表单序列化
                        success:function (date) {
                            //调用模态框隐藏方法
                            $("#myModal").modal("hide");
                            //清空表格数据
                            $("#inserform")[0].reset();
                            aj();
                        }
                    })
                });


                //模糊查询用户
                $("#mohucha").click(function () {
                    $.ajax({
                        url:"${pageContext.request.contextPath}/user/likeselect",
                        datatype:"json",
                        data:$("#mohuform").serialize(),//表单序列化
                        success:function (dates) {
                            console.log(dates+"模糊数据")
                            //处理查询结果
                            //接收到服务器的数据
                            //获取到表格体
                            var tbody = $("#mybody");
                            //先清空内容
                            tbody.empty();
                            //遍历集合
                            for (var i=0;i<date.length;++i)
                            {
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
                });

                //修改用户
                $("#xiugai").click(function () {
                    console.log("修改区-----------")
                    $.ajax({
                        url:"${pageContext.request.contextPath}/user/update",
                        datatype:"json",
                        data:$("#xiugaiform").serialize(),  //表单数据序列化
                        success:function (date) {
                            //隐藏模态框
                            $("#updateuser").modal("hide");
                            //清空表单数据
                            $("#xiugaiform")[0].reset();
                            //调用查询所有的ajax
                            aj();
                        }
                    })
                })
        })

        //删除
        function deletes(ss){
            $.ajax({
                url:"${pageContext.request.contextPath}/user/delete",
                datatype:"json",
                data:"id="+ss,
                success:function (date) {
                    aj();
                }
            })
        }

        //修改回显
        function updates(ss){
            $.ajax({
                url:"${pageContext.request.contextPath}/user/selectid",
                datatype:"json",
                data:"id="+ss,
                success:function (date) {
                    // 获取给表单设置值
                    $("#id").val(date.id);
                    $("#uname").val(date.name);
                    $("#upassword").val(date.password);
                    $("#ubirthday").val(date.birthday);
                    $("#ucellphone").val(date.cellphone);
                    if (date.state=='激活')
                    {
                        $("#ustate").val('激活');
                    }
                    else {
                        $("#ustate").val('未激活');
                    }

                }
            })
        }
    </script>




    <!--左边的页面-->
    <div class="col-md-9" >
        <div class="page-header" id="tou">
            <h3>用户管理</h3>
        </div>

        <!--下面的页面标签页-->

        <div class="bs-docs-section">
            <div class="bs-example bs-example-tabs" data-example-id="togglable-tabs">
                <ul id="myTabs" class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active"><a href="https://v3.bootcss.com/javascript/#home" id="home-tab" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">用户列表</a></li>
                    <li role="presentation"><a href="#" data-target="#myModal"  data-toggle="modal">用户添加</a></li>
                </ul>
                <div id="myTabContent" class="tab-content">
                    <div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
                        <!--用户列表的头部面板-->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <center>
                                    <form id="mohuform"  class="form-inline">
                                        <div class="form-group">
                                            111111
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
                                        <button id="mohucha" type="button" class="btn btn-primary" data-toggle="button" aria-pressed="false" autocomplete="off">
                                            查询
                                        </button>
                                    </form>
                                </center>
                            </div>

                            <!--下面的表格体-->
                            <div class="panel-body">
                                <!--表格-->

                                <!--斑马线样式 有边框先-->
                                <table class="table table-bordered table-striped ">
                                    <!--定义表格体-->
                                    <thead>
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
                                    <tbody id="mybody">
                                    <!--表格内容-->
                                    <%--<c:forEach items="${requestScope.list}" var="list">--%>
                                    <%--<tr>--%>
                                        <%--<!--id-->--%>
                                        <%--<td>${list.id}</td>--%>
                                        <%--<!--姓名-->--%>
                                        <%--<td>${list.name}</td>--%>
                                        <%--<!--密码-->--%>
                                        <%--<td>${list.password}</td>--%>
                                        <%--<!--生日-->--%>
                                        <%--<td>${list.birthday}</td>--%>
                                        <%--<!--手机-->--%>
                                        <%--<td>${list.cellphone}</td>--%>
                                        <%--<!--状态-->--%>
                                        <%--<td>${list.state}</td>--%>
                                        <%--<!--操作-->--%>
                                        <%--<td>--%>
                                            <%--<!--操作的按钮-->--%>
                                            <%--<!--修改-->--%>
                                            <%--<!--data-toggle="modal"属性用于关闭打开模态框-->--%>
                                            <%--<!--data-target="#updateuser":用于打开指定的模态框-->--%>
                                            <%--<a href="#" class="btn btn-primary" data-target="#updateuser" data-toggle="modal">修改</a>--%>

                                            <%--<!--删除-->--%>
                                            <%--<button type="button" class="btn btn-primary" data-toggle="button" aria-pressed="false" autocomplete="off">--%>
                                                <%--删除--%>
                                            <%--</button>--%>
                                        <%--</td>--%>
                                    <%--</tr>--%>
                                    <%--</c:forEach>--%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!-- /example -->


        </div>
    </div>
</div>



<!-- 用户添加模态框 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <!--模态框头部显示内容-->
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >用户添加</h4>
            </div>
            <div class="modal-body" align="center">
                <!--模态框体-->
                <!--表单  使用水平表单加栅格-->
                <form id="inserform" class="form-horizontal">
                    <!--要使用div进行分组-->
                    <div class="form-group">
                        <!--使用laber进行文字提示该标签必须要 要在class属性中加入control-laber-->
                        <label class="col-sm-3 control-label">姓名</label>
                        <!--先使用div进行栅格-->
                        <div class="col-sm-8">
                            <input name="name" type="text" class="form-control">
                        </div>
                    </div>

                    <!--密码-->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">密码</label>
                        <!--使用密码框-->
                        <div class="col-sm-8">
                            <input name="password" type="password" class="form-control">
                        </div>
                    </div>

                    <%--<!--年龄-->--%>
                    <%--<div class="form-group">--%>
                        <%--<label class="col-sm-3 control-label">年龄</label>--%>
                        <%--<!--使用文本框-->--%>
                        <%--<div class="col-sm-8">--%>
                            <%--<input name="" type="text" class="form-control">--%>
                        <%--</div>--%>
                    <%--</div>--%>

                    <!--生日-->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">生日</label>
                        <!--使用时间框-->
                        <div class="col-sm-8">
                            <input name="birthday" type="date" class="form-control">
                        </div>
                    </div>

                    <!--手机号-->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">手机号</label>
                        <!--使用文本框-->
                        <div class="col-sm-8">
                            <input name="cellphone" type="text" class="form-control">
                        </div>
                    </div>

                    <!--激活状态-->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">激活状态</label>
                        <!--使用下拉列表-->
                        <div class="col-xs-3">
                            <select name="state" class="form-control">
                                <option value="激活">激活</option>
                                <option value="未激活">未激活</option>
                            </select>
                        </div>

                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <!--模态框尾部-->
                <!--关闭和保存的按钮-->
                <button type="button" id="baocun" class="btn btn-primary" data-dismiss="modal">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>




<!--用户修改模态框-->
<div class="modal fade" id="updateuser" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <!--模态框头部显示内容-->
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">修改用户信息</h4>
            </div>
            <div class="modal-body" align="center">
                <!--模态框体-->
                <!--表单  使用水平表单加栅格-->
                <form id="xiugaiform" class="form-horizontal">
                    <%--id不用显示--%>
                    <input type="hidden" id="id" value="" name="id">
                    <!--要使用div进行分组-->
                    <div class="form-group">
                        <!--使用laber进行文字提示该标签必须要 要在class属性中加入control-laber-->
                        <label class="col-sm-3 control-label">姓名</label>
                        <!--先使用div进行栅格-->
                        <div class="col-sm-8">
                            <input id="uname" name="name" type="text" class="form-control">
                        </div>
                    </div>

                    <!--密码-->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">密码</label>
                        <!--使用密码框-->
                        <div class="col-sm-8">
                            <input id="upassword" name="password" type="text" class="form-control">
                        </div>
                    </div>

                    <%--<!--年龄-->--%>
                    <%--<div class="form-group">--%>
                        <%--<label class="col-sm-3 control-label">年龄</label>--%>
                        <%--<!--使用文本框-->--%>
                        <%--<div class="col-sm-8">--%>
                            <%--<input type="text" class="form-control">--%>
                        <%--</div>--%>
                    <%--</div>--%>

                    <!--生日-->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">生日</label>
                        <!--使用时间框-->
                        <div class="col-sm-8">
                            <input id="ubirthday" name="birthday" type="text" class="form-control">
                        </div>
                    </div>

                    <!--手机号-->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">手机号</label>
                        <!--使用文本框-->
                        <div class="col-sm-8">
                            <input id="ucellphone" name="cellphone" type="text" class="form-control">
                        </div>
                    </div>

                    <!--激活状态-->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">激活状态</label>
                        <!--使用下拉列表-->
                        <div class="col-xs-3">
                            <select id="ustate" name="state" class="form-control">
                                <option value="激活">激活</option>
                                <option value="未激活">未激活</option>
                            </select>
                        </div>

                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <!--模态框尾部-->
                <!--关闭和保存的按钮-->
                <button type="button" id="xiugai" class="btn btn-primary" data-dismiss="modal">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>