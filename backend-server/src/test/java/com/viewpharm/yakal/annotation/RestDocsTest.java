package com.viewpharm.yakal.annotation;

import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.boot.test.autoconfigure.restdocs.AutoConfigureRestDocs;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.restdocs.RestDocumentationExtension;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @See AutoConfigureRestDocs
 * @see AutoConfigureMockMvc
 */
@Documented
@Tag("restDocs")
@AutoConfigureMockMvc
@AutoConfigureRestDocs
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@ExtendWith({MockitoExtension.class, RestDocumentationExtension.class})
public @interface RestDocsTest {
}
