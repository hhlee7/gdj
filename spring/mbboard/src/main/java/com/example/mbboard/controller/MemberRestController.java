package com.example.mbboard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.example.mbboard.service.IloginService;

@RestController
public class MemberRestController {
	@Autowired IloginService loginService;
	
	@GetMapping("/isId/{id}")
	public boolean isId(@PathVariable String id) {
        return loginService.isDuplicateId(id);
    }

}
