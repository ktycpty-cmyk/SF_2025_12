package org.zerock.security;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.web.servlet.handler.HandlerMappingIntrospector;

import lombok.extern.log4j.Log4j2;

@Configuration
@Log4j2
@EnableWebSecurity
public class SecurityConfig {

	@Autowired
	private DataSource dataSource;

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

		log.info("--------------filterChain-----------------");

		http.authorizeHttpRequests(config -> {
			config.requestMatchers(AntPathRequestMatcher.antMatcher("/project/**")).authenticated();
			config.anyRequest().permitAll();
		});

		http.formLogin(config -> {
			config.loginPage("/account/login");
			config.successHandler(new CustomLoginSuccessHandler());
		});

		http.rememberMe(config -> {
			config.key("my-key");
			config.tokenRepository(persistentTokenRepository());
			config.tokenValiditySeconds(60 * 60 * 24 * 30);
		});

		http.logout(config -> {
			config.logoutUrl("/account/logout");
			config.logoutSuccessUrl("/account/login");
			config.deleteCookies("JSESSIONID", "remember-me");
		});

		http.csrf(config -> {
			config.disable();
		});

		http.exceptionHandling(config -> {
			config.accessDeniedHandler(new Custom403Handler());
		});

		return http.build();
	}

	@Bean(name = "mvcHandlerMappingIntrospector")
	public HandlerMappingIntrospector mvcHandlerMappingIntrospector() {
		return new HandlerMappingIntrospector();
	}

	@Bean
	public PersistentTokenRepository persistentTokenRepository() {
		JdbcTokenRepositoryImpl tokenRepository = new JdbcTokenRepositoryImpl();
		tokenRepository.setDataSource(dataSource);

		return tokenRepository;
	}

	@Bean
	public PasswordEncoder passwordEncoder() {

		return new BCryptPasswordEncoder();
	}

}
