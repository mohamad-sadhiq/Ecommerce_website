package com.ecommerce.config;

import com.ecommerce.model.User;
import com.ecommerce.service.CartService;
import com.ecommerce.service.CustomUserDetailsService;
import jakarta.servlet.DispatcherType; // <--- NEW IMPORT REQUIRED
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private CustomUserDetailsService userDetailsService;

    @Autowired
    private CartService cartService;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(auth -> auth
                        // 1. CRITICAL FIX: Allow internal error forwards to break the infinite loop!
                        .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ERROR).permitAll()

                        // 2. Permit Static Resources
                        .requestMatchers("/css/**", "/js/**", "/images/**", "/webjars/**", "/static/**", "/error").permitAll()

                        // 3. Public URLs (Added /stores to the list)
                        .requestMatchers("/", "/login", "/register", "/products/**", "/categories/**", "/stores").permitAll()

                        // 4. Admin Protected
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        .anyRequest().authenticated()
                )
                .formLogin(form -> form
                        .loginPage("/login")
                        .loginProcessingUrl("/login")
                        .usernameParameter("email")
                        .successHandler((request, response, authentication) -> {
                            String email = authentication.getName();
                            User user = userDetailsService.getUserByEmail(email);
                            HttpSession session = request.getSession();
                            session.setAttribute("loggedInUser", user);
                            session.setAttribute("cart", cartService.getCartDetails(user));

                            String redirectUrl = request.getParameter("redirect");
                            if (redirectUrl != null && !redirectUrl.isEmpty()) {
                                response.sendRedirect(redirectUrl);
                            } else if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                                response.sendRedirect("/admin/dashboard");
                            } else {
                                response.sendRedirect("/");
                            }
                        })
                        .failureUrl("/login?error=true")
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/login?logout=true")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                        .permitAll()
                );

        return http.build();
    }
}