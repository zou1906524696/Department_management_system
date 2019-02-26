package com.zzf.ssm.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.zzf.ssm.bean.Employee;

/*
 * 使用Spring测试模块提供的测试请求功能
 * */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServelt-servelt.xml"})

public class MvcTest {

	@Autowired
	WebApplicationContext context;
	
	MockMvc mockMvc;

	@Before
	public void initMokcMvc(){
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testpage() throws Exception{
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5"))
			.andReturn();
		
		//请求成功后，请求域中有pageInfo，进行验证
		
		MockHttpServletRequest request = result.getRequest();
		PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
		
		System.out.println("当前页码" + pi.getPageNum());
		System.out.println("总页码" + pi.getPages());
		System.out.println("总记录数" + pi.getTotal());
		System.out.println("连续显示的页码");
		
		int[] nums = pi.getNavigatepageNums();
		for(int i : nums){
			System.out.println(" " + i);
		}
		
		//获取员工数据
		
		List<Employee>  list = pi.getList();
		for(Employee employee : list){
			System.out.println("ID " + employee.getEmpId()+"==>name:" + employee.getEmpName());
		}
		
	}
}
