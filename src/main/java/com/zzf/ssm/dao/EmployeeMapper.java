package com.zzf.ssm.dao;

import com.zzf.ssm.bean.Employee;
import com.zzf.ssm.bean.EmployeeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
    long countByExample(EmployeeExample example);

    int deleteByExample(EmployeeExample example);

    int deletePrimaryKey(Integer empId);
    
    int insert(Employee record);

    int insertSelective(Employee record);

    List<Employee> selectByExample(EmployeeExample example);
    
    List<Employee> selectByExampleWithDept(EmployeeExample example);
    
    Employee selectByPrimaryKeyWithDept(Integer empId);

    int updateByExampleSelective(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByExample(@Param("record") Employee record, @Param("example") EmployeeExample example);
    
    int updateByPrimaryKeySelective(Employee record);

	List<Employee> selectEmp(String text);
}