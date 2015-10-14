<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="vino" tagdir="/WEB-INF/tags" %>
<!-- Content Header (Page header) -->

<section class="content-header">
	<h1>
		资源管理 <small></small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i>系统管理</a></li>
		<li class="active">资源管理</li>
	</ol>
</section>

<!-- Main content -->
<section class="content">
	<div class="row">
		<!-- <div class="col-md-6"> -->
		<div class="box">
			<!-- /.box-header -->
			<div class="box-body">
				<div class="row">
					<div class="col-md-12">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">数据查询</h3>
							</div>
							<div class="box-body">
								<!-- form start -->
								<form id="searchForm" action="role/search" method="get">
									<div class="box-body">
										<div class="row">
											<input hidden="true" name="pageNumber" id="pageNumber">
											<div class="form-group col-md-2">
												<label for="nameLabel">资源名:</label>
												<input type="text" class="form-control" id="nameLabel" name="search_name" value="${searchParamsMap.name }">
											</div>
																				
											<!-- Date range -->
											<div class="form-group  col-md-4">
												<label>创建时间:</label>
												<div class="input-group">
													<div class="input-group-addon">
														<i class="fa fa-calendar"></i>
													</div>
													<input type="text" class="form-control pull-right"
														id="reservation" name="search_createTimeRange" value=${searchParamsMap.createTimeRange }>
												</div>
												<!-- /.input group -->
											</div>
										
											
											<!-- /.form group -->
										</div>
										<!-- other rows -->																					
										</div>																			
									<!-- /.box-body -->
									<div class="box-footer">
										<button id="searchBtn" type="submit" class="btn btn-info pull-right">查询</button>
									</div>
									<!-- /.box-footer -->
								</form>
							</div>
							<!-- /.box-body -->
						</div>
						<!-- /.box -->
					</div>
					<!-- /.col (right) -->
				</div>
				<!-- /.row -->
				<div class="box box-primary">
					<div class="box-header with-border">
						<h3 class="box-title">资源列表</h3>
					</div>
					<div class="btn-group">
						<!-- 注意，为了设置正确的内补（padding），务必在图标和文本之间添加一个空格。 -->
						<button id="addBtn" type="button"
							class="btn  btn-primary btn-flat margin" data-toggle="modal"
							data-target="#addModal">
							<span class="fa fa-fw  fa-plus" aria-hidden="true"></span> 新增
						</button>
						
						<button id="deleteBtn" type="button"
							class="btn  btn-danger btn-flat margin">
							<span class="fa fa-fw fa-remove" aria-hidden="true"></span> 删除</button>
				
					</div>
					<table class="table table-hover">
						<tr>
							<th style="width: 10px"><label> <input id="allCheck"
									type="checkbox" class="minimal" value="0">
							</label></th>
							<th style="width: 10px">#</th>
							<th>资源名</th>	
							<th>权限字符串</th>						
							<th>类型</th>
							<th>排序优先级</th>
							<th>菜单路径URL</th>
						
							<th>上级资源ID</th>
							<th>创建时间</th>
							<th>创建人</th>
							<th style="width: 60px">状态</th>
							<th style="width: 200px">操作</th>

						</tr>
						<c:forEach items="${resources}" var="resource" varStatus="status">
							<tr>
								<td><label><input type="checkbox"
										class="minimal deleteCheckbox" value="${resource.id}"></label></td>
								<td>${status.count}</td>
								
								<td>${resource.name}</td>
								<td>${resource.permission}</td>	
								<td>${resource.type}</td>		
								<td>${resource.priority}</td>	
								<td>${resource.url}</td>	
									
								<td>${resource.parentId}</td>												
								<td><fmt:formatDate  pattern="yyyy-MM-dd HH:mm:ss" value="${resource.createTime}"/></td>
								<td>${resource.creatorName}</td>
								<c:choose>
									<c:when test="${resource.available}">
										<td><span class="badge bg-red">可用</span></td>
									</c:when>
									<c:otherwise>
										<td><span class="badge bg-green">不可用</span></td>
									</c:otherwise>
								</c:choose>
								<td><button id="updateBtn" type="button"
										class="btn btn-xs btn-primary btn-flat " data-toggle="modal"
										data-target="#updateModal" onclick='updateItem(${resource.id})'>编辑</button>
									<button id="detailBtn" type="button"
										class="btn  btn-xs btn-primary btn-flat " data-toggle="modal"
										data-target="#detailModal" onclick='detailItem(${resource.id})'>详情</button>
									
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<!-- /.box-body -->
				<!-- 分页 -->
				<vino:pagination paginationSize="10" page="${page}" action="resource/search" contentSelector="#content-wrapper"></vino:pagination>				
			</div>
			<!-- /.box -->
		</div>
	</div>
</section>
<!-- /.content -->

<!-- 新增页面 modal框 -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="exampleModalLabel">新增资源</h4>
			</div>
			<div class="modal-body">

				<form id="addForm" action="resource/add" method="post">
					<div class="form-group">
						<label for="name" class="control-label">资源名:</label> <input
							type="text" class="form-control" id="name" name="name">
					</div>
					<div class="form-group">
						<label for="permission" class="control-label">权限字符串:</label> <input
							type="text" class="form-control" id="permission" name="permission">
					</div>
					<div class="form-group">
						<label for="type" class="control-label">资源类型:</label> <input
							type="text" class="form-control" id="type" name="type">
					</div>
					<div class="form-group">
						<label for="url" class="control-label">菜单路径URL:</label> <input
							type="text" class="form-control" id="url" name="url">
					</div>
					<div class="form-group">
						<label for="priority" class="control-label">排序优先级:</label> <input
							type="text" class="form-control" id="priority" name="priority">
					</div>		
					<div class="form-group">
						<label for="parentId" class="control-label">上级资源ID:</label> <input
							type="text" class="form-control" id="parentId" name="parentId">
					</div>
								
					
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary" id="addSubmitBtn">提交</button>
			</div>
		</div>
	</div>
</div>
<!-- ./新增页面 modal框 -->

<!-- 编辑页面 modal框  -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content"></div>
	</div>
</div>

<!-- 详情页面 modal框  -->
<div class="modal fade" id="detailModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content"></div>
	</div>
</div>



<script>
	/*   */
	//Date range picker
	$('#reservation').daterangepicker();
	//Date range picker with time picker
	$('#reservationtime').daterangepicker({timePicker: true, timePickerIncrement: 30, format: 'MM/DD/YYYY h:mm A'});
	
	/* icheck 初始化 详情：https://github.com/fronteed/icheck */
   	iCheckInit();
 	/* iCheck事件监听 详情：https://github.com/fronteed/icheck */
 	/* 全选和取消全选 */
	$(document).ready(function(){
		$('#allCheck').on('ifToggled', function(event){		
			$('input[class*="deleteCheckbox"]').iCheck('toggle');			
		});
		
	});
	

	/* button监听事件 */
	$(document).ready(function(){
		$("#deleteBtn").click(function(){
			deleteItems("input[class*='deleteCheckbox']","resource/delete");
		});
		
	});
		
 	/*modal框事件监听 详情：http://v3.bootcss.com/javascript/#modals-events */
	$('#addModal').on('shown.bs.modal', function(event) {			
			$("#addSubmitBtn").click(function() {
				$.ajax({
					async : false,
					cache : false,
					type : 'POST',
					data : $("#addForm").serialize(),
				   // contentType : 'application/json',    //发送信息至服务器时内容编码类型
					//dataType : "json",
					url : "resource/add",//请求的action路径  
					error : function() {//请求失败处理函数  
						alert('失败');
					},
					success : function(data) { //请求成功后处理函数。    
						alert("success");
						$('#addModal').on('hidden.bs.modal',function(event){//当modal框完全隐藏后再刷新页面content，要不然有bug
							$("#content-wrapper").html(data);//刷新content页面
						});
					}
				});
			});
		});
	

	$("#searchBtn").click(function() {
		$('#pageNumber').val(1);
		$.ajax({
			async : false,
			cache : false,
			type : 'GET',
			data : $("#searchForm").serialize(),		 
			url : "resource/search",//请求的action路径  
			error : function() {//请求失败处理函数  
				alert('失败');
			},
			success : function(data) { //请求成功后处理函数。    
				$("#content-wrapper").html(data);//刷新content页面
			
			}
		});
	});

	function updateItem(id){
		$('#updateModal').on('show.bs.modal',function(event){
			$('#updateModal .modal-content').load('resource/'+id);
		});
	}
	function detailItem(id){
		$('#detailModal').on('show.bs.modal',function(event){
			$('#detailModal .modal-content').load('resource/detail/'+id)
		});
	}
	
	
</script>