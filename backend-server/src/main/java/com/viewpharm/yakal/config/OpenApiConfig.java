package com.viewpharm.yakal.config;

import com.viewpharm.yakal.annotation.DisableSwaggerSecurity;
import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.Operation;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import org.springdoc.core.customizers.OperationCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.method.HandlerMethod;

import java.util.Collections;

/**
 * Swagger springdoc-ui Configuration file
 */
@Configuration
public class OpenApiConfig {

    @Bean
    public OperationCustomizer operationCustomizer() {
        return (Operation operation, HandlerMethod handlerMethod) -> {
            if (handlerMethod.getMethodAnnotation(DisableSwaggerSecurity.class) != null) {
                operation.setSecurity(Collections.emptyList());
            }

            return operation;
        };
    }

    @Bean
    public OpenAPI openAPI() {
        Info info = new Info()
                .title("YakAl REST API Docs")
                .version("v0.0.1-SNAPSHOT")
                .description("약물 복용 관리 서비스 YakAl의 REST API 문서입니다.")
                .license(new License()
                        .name("Apache License Version 2.0")
                        .url("https://www.apache.org/licenses/LICENSE-2.0"));

        final String jwtSchemeName = "jwt token";
        final SecurityRequirement securityRequirement = new SecurityRequirement().addList(jwtSchemeName);

        final Components components = new Components()
                .addSecuritySchemes(jwtSchemeName, new SecurityScheme()
                .name("Authorization")
                .type(SecurityScheme.Type.HTTP)
                .in(SecurityScheme.In.HEADER)
                .scheme("bearer")
                .bearerFormat("JWT"));

        return new OpenAPI()
                .info(info)
                .components(components)
                .addSecurityItem(securityRequirement);
    }
}
