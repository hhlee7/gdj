package com.example.oauth2client.service;

import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.example.oauth2client.dto.CustomOAuth2User;

@Service
public class CustomOAuth2Service extends DefaultOAuth2UserService {
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		CustomOAuth2User customOAuth2User = null;
		
		if(userRequest.getClientRegistration().getRegistrationId().equals("naver")) {
			System.out.println("--- 네이버 로그인 ---");
			// 인증 서버 아이디값 디버깅
			System.out.println(userRequest.getClientRegistration().getRegistrationId()); // naver
			
			OAuth2User oAuth2User = super.loadUser(userRequest);
			// attributes 속성 디버깅
			System.out.println(oAuth2User.getAttributes());
			// attributes : {resultcode=00, message=success, response={id=gun0clZSXJsP3b-GHfDfHfHqzUDQ-YPujD-Yk7qL0PA, email=xxx@naver.com, mobile=010-xxxx-xxxx, mobile_e164=+8210xxxxxxxx, name=xxx}}
			// role : OAUTH2_USER
			
			customOAuth2User = new CustomOAuth2User(oAuth2User.getAttributes(), "ROLE_NAVER");
			// role : ROLE_NAVER
			
		} else if (userRequest.getClientRegistration().getRegistrationId().equals("google")) {
			System.out.println("--- 구글 로그인 ---");
			// 인증 서버 아이디값 디버깅
			System.out.println(userRequest.getClientRegistration().getRegistrationId()); // google
			
			OAuth2User oAuth2User = super.loadUser(userRequest);
			// attributes 속성 디버깅
			System.out.println(oAuth2User.getAttributes());
			// attributes : {sub=107763959099797561835, name=이현호, given_name=현호, family_name=이, picture=https://lh3.googleusercontent.com/a/ACg8ocJ9ULtzJ_7jsfqOsYdxYmNhXWEGhrR24ujSSDwU2L_30H46=s96-c, email=beady777@gmail.com, email_verified=true}
			// role : OAUTH2_USER
			
			customOAuth2User = new CustomOAuth2User(oAuth2User.getAttributes(), "ROLE_GOOGLE");
			// role : ROLE_GOOGLE
			
		} else {
			System.out.println("인증 서버 오류");
		}
				
		return customOAuth2User;
	}
}
