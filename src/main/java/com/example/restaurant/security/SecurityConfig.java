package com.example.restaurant.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

import com.example.restaurant.service.CustomOAuth2Service;

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
            matcherRegistry
                .requestMatchers("/", "/WEB-INF/view/**", "/login", "/oauth2/**", "/css/**", "/js/**", "/images/**")
                .permitAll()
                .anyRequest().authenticated()
        );

        // 폼 로그인은 disable (ID/PW 로그인 X, 오직 소셜 로그인만 사용)
        httpSecurity.formLogin(formLoginConfigurer -> formLoginConfigurer.disable());

        // OAuth2 로그인 설정
        httpSecurity.oauth2Login(oAuth2LoginConfigurer ->
            oAuth2LoginConfigurer
                .loginPage("/login")
                .defaultSuccessUrl("/restaurantTableReservation", true)
                .userInfoEndpoint(userInfoEndpointConfig -> 
                    userInfoEndpointConfig.userService(customOAuth2Service)
                )
        );

        return httpSecurity.build();
    }
}
