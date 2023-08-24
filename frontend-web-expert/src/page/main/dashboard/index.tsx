import {
  EnrollBox,
  EnrollText,
  IconText,
  YakAlIcon,
  EnrollButton,
  DoctorIcon,
  CertTextBox,
  SubEnrollText,
  Blue,
  Outer,
} from "./style";

function Dashboard() {
  return (
    <Outer>
      <EnrollBox>
        <IconText>
          <YakAlIcon />
          <EnrollText>
            약국이나 병원을 <Blue>약 알</Blue>에 등록합니다.
          </EnrollText>
        </IconText>
        <EnrollButton to="/registration">기관 등록</EnrollButton>
      </EnrollBox>
      <EnrollBox>
        <IconText>
          <DoctorIcon />
          <CertTextBox>
            <EnrollText>서비스를 이용하려면 전문가 인증이 필요합니다.</EnrollText>
            <SubEnrollText>
              <Blue>약 알</Blue>에 등록된 기관의 전문가만 인증이 가능합니다.
            </SubEnrollText>
          </CertTextBox>
        </IconText>
        <EnrollButton to="/certification">인증하기</EnrollButton>
      </EnrollBox>
    </Outer>
  );
}

export default Dashboard;
