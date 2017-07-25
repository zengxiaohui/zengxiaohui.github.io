package com.zzq.back.common.datasource;

import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

/**
 * 动态数据源路由
 * 
 * @author carlsummer
 * @date 2016年12月3日 下午21:28:51
 * @version 1.0
 * @Copyright Copyright (c)
 *
 */
public class DynamicDataSource extends AbstractRoutingDataSource {

	@Override
	protected Object determineCurrentLookupKey() {
		return DataSourceHandle.getDataSource();
	}

}
