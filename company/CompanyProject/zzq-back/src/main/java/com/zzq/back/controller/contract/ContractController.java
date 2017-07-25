package com.zzq.back.controller.contract;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("contract")
public class ContractController {

	@RequestMapping(value="list",method = RequestMethod.GET)
	public String list(){
		return "contract/contractList";
	}
}
