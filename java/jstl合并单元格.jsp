<span style="font-size:14px;"> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" > 
<tr> 
<th> 
报表名称 
</th> 
</tr> 
<c:set var="tempCount" value="0"></c:set><%--临时变量 --%> 
<c:set var="rowspanCount" value="0"></c:set><%--记录合并列数 --%> 
<c:set var="tempFrist" value="0"></c:set><%--记录合并开始位置 --%> 
<c:set var="tempEnd" value="-1"></c:set><%--记录合并结束位置 --%> 
<c:forEach items="${list}" var="accountConfig" varStatus="status" > 
<tr> 
<%--利用一个结果集List<Bean>来生成，数据过多会加重客户断负担 --%> 
<c:if test="${status.index>=tempEnd}"> 
<c:set var="rowspanCount" value="0"></c:set><%--清楚历史数据 --%> 
<c:forEach var="item2" items="${list}" varStatus="status2"> 
<%-- tablename指要合并的属性 --%> 
<c:if test="${accountConfig.tablename==item2.tablename}"> 
<c:set var="tempFrist" value="${status.index }"></c:set> 
<c:set var="rowspanCount" value="${rowspanCount+1 }"></c:set> 
<c:set var="tempEnd" value="${tempFrist+rowspanCount }"></c:set> 
</c:if> 
</c:forEach> 
</c:if> 
<c:if test="${status.index==tempFrist}"> 
<td rowspan="${rowspanCount}"> 
<%-- tablename指要合并的属性 --%> 
${accountConfig.tablename} 
</td> 
</c:if> 
</tr> 
</c:forEach> 
</table> 
</span>