package com.zzf.ssm.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
//处理员工的CRUD
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zzf.ssm.bean.Employee;
import com.zzf.ssm.bean.Msg;
import com.zzf.ssm.service.EmployeeService;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	/*
	
	 * 查询按钮
	 * */
	@RequestMapping(value="/emp_search/{text}",method=RequestMethod.GET)
	public String searchEmp(@PathVariable("text")String text, Model model){
		List<Employee> emps = employeeService.selectEmp(text);
		PageInfo page = new PageInfo(emps, 5);
		model.addAttribute("pageInfo", page);
		return "list";
		
	}
	
	
	/**
	 *单个与批量合在一起 
	 * */
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("ids")String ids){
		//批量
		if(ids.contains("-")){
			List<Integer> del_ids = new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(del_ids);
		}else{
			Integer id =Integer.parseInt(ids);
			employeeService.deleteEmp(id);		
		}
		return Msg.success();
	}
	
	
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg saveEmp(Employee employee){
		System.out.println("将要更新的员工信息"+employee.toString());
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	/*
	 *查询id员工 
	 * */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id){
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp",employee);
	}
	

	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkuser(@RequestParam("empName")String empName){
		//先判断用户名是否是合法的表达式
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regx)){
			return Msg.fail().add("va_msg", "用户名必须是6-16位数字与字母的组合或者2-5位中文");
		}
		
		//数据库用户名重复校验
		boolean b = employeeService.CheckUser(empName);
		if(b){
			return Msg.success();
		}else {
			return Msg.fail().add("va_msg", "用户名不可用");
		}
	}
	
	/**
	 * 定义员工保存
	 * */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result){
		if(result.hasErrors()){
			//校验失败后，返回校验信息
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名"+fieldError.getField());
				System.out.println("错误信息"+fieldError.getDefaultMessage());
				map.put(fieldError.getField(),fieldError.getDefaultMessage());
				
			}
			return Msg.fail().add("errorFields", map);
		}else{
			employeeService.saveEmp(employee);
			return Msg.success();	
		}
	}
	
	
	/*
	 * 导入json包
	 * */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// 这不是一个分页

		// 引入pageHelper分页插件
		// 在查询之前调用,传入页码，以及每页大小

		PageHelper.startPage(pn, 5);
		// 后面紧跟的查询是一个分页查询
		List<Employee> emps = employeeService.getAll();
		// 使用pageInfo来包装，只需要将pageInfo交给页面，封装了详细的信息，包括有查询出来的数据
		// 传入连续显示的页数
		PageInfo page = new PageInfo(emps, 5);
		return Msg.success().add("PageInfo",page);
	}

	// 查询员工数据
	// @RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		// 这不是一个分页

		// 引入pageHelper分页插件
		// 在查询之前调用,传入页码，以及每页大小

		PageHelper.startPage(pn, 5);
		// 后面紧跟的查询是一个分页查询
		List<Employee> emps = employeeService.getAll();
		// 使用pageInfo来包装，只需要将pageInfo交给页面，封装了详细的信息，包括有查询出来的数据
		// 传入连续显示的页数
		PageInfo page = new PageInfo(emps, 5);
		model.addAttribute("pageInfo", page);

		return "list";
	}
}
