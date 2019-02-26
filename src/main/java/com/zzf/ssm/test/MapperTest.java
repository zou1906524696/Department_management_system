package com.zzf.ssm.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zzf.ssm.bean.Department;
import com.zzf.ssm.bean.Employee;
import com.zzf.ssm.dao.DepartmentMapper;
import com.zzf.ssm.dao.EmployeeMapper;

/*
 * 测试dao工作 
*/
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void TestCRUD(){
		System.out.println(departmentMapper); 
		
		//1.插入几个部门
		
//		departmentMapper.insertSelective(new Department(null,"开发部"));
//		departmentMapper.insertSelective(new Department(null,"测试部"));
		
		//2.员工插入
		
		//employeeMapper.insertSelective(new Employee(null,"jack","M","jack@qq.com",1));
		
		//3.批量插入多个员工，可以执行批量操作的session
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i = 0;i<1000;i++){
			String uid = UUID.randomUUID().toString().substring(0,5)+i;
			mapper.insertSelective(new Employee(null,uid,"M",uid+"@qq.com",1));
		}
		System.out.println("执行完成");
		
	}
}
