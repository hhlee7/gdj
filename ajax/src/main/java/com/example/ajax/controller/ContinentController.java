package com.example.ajax.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.ajax.mapper.ContinentMapper;

@Controller
public class ContinentController {
	@Autowired ContinentMapper continentMapper;
	
	@GetMapping({"/", "/continentList"})
	public String continentList(@RequestParam(required = false) Integer continent,
								@RequestParam(required = false) Integer country,
								Model model) {
		
		// 대륙 목록 출력
		model.addAttribute("continentList", continentMapper.selectContinentList());
		
		// 대륙 선택 시 나라 목록 조회
		if(continent != null) {
			model.addAttribute("countryList", continentMapper.selectCountryList(continent));
		}
		
		// 나라 선택 시 도시 목록 조회
		if(country != null) {
			model.addAttribute("cityList", continentMapper.selectCityList(country));
		}
		
		return "continentList";
	}
}
