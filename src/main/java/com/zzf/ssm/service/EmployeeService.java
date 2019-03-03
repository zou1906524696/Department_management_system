package com.zzf.ssm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zzf.ssm.bean.EmployeeExample.Criteria;
import com.zzf.ssm.bean.Employee;
import com.zzf.ssm.bean.EmployeeExample;
import com.zzf.ssm.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	/*
	 * 查询所有员工
	 * */
	public List<Employee> getAll() {
		// TODO Auto-generated method stub
		return employeeMapper.selectByExampleWithDept(null);
	}
	public void saveEmp(Employee employee) {
		// TODO Auto-generated method stub
		System.out.println(employee.getD_id() + employee.getEmail() + employee.getEmpName()
		
				+ employee.getGender());
		employeeMapper.insertSelective(employee);
	}
	/**
	 * 检验用户名是否可用
	 * */
	public boolean CheckUser(String empName) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}
	//按照员工id查询员工
	public Employee getEmp(Integer id) {
		// TODO Auto-generated method stub
		Employee employee = employeeMapper.selectByPrimaryKeyWithDept(id);
		return employee;
	}
	//按照与id更新
	public void updateEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	
	//刪除
	public void deleteEmp(Integer id) {
		// TODO Auto-generated method stub
		employeeMapper.deletePrimaryKey(id);
	}
	public void deleteBatch(List<Integer> ids) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}
	public List<Employee> selectEmp(String text) {
		// TODO Auto-generated method stub
		return employeeMapper.selectEmp(text);
	}

}
