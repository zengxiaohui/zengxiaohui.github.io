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
<title>登录</title>
<link rel="shortcut icon" href="${ctx}/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="${ctx}/static/css/login.css?rev=@@hash">
</head>
<body>
	<div id="login_warp">
		<div class="hd_login">
		    <div class="hder_login">
			    <a class="login_logo">
			    	<img src="${ctx}/static/img/login/logo.png?rev=@@hash">
			    </a>
		    </div>
	    </div>
		<div class="bg_login">
			<div class="co_login">
				<div class="form_login">
					<div class="box_login">
						<div class="box_hd"><h1>账号登录</h1></div>
						<div class="box_form">
							<form action="${ctx }/login" id="login_form" method="post">
								<div class="item">
									<label for="" class="lo_name"></label>
									<input type="text" class="name" name="username">
								</div>
								<div class="item">
									<label for="" class="lo_pwd"></label>
									<input type="password" class="name" name="password">
								</div>
								<div class="item_cl">
									<span class="checkbox">
									    <input type="checkbox" class="checkbox" id="autoLogin">
									    <i class="checkbox"></i>
									</span>
									<label for="autoLogin">自动登录</label>
								</div>
								<div class="item">
									<a href="javascript:void(0);" class="sub_login" id="submit">登录</a>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="ft_login">
			<div class="subft_login">
				<div class="subft_hd">
					<a href="http://www.wealink.com/gongsi/jianjie/1800366/">南京飞吉介绍</a>|
					<a href="">联系我们</a>
				</div>
				<div class="subft_co"></div>
				<div class="subft_ft">Copyright©2015飞吉版权所有</div>
			</div>
		</div>
	</div>
	<!--# mergeTo:${ctx}/static/js/login.js -->
		<!-- build:js ../../static/js/login.js -->
	    <script replace="gulp" src="${ctx}/static/plugin/jquery/1.11.3/jquery.min.js"></script>
		<script replace="gulp" src="${ctx}/static/javascript/common.js"></script>
		<script replace="gulp" src="${ctx}/static/javascript/login.js"></script> 
	    <!-- endbuild -->
	<!--# mergeTo -->
</body>
</html>