package com.zzq.back.controller.customer;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.zzq.back.entity.CustomerInfo;
import com.zzq.back.service.customer.CustomerInfoService;
import com.zzq.back.utils.ResultUtils;

@Controller
@RequestMapping("customerInfo")
public class CustomerInfoController {

	@Autowired
	CustomerInfoService customerInfoService;

	@RequestMapping(value = "list",method = RequestMethod.GET)
	public String list(CustomerInfo customerInfo, ModelMap model, Integer pageNum) {
		PageInfo<CustomerInfo> pageInfo = customerInfoService.queryListByPage(pageNum, customerInfo);
		model.put("customerInfo", customerInfo);
		model.put("pageInfo", pageInfo);
		return "customer/customerList";
	}
	
	@RequestMapping(value = "save")
	@ResponseBody
	public Map<String, Object> save(CustomerInfo customerInfo) {
		return customerInfoService.saveCustomerInfo(customerInfo);
	}

	@RequestMapping(value = "edit")
	@ResponseBody
	public Map<String,Object> edit(Long customerId){
		return customerInfoService.editCustomerByCustomerId(customerId);
	}
	
	@RequestMapping(value = "delete")
	@ResponseBody
	public Map<String, Object> delete(Long customerId) {
		return (0 != customerInfoService.deleteCustomerByCustomerId(customerId))
				? ResultUtils.buildFlagAndMsgMap(true, "成功删除业主信息") : ResultUtils.buildFlagAndMsgMap(false, "删除业主信息失败");
	}
}
