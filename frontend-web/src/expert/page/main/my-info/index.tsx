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
import LoadingPage from "../../loading-page";
import ErrorPage from "../../error-page";
import { useGetUserQuery } from "../../../api/user.ts";
import { EJob } from "../../../type/job.ts";

function MyInfo() {
  const { data, isLoading, isError } = useGetUserQuery(null);

  if (isLoading) {
    return <LoadingPage />;
  }

  if (isError || !data) {
    return <ErrorPage />;
  }

  const { name, birthday, tel, job, department, belong } = data;

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
