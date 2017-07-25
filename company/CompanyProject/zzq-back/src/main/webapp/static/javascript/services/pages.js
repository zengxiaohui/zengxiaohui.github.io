var pages = {
	pageSelect : function(pageNo) {
		window.location.href = base.getUrlParam("pageNum") != null ? base
				.replaceParamVal(window.location.href, "pageNum", pageNo)
				: base.urlUpdateParams(window.location.href, "pageNum", pageNo);
	}
}