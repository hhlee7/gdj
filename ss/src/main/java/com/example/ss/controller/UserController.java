package com.example.ss.controller;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.ss.dto.UserDto;
import com.example.ss.service.UserService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UserController {
	private UserService userService;
	public UserController(UserService userService) {
		this.userService = userService;
	}

	@GetMapping("/addUser")
	public String addUser() {
		return "addUser";
	}
	
	@PostMapping("/addUserAction")
	public String addUserAction(UserDto userDto) {
		userService.addUser(userDto);
		return "redirect:/login";
	}
	
	@GetMapping("/user/editUser")
	public String editUser() {
		return "editUser";
	}
	
	@PostMapping("/user/editUserAction")
	public String editUserAction(String currentPassword, String newPassword) {
		int row = userService.editUser(currentPassword, newPassword);
		if(row != 1) {
			return "editUser";
		}
		return "redirect:/logout";
	}
	
	@PostMapping("user/delete")
	public String deleteUser() {
		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		userService.deleteUser(username);
		return "redirect:/logout";
	}
}
