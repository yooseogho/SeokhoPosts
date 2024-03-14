package com.example.demo;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableGlobalMethodSecurity(securedEnabled = true) // @Secured 애너테이션 활성화
public class SecurityConfig {

//    @Autowired
//    private CustomAuthenticationFailureHandler customAuthenticationFailureHandler;

	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
	    http
	        .csrf().disable()
	        .formLogin()
	            .loginPage("/login_page")
	            .loginProcessingUrl("/login")
	            .defaultSuccessUrl("/", true)  
	        .and()
	        .authorizeRequests().antMatchers("/write_page").hasRole("USER")  // 'ROLE_' 접두어를 추가하였습니다.
	        .and()
	        .exceptionHandling().accessDeniedPage("/login_page")  
	        .and()
	        .logout().logoutUrl("/logout").logoutSuccessUrl("/");

	    return http.build();
	}


}
