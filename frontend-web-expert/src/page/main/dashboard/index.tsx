import { EnrollBox, EnrollText, IconText, YakAlIcon, EnrollButton, DoctorIcon } from "./style";

function Dashboard() {
  return (
    <>
      <EnrollBox>
        <IconText>
          <YakAlIcon />
          <EnrollText>약국이나 병원을 본 서비스에 등록합니다.</EnrollText>
        </IconText>
        <EnrollButton to="/registration">
          <span>제휴 문의</span>
        </EnrollButton>
      </EnrollBox>
      <EnrollBox>
        <IconText>
          <DoctorIcon />
          <EnrollText>서비스를 이용하려면 전문가 인증이 필요합니다.</EnrollText>
        </IconText>
        <EnrollButton to="/certification">
          <span>인증하기</span>
        </EnrollButton>
      </EnrollBox>
    </>
  );
}

export default Dashboard;
