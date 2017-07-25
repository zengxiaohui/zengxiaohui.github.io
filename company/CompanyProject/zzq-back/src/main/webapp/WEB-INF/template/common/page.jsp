<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="taglibs.jsp" %>

<div class="pages" pagenum="${pageInfo.pageNum}">
	<div class="left">共有${pageInfo.total }笔记录，当前${pageInfo.startRow}-${pageInfo.endRow}笔记录</div>
    <div class="right">
    	<c:choose>
    		<c:when test="${pageInfo.firstPage > 1 }">
    			<a href="javascript:pages.pageSelect(1);" class="first"></a>
    		</c:when>
    		<c:otherwise>
    			<a href="javascript:void(0);" class="first"></a>
    		</c:otherwise>
    	</c:choose>
    	<c:choose>
    		<c:when test="${pageInfo.pageNum > 1 }">
    			<a href="javascript:pages.pageSelect(${pageInfo.pageNum - 1 });" class="prev"></a>
    		</c:when>
    		<c:otherwise>
    			<a href="javascript:void(0);" class="prev"></a>
    		</c:otherwise>
    	</c:choose>
    	<c:choose>
    		<c:when test="${pageInfo.pages > pageInfo.pageNum }">
    			<a href="javascript:pages.pageSelect(${pageInfo.pageNum + 1 });" class="next"></a>
    		</c:when>
    		<c:otherwise>
    			<a href="javascript:void(0);" class="next"></a>
    		</c:otherwise>
    	</c:choose>
    	<c:choose>
    		<c:when test="${pageInfo.isLastPage eq false }">
    			<a href="javascript:pages.pageSelect(${pageInfo.pages });" class="last"></a>
    		</c:when>
    		<c:otherwise>
    			<a href="javascript:void(0);" class="last"></a>
    		</c:otherwise>
    	</c:choose>
    </div>
    <div class="clear"></div>
</div>