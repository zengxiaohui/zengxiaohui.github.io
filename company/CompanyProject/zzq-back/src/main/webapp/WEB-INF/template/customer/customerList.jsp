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
<title>用户信息管理页面</title>
<link rel="shortcut icon" href="${ctx}/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="${ctx}/static/css/base.css?rev=@@hash">
</head>
<body>
  <div class="table-box">
	<div class="page_name">业主信息设定</div>
    <div class="button_box"><a href="#" class="blue_button add">新增</a></div>
    <div class="list_table_header">
   	    <table width="100%">
    	    <tbody>
	     	    <tr>
		      	    <td width="30"><img src="${ctx}/static/img/main/icon_search.png?rev=@@hash"></td>
		      	    <td width="80">姓名：</td>
		      	    <td><input type="text" name="queryName" style="width:90%" value="${customerInfo.name }"></td>
		      	    <td width="80">性别：</td>
		      	    <td>
		      	    	<select style="width:90%" name="querySex">
		      	    		<option value="">请选择</option>
		      	    		<option value="0" <c:if test="${customerInfo.sex eq false }">selected</c:if>>男</option>
		      	    		<option value="1" <c:if test="${customerInfo.sex eq true }">selected</c:if>>女</option>
		      	    	</select>
		      	    </td>
		      	    <td width="80">手机号：</td>
		      	    <td><input type="text" name="queryMobile" style="width:90%" value="${customerInfo.mobile }"></td>
		      	    <td width="100"><a href="javascript:customer.queryCustomer();" class="blue_button">查询</a></td>
		      	    <td><a href="#" class="unfold_arr"></a></td>
		        </tr>
  	 		</tbody>
  	 	</table>
    </div>
    <div class="list_table">
   	  <table width="100%">
    		<thead>
     		<tr>
      	    <th>姓名</th>
      	    <th>性别</th>
      	    <th>手机号</th>
      	    <th>详细地址</th>
      	    <th>备注</th>
      	    <th width="80">操作</th>
	        </tr>
        </thead>
	    <tbody id="customerInfoTable">
	        <c:forEach items="${pageInfo.list }" var="customerInfo">
			<tr customerInfoId="${customerInfo.id }">
				<td>${customerInfo.name }</td>
				<td>
					<c:choose>
						<c:when test="${customerInfo.sex eq false }">男</c:when>
						<c:otherwise>女</c:otherwise>
					</c:choose>
				</td>
				<td>${customerInfo.mobile }</td>
				<td>${customerInfo.detailAddress }</td>
				<td>${customerInfo.remark }</td>
				<td><a href="javascript:void(0);" onclick="customer.editCustomer(${customerInfo.id});" class="edit" title="编辑"></a><a href="javascript:void(0);" onclick="customer.deleteCustomer(${customerInfo.id},this);" class="delete" title="删除"></a></td>
			</tr>	
			</c:forEach>
   	  	</tbody>
  	  </table>
    </div>
   	<%@ include file="../common/page.jsp" %>
  </div>
	<div class="form-box">
          <div class="page_name">业主信息维护</div>
            <div class="button_box"><a href="#" class="back">返回</a></div>
            <div class="form_table" customerInfoId="">
              <table width="100%">
                <tbody><tr class="odd">
                  <td width="100">姓名：</td>
                  <td><input name="name" type="text" id="textfield" style="width:400px;"></td>
                </tr>
                <tr>
                  <td>性别：</td>
                  <td>
                    <label for="sex-m">先生<input name="sex" type="radio" id="sex-m" checked="checked"></label>
                    <label for="sex-w">女士<input name="sex" type="radio" id="sex-w"></label>
                  </td>
                </tr>
                <tr class="odd">
                  <td>手机号：</td>
                  <td><input name="mobile" type="text" id="textfield3" style="width:400px;"></td>
                </tr>
                <tr>
                  <td>详细地址：</td>
                  <td><input name="detailAddress" type="text" id="textfield4" style="width:400px;"></td>
                </tr>
                <tr class="odd">
                  <td>备注：</td>
                  <td><textarea name="remark" id="textfield5" style="width:99%; height:150px;"></textarea></td>
                </tr>
              </tbody></table>
            </div>
            <div class="button_box_bottom"><a href="javascript:void(0);" class="blue_button submit">保存</a></div>
	</div>
	<!--# mergeTo:${ctx}/static/js/customer.js -->
		<!-- build:js ../../static/js/customer.js -->
	    <script replace="gulp" src="${ctx}/static/plugin/jquery/1.11.3/jquery.min.js"></script>
		<script replace="gulp" src="${ctx}/static/javascript/common.js"></script>
		<script replace="gulp" src="${ctx}/static/javascript/services/pages.js"></script>
		<script replace="gulp" src="${ctx}/static/javascript/customer.js"></script>
	    <!-- endbuild -->
	<!--# mergeTo -->
</body>
</html>