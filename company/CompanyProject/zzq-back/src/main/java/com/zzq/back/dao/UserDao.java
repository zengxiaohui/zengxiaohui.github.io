package com.zzq.back.dao;

import java.util.Set;

import com.zzq.back.entity.User;

public interface UserDao {
	/**
	 * @param username
	 * @return
	 */
	User selectByUsername(String username);
	
	/**
	 * @return
	 */
	Set<String> selectRolesByUsername();

	/**
	 * @return
	 */
	Set<String> selectPermissionsByUsername();
	
}