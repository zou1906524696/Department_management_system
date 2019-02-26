<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<!-- 不以/的相对路径，是以当前资源的路径为基准 -->
<!-- 以/的相对路径，是以服务器的路径为基准
	http://localhost:3306/ssm
 -->
<script src="${APP_PATH }/static/js/jquery-3.3.1.min.js"></script>
<link href="${APP_PATH }/static/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH }/static/bootstrap-3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<!-- 员工修改模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">员工修改</h4>
      </div>
      <div class="modal-body">
      <form class="form-horizontal">
		  <div class="form-group">
		    <label class="col-sm-2 control-label">empName</label>
		    <div class="col-sm-10">
		       <p class="form-control-static" id="empName_update_static"></p>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">email</label>
		    <div class="col-sm-10">
		      <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
			  <span class="help-block"></span>		    
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">gender</label>
		    <div class="col-sm-10">
			<label class="radio-inline">
				<input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
			</label>
			<label class="radio-inline">
				<input type="radio" name="gender" id="gender2_update_input" value="F"> 女
			</label>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label class="col-sm-2 control-label">deptName</label>
		    <div class="col-sm-4">
		      <select class="form-control" name="d_id" id="dept_update_select">
	
		      </select>
		    </div>
		  </div>
		  
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
      </div>
    </div>
  </div>
</div>


<!-- 员工添加模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
      </div>
      <div class="modal-body">
      <form class="form-horizontal">
		  <div class="form-group">
		    <label class="col-sm-2 control-label">empName</label>
		    <div class="col-sm-10">
		      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">email</label>
		    <div class="col-sm-10">
		      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
			  <span class="help-block"></span>		    
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">gender</label>
		    <div class="col-sm-10">
			<label class="radio-inline">
				<input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
			</label>
			<label class="radio-inline">
				<input type="radio" name="gender" id="gender2_add_input" value="F"> 女
			</label>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label class="col-sm-2 control-label">deptName</label>
		    <div class="col-sm-4">
		      <select class="form-control" name="d_id" id="dept_add_select">
	
		      </select>
		    </div>
		  </div>
		  
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
      </div>
    </div>
  </div>
</div>


	<!--搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_model_btn">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 表格 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					
					</tbody>
				</table>
			</div>
		</div>
		<!-- 分页 -->
		<div class="row">
			<div class="col-md-6" id="page_info_area">
				
			</div>
			<div class="col-md-6" id="page_nav_area">
				
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	
		var totalRecord;
		//1.页面加载完成以后，直接发送一个ajax请求，要到封页数据
		$(function(){
			to_page(1);
			/* $.ajax({
				url:"${APP_PATH}/emps",
				data:"pn=1",
				type:"GET",
				success:function(result){
					//console.log(result);
					//1.解析显示员工信息
					build_emps_table(result);
					//2.解析显示分页信息
					build_page_info(result);
					build_page_nav(result);
				}
			}); */
		});
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn=" + pn,
				type:"GET",
				success:function(result){
					//console.log(result);
					//1.解析显示员工信息
					build_emps_table(result);
					//2.解析显示分页信息
					build_page_info(result);
					build_page_nav(result);
				}
			});
		}
		
		function build_emps_table(result){
			//情空表格
			$("#emps_table tbody").empty();
			
			var emps = result.extend.PageInfo.list;
			$.each(emps,function(index,item){
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var departmentnameTd = $("<td></td>").append(item.department.departmentname);
				
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				editBtn.attr("edit-id",item.empId);
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				//append 方法执行完成后还是原来的元素
				$("<tr></tr>").append(empIdTd)
					.append(empNameTd)
					.append(genderTd)
					.append(emailTd)
					.append(departmentnameTd)
					.append(btnTd)
					.appendTo("#emps_table tbody");
			
			});
		}
		
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前第"+result.extend.PageInfo.pageNum+"页,总共" +
					result.extend.PageInfo.pages+"页,总共"+
					result.extend.PageInfo.total+"条记录");
			totalRecord = result.extend.PageInfo.total;
		}
		
		function build_page_nav(result){
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			if(result.extend.PageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(result.extend.PageInfo.pageNum-1);
				});	
			}
			ul.append(firstPageLi).append(prePageLi);
			
			
			$.each(result.extend.PageInfo.navigatepageNums,function(index,item){
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(result.extend.PageInfo.pageNum == item ){
					numLi.addClass("active");
				}
				ul.append(numLi);
				numLi.click(function(){
					to_page(item);
				});
			});
			
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			if(result.extend.PageInfo.hasNextPage == false){
				lastPageLi.addClass("disabled");
				nextPageLi.addClass("disabled");
			}else{
				lastPageLi.click(function(){
					to_page(result.extend.PageInfo.pages);
				});
				nextPageLi.click(function(){
					to_page(result.extend.PageInfo.pageNum+1);
				});
			}
			
			ul.append(nextPageLi).append(lastPageLi);
			
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		
		function reset_form(ele){
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		//点击新增，弹出模态框
		$("#emp_add_model_btn").click(function(){
			reset_form("#empAddModal form");
			
			//清除表单数据
			/* $("#empAddModal form")[0].reset(); */
			//发送请求获取部门信息下拉列表
			getDepts("#dept_add_select");
			$("#empAddModal").modal(function(){
				backdrop:"static" 
			});
		});
		
		function getDepts(ele){
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//console.log(result);
				/* 	  <!-- {"code":100,"msg":"处理成功！ ",
						  "extend":{"depts":[{"id":1,"departmentname":"开发部"},
						                     {"id":2,"departmentname":"测试部"}]}} -->
		      		 */
					$.each(result.extend.depts,function(index,item){
						var optionEle = $("<option></option>").append(this.departmentname).attr("value",this.id);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		
		function validate_add_form(){
			//1.拿到需要校验的数据，使用正则表达式
			
			var empName = $("#empName_add_input").val();
			var regName =/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				//alert("用户名可以是2-5位中文或者6-16位英文与数字的组合");
				show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文与数字的组合");
				return false;
			}else{
				show_validate_msg("#empName_add_input","success","");
			}
			//校验邮箱
			var email = $("#email_add_input").val();
			var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_add_input","error","邮箱格式不正确");
				/* $("#email_add_input").parent().addClass("has-error");
				$("#email_add_input").next("span").text("邮箱格式不正确"); */
				return false;
			}else{
				show_validate_msg("#email_add_input","success","");
				/* $("#email_add_input").parent().addClass("has-success");
				$("#email_add_input").next("span").text(""); */
				
			}
			return true;
		}
		
		function show_validate_msg(ele,status,msg){
			//清除
			
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success" == status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		 $("#empName_add_input").change(function(){
			//发送ajax请求校验用户名是否可用
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName=" + empName,
				type:"POST",
				success:function(result){
					if(result.code == 100){
						show_validate_msg("#empName_add_input","success","用户名可用");
						$("#emp_save_btn").attr("ajax-va","success");
					}else{
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
						$("#emp_save_btn").attr("ajax-va","error");
					}
				}
			});
		});
		$("#emp_save_btn").click(function(){
			/* alert($("#empAddModal form").serialize()+"&dId="+$("#d_id").val()); */
			//1.先对要提交的给服务器发送校验请求
			if(!validate_add_form()){
				return false;
			}
			if($(this).attr("ajax-va") == "error"){
				return false;
			}
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize()+"&dId="+$("#d_id option").val(),
				success:function(result){
					if(result.code == 100){
						$("#empAddModal").modal('hide');
						//使用ajax显示最后一页
						to_page(totalRecord);
					}else{
						//console.log(result);
						if(undefined != result.extend.errorFields.email){
							//显示邮箱错误信息
							show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
						}
						if(undefined != result.extend.errorFields.empName){
							//显示名字错误信息
							show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
						}
					}j
				}
			});
		});
		
		$(document).on("click",".edit_btn",function(){
			//alert("员工修改");
			//0.查出员工信息,显示员工信息
			
			
			//1.查出部门信息，并显示部门列表
			getDepts("#dept_update_select");
			//0.查出员工信息,显示员工信息
			getEmp($(this).attr("edit-id"));
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$("#empUpdateModal").modal(function(){
				backdrop:"static" 
			});
			
		});
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					//console.log(result);
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.d_id]);
				}
			});
		}
		
		$("#emp_update_btn").click(function(){
			//验证邮箱是否合法
			var email = $("#email_update_input").val();
			var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_update_input","error","邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_update_input","success","");
			}
			
			//2.发送ajax请求保存更新的员工信息 
			$.ajax({
				url:"${APP_PATH}/emp/" + $(this).attr("edit-id"),
				type:"POST",
				data:$("#empUpdateModal form").serialize()+"&_method=put",
				success:function(result){
					alert(result.msg)
				}
			});
		});
		
	</script>
	
</body>
</html>