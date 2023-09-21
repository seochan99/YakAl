import {
  BackButton,
  BackIcon,
  BelongInputBox,
  Header,
  InnerBox,
  InputBox,
  MainHeader,
  MainSection,
  Outer,
  StyledInput,
  StyledInputLabel,
  Title,
  UnverifiedIcon,
  VerifiedIcon,
  VerifiedText,
} from "./style.ts";
import { EJob } from "../../../../type/job.ts";

function MyInfo() {
  const name = "홍길동";
  const birthday = new Date("2022-01-01");
  const tel = "010-9999-9999";
  const job = EJob.DOCTOR;
  const department = "가정의학과";

  const formattedBirthday = `${birthday.getFullYear()}. ${
    birthday.getMonth() + 1 < 10 ? "0".concat((birthday.getMonth() + 1).toString()) : birthday.getMonth() + 1
  }. ${birthday.getDate()}.`;

  const jobDetail: string | undefined =
    department && job ? department + " " + (job ? (job === EJob.DOCTOR ? "의사" : "약사") : "") : undefined;

  return (
    <Outer>
      <Header>
        <BackButton to="/expert">
          <BackIcon />
          대시보드로
        </BackButton>
      </Header>
      <MainSection>
        <MainHeader>
          <Title>내 정보</Title>
          {true ? (
            <VerifiedText>
              <VerifiedIcon />
              전문가 인증이 완료된 사용자입니다.
            </VerifiedText>
          ) : (
            <VerifiedText>
              <UnverifiedIcon />
              전문가 인증이 완료되지 않은 사용자입니다.
            </VerifiedText>
          )}
        </MainHeader>
        <InnerBox>
          <InputBox>
            <StyledInputLabel>성함</StyledInputLabel>
            <StyledInput value={name} readOnly={true} />
          </InputBox>
          <InputBox>
            <StyledInputLabel>생년월일</StyledInputLabel>
            <StyledInput value={formattedBirthday} readOnly={true} />
          </InputBox>
          <InputBox>
            <StyledInputLabel>직종 및 분과</StyledInputLabel>
            <StyledInput value={jobDetail} readOnly={true} />
          </InputBox>
          <InputBox>
            <StyledInputLabel>연락처</StyledInputLabel>
            <StyledInput value={tel} readOnly={true} />
          </InputBox>
          <BelongInputBox>
            <StyledInputLabel>소속</StyledInputLabel>
            <StyledInput value={"중앙대학교 부속병원"} readOnly={true} />
          </BelongInputBox>
        </InnerBox>
      </MainSection>
    </Outer>
  );
}

export default MyInfo;
