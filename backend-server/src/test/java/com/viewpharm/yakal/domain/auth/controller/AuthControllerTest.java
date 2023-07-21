package com.viewpharm.yakal.domain.auth.controller;

import com.viewpharm.yakal.annotation.RestDocsTest;
import com.viewpharm.yakal.documentation.MockMvcFactory;
import com.viewpharm.yakal.service.AuthService;
import com.viewpharm.yakal.type.ELoginProvider;
import com.viewpharm.yakal.controller.AuthController;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.springframework.http.MediaType;
import org.springframework.restdocs.RestDocumentationContextProvider;
import org.springframework.restdocs.mockmvc.MockMvcRestDocumentation;
import org.springframework.restdocs.mockmvc.RestDocumentationRequestBuilders;
import org.springframework.restdocs.payload.FieldDescriptor;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import static com.epages.restdocs.apispec.ResourceDocumentation.resource;
import static com.viewpharm.yakal.documentation.DocumentUtils.getDocumentRequest;
import static com.viewpharm.yakal.documentation.DocumentUtils.getDocumentResponse;
import static org.springframework.restdocs.payload.JsonFieldType.BOOLEAN;
import static org.springframework.restdocs.payload.JsonFieldType.NULL;
import static org.springframework.restdocs.payload.JsonFieldType.STRING;
import static org.springframework.restdocs.payload.PayloadDocumentation.fieldWithPath;
import static org.springframework.restdocs.payload.PayloadDocumentation.responseFields;

@DisplayName("인증 API")
@RestDocsTest
public class AuthControllerTest {

    @InjectMocks
    private AuthController authController;

    @Mock
    private AuthService authService;

    @Test
    @DisplayName("카카오 리다이렉트 URL 받아오기")
    void testGetKakaoRedirectUrl(RestDocumentationContextProvider contextProvider) throws Exception {
        var responseFieldDescriptors = new FieldDescriptor[]{
                fieldWithPath("success").type(BOOLEAN).description("성공 여부"),
                fieldWithPath("data.url").type(STRING).description("Kakao 소셜 로그인 리다이렉트 URL"),
                fieldWithPath("error").type(NULL).description("에러 정보(성공: null)"),
        };

        Mockito.when(authService.getRedirectUrl(ELoginProvider.KAKAO))
                .thenReturn("https://kauth.kakao.com/oauth/authorize?client_id={KAKAO_CLIENT_ID}&redirect_uri={KAKAO_REDIRECT_URL}");

        MockMvcFactory.getRestDocsMockMvc(contextProvider, "localhost", authController)
                .perform(RestDocumentationRequestBuilders.get("/api/auth/kakao")
                        .contentType(MediaType.APPLICATION_JSON))
                .andDo(MockMvcResultHandlers.print())
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.content().string("{\"success\":true,\"data\":{\"url\":\"https://kauth.kakao.com/oauth/authorize?client_id={KAKAO_CLIENT_ID}&redirect_uri={KAKAO_REDIRECT_URL}\"},\"error\":null}"))
                .andDo(MockMvcRestDocumentation.document("get-v1-get-kakao-redirect-url",
                        getDocumentRequest(),
                        getDocumentResponse(),
                        responseFields(responseFieldDescriptors)
                ));
    }
}
