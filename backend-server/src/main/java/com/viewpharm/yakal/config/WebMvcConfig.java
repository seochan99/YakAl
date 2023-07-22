package com.viewpharm.yakal.config;

import com.viewpharm.yakal.common.Constants;
import com.viewpharm.yakal.interceptor.LoggerInterceptor;
import com.viewpharm.yakal.interceptor.ConvertJwtToUserIdInterceptor;
import com.viewpharm.yakal.interceptor.UserIdArgumentResolver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.List;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    private final UserIdArgumentResolver userIdArgumentResolver;

    @Autowired
    public WebMvcConfig(final UserIdArgumentResolver userIdArgumentResolver) {
        this.userIdArgumentResolver = userIdArgumentResolver;
    }

    @Override
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> resolvers) {
        WebMvcConfigurer.super.addArgumentResolvers(resolvers);
        resolvers.add(this.userIdArgumentResolver);
    }

    @Override
    public void addInterceptors(final InterceptorRegistry registry) {
        registry.addInterceptor(new LoggerInterceptor()).addPathPatterns("/api/**");
        registry.addInterceptor(new ConvertJwtToUserIdInterceptor())
                .addPathPatterns("/api/**")
                .excludePathPatterns(Constants.NO_NEED_AUTH_URLS);
    }
}
