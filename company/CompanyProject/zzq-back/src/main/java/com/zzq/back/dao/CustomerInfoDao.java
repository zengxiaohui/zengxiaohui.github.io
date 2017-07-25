package com.zzq.back.dao;

import java.util.List;

import com.zzq.back.entity.CustomerInfo;

public interface CustomerInfoDao {
	List<CustomerInfo> selectCustomerInfoByParam(CustomerInfo record);
	
	int insertSelective(CustomerInfo record);
	
    int deleteByPrimaryKey(Long id);
    
    CustomerInfo selectByPrimaryKey(Long id);
    
    int updateByPrimaryKeySelective(CustomerInfo record);
 
    int insert(CustomerInfo record);

    int updateByPrimaryKey(CustomerInfo record);
}