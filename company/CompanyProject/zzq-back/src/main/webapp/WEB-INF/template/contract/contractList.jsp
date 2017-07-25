<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1, maximum-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="renderer" content="webkit">
<title>合同列表</title>
<link rel="shortcut icon" href="${ctx}/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="${ctx}/static/css/contract.css?rev=@@hash">
</head>
<body>
	<ul class="toolbox">
		<li>
			<a class="btn btn-blue btn-xs" href="javascript:void(0);" onclick="newOrder();">查询</a>
			<a class="btn btn-gray btn-xs" href="javascript:void(0);" onclick="newOrder();">清空条件</a>
			<a class="btn btn-yellow btn-xs" href="javascript:void(0);" onclick="newOrder();">新增</a>
		</li>
	</ul>
	<table class="table table-bordered table-hover">
		<thead>
			<tr>
				<th>序号</th><th>合同编号</th><th>工程名称</th><th>姓名</th><th>联系电话</th><th>签合同日期</th><th>工期</th><th>工程总价</th>
				<th>已收款</th><th>设计师</th><th>业务员</th><th>项目经理</th><th>开工提成</th><th>完工提成</th><th>效果图报价</th><th>效果图制作</th>
				<th>效果图打印</th><th>施工图报价</th><th>实发施工图</th><th>优惠项目</th><th>备注</th>
			</tr>
		</thead>
		<tbody>
			
		</tbody>
	</table>
	<!--# mergeTo:${ctx}/static/js/contract.js -->
		<!-- build:js ../../static/js/contract.js -->
	    <script replace="gulp" src="${ctx}/static/plugin/jquery/1.11.3/jquery.min.js"></script>
		<script replace="gulp" src="${ctx}/static/javascript/common.js"></script>
		<script replace="gulp" src="${ctx}/static/javascript/contract.js"></script>
	    <!-- endbuild -->
	<!--# mergeTo -->
</body>
</html>