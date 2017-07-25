package com.zzq.back.service.customer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zzq.back.dao.CustomerInfoDao;
import com.zzq.back.entity.CustomerInfo;

@Service
public class CustomerInfoService {

	@Autowired
	private CustomerInfoDao customerInfoDao;

	public PageInfo<CustomerInfo> queryListByPage(Integer pageNum, CustomerInfo customerInfo) {
		pageNum = pageNum != null ? pageNum : 1;
		PageHelper.startPage(pageNum, 20, true);
		List<CustomerInfo> customerInfoList = customerInfoDao.selectCustomerInfoByParam(customerInfo);
		return new PageInfo<CustomerInfo>(customerInfoList);
	}

	@Transactional
	public Map<String, Object> saveCustomerInfo(CustomerInfo customerInfo) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int result = (customerInfo.getId() != null && customerInfo.getId() != 0)
				? customerInfoDao.updateByPrimaryKeySelective(customerInfo)
				: customerInfoDao.insertSelective(customerInfo);
		if (0 != result) {
			resultMap.put("customerInfoId", customerInfo.getId());
			resultMap.put("flag", true);
			resultMap.put("msg", "保存成功");
		} else {
			resultMap.put("flag", false);
			resultMap.put("msg", "保存失败");
		}
		return resultMap;
	}

	@Transactional
	public int deleteCustomerByCustomerId(Long customerId) {
		return customerInfoDao.deleteByPrimaryKey(customerId);
	}

	public Map<String, Object> editCustomerByCustomerId(Long customerId) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		CustomerInfo customerInfo = customerInfoDao.selectByPrimaryKey(customerId);
		if (customerInfo != null) {
			resultMap.put("customerInfo", customerInfo);
			resultMap.put("flag", true);
			resultMap.put("msg", "保存成功");
		} else {
			resultMap.put("flag", false);
			resultMap.put("msg", "保存失败");
		}
		return resultMap;
	}
}
