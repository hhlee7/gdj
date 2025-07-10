package com.example.oauth2client.security;

import com.example.oauth2client.service.CustomOAuth2Service;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final CustomOAuth2Service customOAuth2Service;
    SecurityConfig(CustomOAuth2Service customOAuth2Service) {
        this.customOAuth2Service = customOAuth2Service;
    }
	@Bean
	SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {
		
		httpSecurity.csrf(csrfConfigurer -> csrfConfigurer.disable());
		
		// 인가 설정
		httpSecurity.authorizeHttpRequests(matcherRegistry ->
					matcherRegistry.requestMatchers("/", "/WEB-INF/view/**", "/login/**", "/oauth2/**").permitAll()
									.anyRequest().authenticated());
		
		// 로그인 설정
		httpSecurity.formLogin(formLoginConfigurer -> formLoginConfigurer.disable());
		
		// OAuth2 로그인 설정
		// httpSecurity.oauth2Login(Customizer.withDefaults()); // GET으로 /login 요청이 오면 가로채서 OAuth2 기본 설정(로그인 방법)을 사용
		httpSecurity.oauth2Login(loginConfigurer ->
					loginConfigurer.loginPage("/login")
					.userInfoEndpoint(a -> a.userService(customOAuth2Service)));
		
		// 로그아웃 설정
		httpSecurity.logout((logoutConfigurer) ->
				logoutConfigurer.logoutUrl("/logout")
								.logoutSuccessUrl("/login")
								.invalidateHttpSession(true)
								.clearAuthentication(true)
							    .deleteCookies("JSESSIONID"));
		
		return httpSecurity.build();
	}
}
