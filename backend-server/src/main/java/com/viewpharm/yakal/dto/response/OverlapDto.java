package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;
import java.util.List;

@Getter
@Builder
public class OverlapDto {
    private String ATCCode;
    private List<String> KDCodes;
}
