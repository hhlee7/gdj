package com.example.jwt.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    //AuthenticationManager가 인자로 받을 AuthenticationConfiguraion 객체 생성자 주입
    private AuthenticationConfiguration authenticationConfiguration;
    private final JWTUtil jwtUtil;
    
    public SecurityConfig(AuthenticationConfiguration authenticationConfiguration, JWTUtil jwtUtil) {
        this.authenticationConfiguration = authenticationConfiguration;
        this.jwtUtil = jwtUtil;
    }
    
    
    //AuthenticationManager Bean 등록
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration configuration) throws Exception {
        return configuration.getAuthenticationManager();
    }
   
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity httpSecurity) throws Exception {
		
		
		
		// csrf disable
		httpSecurity.csrf((configurer) -> configurer.disable());

		// SpringSecurity가 기본 제공하는 세션기반의 기본 로그인 방식(form -> action으로 진행하는...)의 필터를 사용 하지 안 함
        // 기본 로그인 방식의 필터를 상속받아서 JWT토큰 발급이 가능한 필터클래스를 새로 생성하여 사용 함.
		httpSecurity.formLogin((configurer) -> configurer.disable());

		// HTTP Basic 인증 방식 설정 (브라우저 팝업으로 사용자 이름과 비밀번호를 입력받는 방식) 사용 안함
		httpSecurity.httpBasic((configurer) -> configurer.disable());

		// 경로별 인가 설정
		httpSecurity.authorizeHttpRequests((matcherRegistry) -> 
				matcherRegistry.requestMatchers("/login", "/", "/addUser").permitAll()
								.requestMatchers("/admin").hasRole("ADMIN")
								.anyRequest().authenticated()); // header JWT 토큰값을 전송한 요소
		
		// 토근을 가진 요청이라면 인증 필요 X / JWT 토큰을 검증하는 필터 등록(JWTLoginFilter 앞에 등록해야함)
		httpSecurity.addFilterBefore(new JWTRequestFilter(jwtUtil), JWTLoginFilter.class);
		
		// 재정의 한 JWTLoginFilter 등록
		httpSecurity.addFilterAt(new JWTLoginFilter(this.authenticationManager(this.authenticationConfiguration), jwtUtil),
													UsernamePasswordAuthenticationFilter.class);

		// ★★★★★ 세션 설정 : JWT 사용시 세션은 STATELESS(상태값 저장 안함)로 설정 ★★★★★
		httpSecurity.sessionManagement((configurer) -> configurer.sessionCreationPolicy(SessionCreationPolicy.STATELESS));
		return httpSecurity.build();
	}

    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
