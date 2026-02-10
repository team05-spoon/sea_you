package com.sea_you.auth;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import jakarta.servlet.DispatcherType;

@Configuration
@EnableWebSecurity
public class webSecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            .cors(cors -> cors.disable())
            .authorizeHttpRequests(request -> request
                .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
                

                .requestMatchers("/", "/Member/MemberWriteForm", "/Member/MemberWrite", "/Member/MemberLoginForm","/Beach/**", "/Place/**","/Member/jusoPopup","/Member/toggleFollow","/SearchList","/search","/autocomplete","/Member/IdCheck","/Chat/**").permitAll()
                .requestMatchers("/css/**", "/js/**", "/m_images/**", "/video/**", "/images/**","/ChatBot/**").permitAll()
                .requestMatchers("/comments/**").hasAnyRole("USER", "ADMIN")
                .requestMatchers("/Member/**", "/Notice/**", "/BookMark/**", "/Report/ReportMemberWriteForm","/Report/ReportBoardWriteForm","/Message/**").hasAnyRole("USER", "ADMIN")
                .requestMatchers("/Report/**").hasAnyRole("ADMIN")
                .anyRequest().authenticated()
            );


        http.formLogin(formLogin -> formLogin
            .loginPage("/Member/MemberLoginForm")
            .loginProcessingUrl("/m_spring_security_check")
            .usernameParameter("m_username")
            .passwordParameter("m_password")
            .defaultSuccessUrl("/", true)
            .failureUrl("/Member/MemberLoginForm?error")
            .permitAll()
        );


		http.logout((logout) -> logout
				.logoutUrl("/logout")
				.logoutSuccessUrl("/")
				.permitAll()
				);

        return http.build();
    }
}