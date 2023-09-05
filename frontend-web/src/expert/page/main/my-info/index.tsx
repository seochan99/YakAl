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
import { useGetUserQuery } from "@/expert/api/user.ts";
import LoadingPage from "@/expert/page/loading-page";
import ErrorPage from "@/expert/page/error-page";

function MyInfo() {
  const { data, isLoading, isError } = useGetUserQuery(null);

  if (isLoading) {
    return <LoadingPage />;
  }

  if (isError || !data) {
    return <ErrorPage />;
  }

  const birthday = data.birthday;
  const formattedBirthday = `${birthday.getFullYear()}. ${
    birthday.getMonth() + 1 < 10 ? "0".concat((birthday.getMonth() + 1).toString()) : birthday.getMonth() + 1
  }. ${birthday.getDate()}.`;

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
          {data ? (
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
            <StyledInput value={data.name} readOnly={true} />
          </InputBox>
          <InputBox>
            <StyledInputLabel>생년월일</StyledInputLabel>
            <StyledInput value={formattedBirthday} readOnly={true} />
          </InputBox>
          <InputBox>
            <StyledInputLabel>직종 및 분과</StyledInputLabel>
            <StyledInput />
          </InputBox>
          <InputBox>
            <StyledInputLabel>연락처</StyledInputLabel>
            <StyledInput value={data.tel} readOnly={true} />
          </InputBox>
          <BelongInputBox>
            <StyledInputLabel>소속</StyledInputLabel>
            <StyledInput readOnly={true} />
            <StyledInput readOnly={true} />
          </BelongInputBox>
        </InnerBox>
      </MainSection>
    </Outer>
  );
}

export default MyInfo;
