package com.zzf.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zzf.ssm.bean.Department;
import com.zzf.ssm.bean.Msg;
import com.zzf.ssm.service.DepartmentService;

/*
 * 处理
 * */
@Controller
public class DepartmentController {
	@Autowired
	private DepartmentService departmentService;
	
	
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts(){ 
		List<Department> list = departmentService.getDepts();
		return Msg.success().add("depts", list);
	}
	
}
