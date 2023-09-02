import {
  CommunityStatistics,
  DoseStatistics,
  ExpertAnalysis,
  IconButtonBox,
  InnerBoxTitle,
  NotificationStatistics,
  OCRAnalysis,
  Outer,
  PartnerAnalysis,
  UserStatistics,
} from "@/admin/page/main/dashboard/style.ts";

import KeyboardArrowRightOutlinedIcon from "@mui/icons-material/KeyboardArrowRightOutlined";

export function Dashboard() {
  return (
    <Outer>
      <UserStatistics>
        <InnerBoxTitle>
          이용자 수 통계
          <IconButtonBox>
            <KeyboardArrowRightOutlinedIcon />
          </IconButtonBox>
        </InnerBoxTitle>
      </UserStatistics>
      <DoseStatistics>
        <InnerBoxTitle>
          복약 통계
          <IconButtonBox>
            <KeyboardArrowRightOutlinedIcon />
          </IconButtonBox>
        </InnerBoxTitle>
      </DoseStatistics>
      <NotificationStatistics>
        <InnerBoxTitle>
          알림 통계
          <IconButtonBox>
            <KeyboardArrowRightOutlinedIcon />
          </IconButtonBox>
        </InnerBoxTitle>
      </NotificationStatistics>
      <CommunityStatistics>
        <InnerBoxTitle>
          커뮤니티 통계
          <IconButtonBox>
            <KeyboardArrowRightOutlinedIcon />
          </IconButtonBox>
        </InnerBoxTitle>
      </CommunityStatistics>
      <OCRAnalysis>
        <InnerBoxTitle>
          OCR 분석
          <IconButtonBox>
            <KeyboardArrowRightOutlinedIcon />
          </IconButtonBox>
        </InnerBoxTitle>
      </OCRAnalysis>
      <ExpertAnalysis>
        <InnerBoxTitle>
          전문가 등록 현황
          <IconButtonBox>
            <KeyboardArrowRightOutlinedIcon />
          </IconButtonBox>
        </InnerBoxTitle>
      </ExpertAnalysis>
      <PartnerAnalysis>
        <InnerBoxTitle>
          제휴 기관 등록 현황
          <IconButtonBox>
            <KeyboardArrowRightOutlinedIcon />
          </IconButtonBox>
        </InnerBoxTitle>
      </PartnerAnalysis>
    </Outer>
  );
}
